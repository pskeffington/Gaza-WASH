# Contributing

## Repository rule

Do not promote scaffold language into manuscript finding language until the relevant evidence row is resolved in the audit tables.

## File naming

Place source files under `assessments/source_documents/` using stable lowercase names with dates where available.

Examples:

- `2025-08_gaza_joint_wash_assessment_report.pdf`
- `2025-04_wash_light_touch_monitoring_round_3.pdf`
- `2025-02_gaza_irdna_rdna_final.pdf`

## Evidence-row update sequence

1. Add or verify the source file or official URL.
2. Update `assessments/citation_audit/source_binding_status.csv`.
3. Update `assessments/citation_audit/official_source_trace.csv`.
4. Update `assessments/citation_audit/source_claim_matrix.csv` only after exact page, table, or figure locations are known.
5. Run validation.

## Local validation

```bash
bash scripts/run_validation.sh
```

The helper runs both validators:

```bash
python3 scripts/validate_assessments.py
Rscript analysis/validate_figures_tables.R
```

## Manuscript editing

Keep unresolved claims in scaffold form. Use bounded language that matches the validator role: local-only, trend-only, context-only, or background-only.
