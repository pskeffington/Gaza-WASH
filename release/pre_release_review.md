# Pre-Release Review Checklist

Status: partially unblocked. Uploaded/DOI-backed context sources, URL-bound official context sources, and JMP baseline workbooks are available. Household assessment, local factsheet, original LTM reports, RDNA table source, and restricted IDP source remain blocked.

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
| B010 | `OCHA_SITREP_2026_04_17` | Use only for official time-stamped context. | Bound |
| B011 | `OCHA_SITREP_2026_05_15` | Use only for official time-stamped WASH and infrastructure context. | Bound |
| B012 | `WASH_CLUSTER_PALESTINE_2026` | Use only as coordination hub and source-discovery context. | Bound |
| B013 | `JMP_WASH_HH_2025_COUNTRY` | Use only for country-level occupied Palestinian territory WASH baseline context. | Bound |
| B014 | `JMP_PSE_PROFILE_2025` | Use only for State of Palestine 2024 household WASH profile context. | Bound |
| B015 | `JMP_PSE_INEQUALITIES_2021` | Use only for pre-crisis inequality context. | Bound |
| B016 | `JMP_WINHCF_PSE_2024` | Use only for country-level WASH in health care facilities baseline context. | Bound |

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
