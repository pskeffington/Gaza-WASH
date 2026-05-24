---
name: Manuscript claim promotion
about: Promote a verified claim from scaffold language into manuscript finding language
title: "Promote claim: CLAIM_ID"
labels: manuscript-claim, manuscript-gate
assignees: ''
---

## Claim ID

`CLAIM_ID`

## Source ID

`SOURCE_ID`

## Required checks

- [ ] Source row is bound in `source_binding_status.csv`
- [ ] Official trace row is verified or otherwise resolved
- [ ] Exact page/table/figure location is recorded
- [ ] Claim matrix status is ready for manuscript use
- [ ] Manuscript wording preserves source scope

## Manuscript section

- [ ] Introduction
- [ ] Methods
- [ ] Results
- [ ] Discussion

## Validation

```bash
bash scripts/run_validation.sh
```

## Exit condition

The manuscript section includes bounded finding language that matches the source role and both validators pass.
