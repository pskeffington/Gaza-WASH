# Maintenance Queue

## Pivot rule

If a workflow status query returns no run, continue with another bounded repository-maintenance task.

## Active lanes

| Lane | Object | Task | Status |
|---|---|---|---|
| CI | `.github/workflows/validate.yml` | Add manual run trigger. | Complete |
| Evidence table | `assessments/citation_audit/source_binding_status.csv` | Keep unresolved rows blocked until file or URL evidence is recorded. | Active |
| Issue tracking | GitHub issue `#1` | Track unresolved evidence rows and manuscript gates. | Active |
| Manuscript | `manuscript/sections/04_discussion.tex` | Replace placeholder only after evidence rows are resolved. | Blocked |
| Validation | `scripts/validate_assessments.py` | Maintain parity with R validator. | Active |
| Validation | `analysis/validate_figures_tables.R` | Maintain parity with Python validator. | Active |

## Next cleanup units

1. Add a local validation helper script.
2. Add contributor notes for file naming and page-location updates.
3. Add issue templates for evidence-row resolution and manuscript claim promotion.
4. Add a release readiness checklist that references issue `#1`.
