#!/usr/bin/env python3
"""Validate the Gaza WASH assessment evidence-control layer.

This script checks manifest structure, controlled vocabularies, source-claim mappings,
and restricted-source handling. It can run without local PDF files by default.
Use --strict-files to require local source document paths to exist.
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
    return p.parts and p.parts[0] == "assessments"


def validate_manifest(rows: list[dict[str, str]], strict_files: bool) -> list[str]:
    errors: list[str] = []
    seen_ids: set[str] = set()
    seen_paths: set[str] = set()

    for i, row in enumerate(rows, start=2):
        source_id = row["source_id"].strip()
        path_or_url = row["path_or_url"].strip()

        for field in MANIFEST_FIELDS:
            if not row[field].strip():
                errors.append(f"manifest row {i}: empty {field}")

        if source_id in seen_ids:
            errors.append(f"manifest row {i}: duplicate source_id {source_id}")
        seen_ids.add(source_id)

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
                errors.append(
                    f"manifest row {i}: excluded_or_restricted source must have restricted or excluded status"
                )

    return errors


def validate_claim_matrix(rows: list[dict[str, str]], manifest_sources: dict[str, dict[str, str]]) -> list[str]:
    errors: list[str] = []
    seen_claims: set[str] = set()

    for i, row in enumerate(rows, start=2):
        claim_id = row["claim_id"].strip()
        source_id = row["source_id"].strip()

        for field in SOURCE_CLAIM_FIELDS:
            if not row[field].strip():
                errors.append(f"claim matrix row {i}: empty {field}")

        if claim_id in seen_claims:
            errors.append(f"claim matrix row {i}: duplicate claim_id {claim_id}")
        seen_claims.add(claim_id)

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
    for i, row in enumerate(rows, start=2):
        for field in OFFICIAL_TRACE_FIELDS:
            if not row[field].strip():
                errors.append(f"official trace row {i}: empty {field}")
        if row["source_id"] not in manifest_sources:
            errors.append(f"official trace row {i}: unknown source_id {row['source_id']}")
    return errors


def validate_required_objects() -> list[str]:
    errors: list[str] = []
    for d in REQUIRED_DIRS:
        if not d.exists():
            errors.append(f"missing required directory: {d.relative_to(ROOT)}")
    for f in [MANIFEST, SOURCE_CLAIM_MATRIX, OFFICIAL_TRACE, EXCLUSION_LOG]:
        if not f.exists():
            errors.append(f"missing required file: {f.relative_to(ROOT)}")
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
    except (FileNotFoundError, ValueError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

    manifest_sources = {row["source_id"]: row for row in manifest_rows}
    errors.extend(validate_manifest(manifest_rows, args.strict_files))
    errors.extend(validate_claim_matrix(source_rows, manifest_sources))
    errors.extend(validate_official_trace(trace_rows, manifest_sources))

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    print("Assessment validation passed.")
    print(f"Sources checked: {len(manifest_rows)}")
    print(f"Claims checked: {len(source_rows)}")
    print(f"Trace records checked: {len(trace_rows)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
