#!/usr/bin/env python3
"""Validate the Gaza WASH assessment evidence-control layer.

This script checks manifest structure, controlled vocabularies, source-claim mappings,
source-binding gates, official trace records, and restricted-source handling.
It can run without local PDF files by default. Use --strict-files to require local
source document paths to exist.
"""

from __future__ import annotations

import argparse
import csv
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ASSESSMENTS = ROOT / "assessments"
MANIFEST = ASSESSMENTS / "manifest.csv"
SOURCE_CLAIM_MATRIX = ASSESSMENTS / "citation_audit" / "source_claim_matrix.csv"
OFFICIAL_TRACE = ASSESSMENTS / "citation_audit" / "official_source_trace.csv"
SOURCE_BINDING_STATUS = ASSESSMENTS / "citation_audit" / "source_binding_status.csv"
EXCLUSION_LOG = ASSESSMENTS / "validation_notes" / "exclusion_log.md"

REQUIRED_DIRS = [
    ASSESSMENTS,
    ASSESSMENTS / "schema",
    ASSESSMENTS / "validation_notes",
    ASSESSMENTS / "citation_audit",
]

MANIFEST_FIELDS = [
    "source_id",
    "title",
    "geography",
    "reporting_period",
    "source_organization",
    "path_or_url",
    "original_or_derived",
    "validation_status",
    "validator_role",
    "manuscript_role",
    "use_limitation",
]

SOURCE_CLAIM_FIELDS = [
    "claim_id",
    "claim_text",
    "source_id",
    "claim_weight",
    "allowed_status",
    "scope_note",
    "manuscript_section",
    "status",
]

OFFICIAL_TRACE_FIELDS = [
    "trace_id",
    "source_id",
    "official_or_primary_location",
    "organization_to_verify",
    "verification_task",
    "status",
    "notes",
]

SOURCE_BINDING_FIELDS = [
    "source_id",
    "expected_path",
    "local_file_status",
    "public_record_status",
    "page_binding_status",
    "manuscript_gate",
    "next_action",
]

ORIGINAL_OR_DERIVED = {"original", "secondary", "derived", "unknown"}
VALIDATION_STATUS = {
    "primary_verified",
    "primary_verified_pending_file",
    "trend_verified",
    "trend_verified_pending_file",
    "context_verified",
    "context_verified_pending_file",
    "background_only",
    "background_only_pending_file",
    "restricted_pending_geography",
    "excluded",
    "unverified",
}
VALIDATOR_ROLES = {
    "core_household_validator",
    "local_hotspot_validator",
    "indicative_trend_validator",
    "infrastructure_recovery_validator",
    "background_mechanism_validator",
    "excluded_or_restricted",
}
CLAIM_WEIGHTS = {"high", "medium", "low", "none"}
ALLOWED_STATUSES = {
    "allowed",
    "allowed_local_only",
    "allowed_indicative_only",
    "allowed_context",
    "allowed_background_only",
    "blocked_pending_scope",
}
TRACE_STATUSES = {"pending", "pending_blocked", "verified", "blocked", "needs_revision"}
LOCAL_FILE_STATUSES = {"present", "missing", "unknown_not_checked"}
PUBLIC_RECORD_STATUSES = {"verified", "secondary_record_found", "not_located", "scope_unresolved"}
PAGE_BINDING_STATUSES = {"bound", "blocked", "not_required"}
MANUSCRIPT_GATES = {
    "allowed",
    "do_not_promote_claims",
    "context_only_pending_official_url",
    "do_not_cite",
    "excluded_pending_scope",
}


def read_csv(path: Path, required_fields: list[str]) -> list[dict[str, str]]:
    if not path.exists():
        raise FileNotFoundError(f"missing required file: {path.relative_to(ROOT)}")
    with path.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        if reader.fieldnames != required_fields:
            raise ValueError(
                f"{path.relative_to(ROOT)} has invalid header. "
                f"Expected {required_fields}; found {reader.fieldnames}"
            )
        return list(reader)


def under_assessments(path_text: str) -> bool:
    if path_text.startswith("http://") or path_text.startswith("https://"):
        return True
    p = Path(path_text)
    return bool(p.parts) and p.parts[0] == "assessments"


def require_unique(rows: list[dict[str, str]], field: str, label: str) -> list[str]:
    errors: list[str] = []
    seen: set[str] = set()
    for i, row in enumerate(rows, start=2):
        value = row[field].strip()
        if value in seen:
            errors.append(f"{label} row {i}: duplicate {field} {value}")
        seen.add(value)
    return errors


def validate_required_objects() -> list[str]:
    errors: list[str] = []
    for d in REQUIRED_DIRS:
        if not d.exists():
            errors.append(f"missing required directory: {d.relative_to(ROOT)}")
    for f in [MANIFEST, SOURCE_CLAIM_MATRIX, OFFICIAL_TRACE, SOURCE_BINDING_STATUS, EXCLUSION_LOG]:
        if not f.exists():
            errors.append(f"missing required file: {f.relative_to(ROOT)}")
    return errors


def validate_manifest(rows: list[dict[str, str]], strict_files: bool) -> list[str]:
    errors: list[str] = []
    seen_paths: set[str] = set()
    errors.extend(require_unique(rows, "source_id", "manifest"))

    for i, row in enumerate(rows, start=2):
        for field in MANIFEST_FIELDS:
            if not row[field].strip():
                errors.append(f"manifest row {i}: empty {field}")

        path_or_url = row["path_or_url"].strip()
        if path_or_url in seen_paths:
            errors.append(f"manifest row {i}: duplicate path_or_url {path_or_url}")
        seen_paths.add(path_or_url)

        if row["original_or_derived"] not in ORIGINAL_OR_DERIVED:
            errors.append(f"manifest row {i}: invalid original_or_derived {row['original_or_derived']}")
        if row["validation_status"] not in VALIDATION_STATUS:
            errors.append(f"manifest row {i}: invalid validation_status {row['validation_status']}")
        if row["validator_role"] not in VALIDATOR_ROLES:
            errors.append(f"manifest row {i}: invalid validator_role {row['validator_role']}")
        if not under_assessments(path_or_url):
            errors.append(f"manifest row {i}: path_or_url must remain under assessments/ or be a URL")

        if strict_files and not path_or_url.startswith(("http://", "https://")):
            if not (ROOT / path_or_url).exists():
                errors.append(f"manifest row {i}: missing local file {path_or_url}")

        if row["validator_role"] == "excluded_or_restricted":
            if row["validation_status"] not in {"restricted_pending_geography", "excluded"}:
                errors.append(f"manifest row {i}: excluded_or_restricted source must have restricted or excluded status")

    return errors


def validate_claim_matrix(rows: list[dict[str, str]], manifest_sources: dict[str, dict[str, str]]) -> list[str]:
    errors: list[str] = []
    errors.extend(require_unique(rows, "claim_id", "claim matrix"))

    for i, row in enumerate(rows, start=2):
        for field in SOURCE_CLAIM_FIELDS:
            if not row[field].strip():
                errors.append(f"claim matrix row {i}: empty {field}")

        source_id = row["source_id"].strip()
        if source_id not in manifest_sources:
            errors.append(f"claim matrix row {i}: unknown source_id {source_id}")
            continue

        if row["claim_weight"] not in CLAIM_WEIGHTS:
            errors.append(f"claim matrix row {i}: invalid claim_weight {row['claim_weight']}")
        if row["allowed_status"] not in ALLOWED_STATUSES:
            errors.append(f"claim matrix row {i}: invalid allowed_status {row['allowed_status']}")

        role = manifest_sources[source_id]["validator_role"]
        allowed = row["allowed_status"]
        if role == "excluded_or_restricted" and not allowed.startswith("blocked"):
            errors.append(f"claim matrix row {i}: restricted source cannot have allowed claim status")
        if role == "background_mechanism_validator" and row["claim_weight"] == "high":
            errors.append(f"claim matrix row {i}: background mechanism source cannot carry high-weight claim")
        if role == "local_hotspot_validator" and allowed != "allowed_local_only":
            errors.append(f"claim matrix row {i}: local hotspot source must be marked allowed_local_only")
        if role == "indicative_trend_validator" and allowed != "allowed_indicative_only":
            errors.append(f"claim matrix row {i}: trend source must be marked allowed_indicative_only")

    return errors


def validate_official_trace(rows: list[dict[str, str]], manifest_sources: dict[str, dict[str, str]]) -> list[str]:
    errors: list[str] = []
    errors.extend(require_unique(rows, "trace_id", "official trace"))
    for i, row in enumerate(rows, start=2):
        for field in OFFICIAL_TRACE_FIELDS:
            if not row[field].strip():
                errors.append(f"official trace row {i}: empty {field}")
        if row["source_id"] not in manifest_sources:
            errors.append(f"official trace row {i}: unknown source_id {row['source_id']}")
        if row["status"] not in TRACE_STATUSES:
            errors.append(f"official trace row {i}: invalid status {row['status']}")
    return errors


def validate_source_binding(rows: list[dict[str, str]], manifest_sources: dict[str, dict[str, str]], claim_rows: list[dict[str, str]]) -> list[str]:
    errors: list[str] = []
    errors.extend(require_unique(rows, "source_id", "source binding"))
    binding_by_source = {row["source_id"]: row for row in rows}

    for i, row in enumerate(rows, start=2):
        for field in SOURCE_BINDING_FIELDS:
            if not row[field].strip():
                errors.append(f"source binding row {i}: empty {field}")

        source_id = row["source_id"]
        if source_id not in manifest_sources:
            errors.append(f"source binding row {i}: unknown source_id {source_id}")

        if not under_assessments(row["expected_path"]):
            errors.append(f"source binding row {i}: expected_path must remain under assessments/")
        if row["local_file_status"] not in LOCAL_FILE_STATUSES:
            errors.append(f"source binding row {i}: invalid local_file_status {row['local_file_status']}")
        if row["public_record_status"] not in PUBLIC_RECORD_STATUSES:
            errors.append(f"source binding row {i}: invalid public_record_status {row['public_record_status']}")
        if row["page_binding_status"] not in PAGE_BINDING_STATUSES:
            errors.append(f"source binding row {i}: invalid page_binding_status {row['page_binding_status']}")
        if row["manuscript_gate"] not in MANUSCRIPT_GATES:
            errors.append(f"source binding row {i}: invalid manuscript_gate {row['manuscript_gate']}")

        if row["page_binding_status"] == "bound" and row["manuscript_gate"] != "allowed":
            errors.append(f"source binding row {i}: bound source should have allowed manuscript_gate")
        if row["manuscript_gate"] == "allowed" and row["page_binding_status"] != "bound":
            errors.append(f"source binding row {i}: allowed manuscript_gate requires bound page_binding_status")

    missing_binding = set(manifest_sources) - set(binding_by_source)
    for source_id in sorted(missing_binding):
        errors.append(f"source binding missing manifest source_id {source_id}")

    for row in claim_rows:
        binding = binding_by_source.get(row["source_id"])
        if binding and binding["page_binding_status"] != "bound" and row["status"] == "ready_for_manuscript":
            errors.append(f"claim {row['claim_id']}: cannot be ready_for_manuscript while source is unbound")

    return errors


def ensure_full_source_coverage(
    manifest_rows: list[dict[str, str]],
    claim_rows: list[dict[str, str]],
    trace_rows: list[dict[str, str]],
    binding_rows: list[dict[str, str]],
) -> list[str]:
    errors: list[str] = []
    manifest_ids = {row["source_id"] for row in manifest_rows}
    for label, rows in {
        "claim matrix": claim_rows,
        "official trace": trace_rows,
        "source binding": binding_rows,
    }.items():
        ids = {row["source_id"] for row in rows}
        for source_id in sorted(manifest_ids - ids):
            errors.append(f"{label} missing source_id {source_id}")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--strict-files", action="store_true", help="require local files in manifest path_or_url to exist")
    args = parser.parse_args()

    errors = validate_required_objects()
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    try:
        manifest_rows = read_csv(MANIFEST, MANIFEST_FIELDS)
        source_rows = read_csv(SOURCE_CLAIM_MATRIX, SOURCE_CLAIM_FIELDS)
        trace_rows = read_csv(OFFICIAL_TRACE, OFFICIAL_TRACE_FIELDS)
        binding_rows = read_csv(SOURCE_BINDING_STATUS, SOURCE_BINDING_FIELDS)
    except (FileNotFoundError, ValueError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    manifest_sources = {row["source_id"]: row for row in manifest_rows}
    errors.extend(validate_manifest(manifest_rows, args.strict_files))
    errors.extend(validate_claim_matrix(source_rows, manifest_sources))
    errors.extend(validate_official_trace(trace_rows, manifest_sources))
    errors.extend(validate_source_binding(binding_rows, manifest_sources, source_rows))
    errors.extend(ensure_full_source_coverage(manifest_rows, source_rows, trace_rows, binding_rows))

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    print("Assessment validation passed.")
    print(f"Sources checked: {len(manifest_rows)}")
    print(f"Claims checked: {len(source_rows)}")
    print(f"Trace records checked: {len(trace_rows)}")
    print(f"Source binding records checked: {len(binding_rows)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
