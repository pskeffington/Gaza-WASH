# Pre-Release Review Checklist

Status: partially unblocked. Two uploaded/DOI-backed context sources are bound; household assessment, local factsheet, trend-monitoring, RDNA, and restricted IDP sources remain blocked.

Tracking issue: `#1 Acquire and bind Gaza WASH source documents`.

## Source gates

| ID | Object | Required action | Status |
|---|---|---|---|
| B001 | `GJWASH_2025_08` | Attach source file or verified official URL; record C001 page locations. | Blocked |
| B002 | `ALMAWASI7_EA32` | Attach source file or verified official URL; record C002 page locations. | Blocked |
| B003 | `ASSAWARAH_EA8` | Attach source file or verified official URL; record C003 page locations. | Blocked |
| B004 | `LTM_2025_04_R3` | Attach source file or verified official URL; record C004 page locations. | Blocked |
| B005 | `LTM_2025_06_R4` | Attach source file or verified official URL; record C005 page locations. | Blocked |
| B006 | `RDNA_2025_02` | Bind official report URL and table/page locations. | Blocked |
| B007 | `HEALTH_WATER_GAZA` | Use Turkman et al. 2025 only for localized water-quality and mechanism language. | Bound |
| B008 | `SHELTER_WASH_FSS_IDP_2025_07` | Confirm Gaza-specific geography or keep excluded. | Blocked |
| B009 | `FAYAD_PLOS_WATER_2025` | Use Fayad et al. 2025 only for political-economy context. | Bound |

## Release checks

- [ ] Issue `#1` unresolved blockers are resolved or explicitly deferred.
- [ ] `source_binding_status.csv` has no unresolved row promoted to manuscript use.
- [ ] `official_source_trace.csv` records verified locations or unresolved status.
- [ ] `source_claim_matrix.csv` contains no claim marked ready without page/table/figure binding.
- [ ] `page_binding_notes.csv` covers every bound claim.
- [ ] Discussion placeholder replaced only after evidence rows needed for findings are resolved.
- [ ] Local validation passes.
- [ ] CI validation passes or status absence is documented under the pivot rule.

## Validation commands

```bash
bash scripts/run_validation.sh
```

Individual commands:

```bash
python3 scripts/validate_assessments.py
Rscript analysis/validate_figures_tables.R
```

Do not replace scaffold language with finding language until the associated source row is page-bound and the claim matrix status is updated.
