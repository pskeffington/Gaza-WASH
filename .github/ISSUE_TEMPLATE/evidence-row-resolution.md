---
name: Evidence row resolution
about: Resolve one source/evidence row before manuscript promotion
title: "Resolve evidence row: SOURCE_ID"
labels: evidence-row, manuscript-gate
assignees: ''
---

## Source ID

`SOURCE_ID`

## Evidence object

- [ ] Source file attached under `assessments/source_documents/`
- [ ] Official URL recorded
- [ ] Bibliographic metadata verified
- [ ] Page/table/figure locations recorded

## Tables to update

- [ ] `assessments/citation_audit/source_binding_status.csv`
- [ ] `assessments/citation_audit/official_source_trace.csv`
- [ ] `assessments/citation_audit/source_claim_matrix.csv`

## Validation

```bash
bash scripts/run_validation.sh
```

## Exit condition

The source row is bound to a verified file or official URL, exact page/table/figure locations are recorded, and both validators pass.
