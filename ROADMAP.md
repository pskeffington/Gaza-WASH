# Gaza WASH Research Roadmap

## Repository purpose

This repository supports a manuscript-grade Gaza WASH public-health research project focused on water, sanitation, hygiene, infrastructure disruption, and assessment evidence controls.

## Working target

Primary journal target: *Conflict and Health*.

Secondary targets:

- *PLOS Water*
- *PLOS Global Public Health*
- *BMC Public Health*

## Manuscript object map

| Object | Path | Purpose | Status |
|---|---|---|---|
| Main manuscript | `manuscript/main.tex` | Compiled article shell | Created |
| Introduction | `manuscript/sections/01_introduction.tex` | Problem framing and source-gated assessment rationale | Created |
| Methods | `manuscript/sections/02_methods.tex` | Source-gated design, validator roles, claim controls, validation script | Created |
| Results | `manuscript/sections/03_results.tex` | Evidence-control posture and allowed claim families | Created |
| Discussion | `manuscript/sections/04_discussion.tex` | Minimal placeholder pending page-level source binding | Created placeholder |
| References | `manuscript/references.bib` | Citation database | Existing |
| Source audit | `docs/source_audit.md` | Claim-by-claim source verification tracker | Created |
| Source binding status | `assessments/citation_audit/source_binding_status.csv` | Source file and public-record binding status | Created |
| Pre-release checklist | `release/pre_release_review.md` | Contributor-review blocker checklist | Created |
| Figure/table validator | `analysis/validate_figures_tables.R` | Reproducibility and artifact check script | Created |
| Assessment validator | `scripts/validate_assessments.py` | Evidence-control validation script | Created |
| Assessment manifest | `assessments/manifest.csv` | Source registry and validator-role map | Created |
| Claim matrix | `assessments/citation_audit/source_claim_matrix.csv` | Claim-source gatekeeping table | Created |
| Official trace | `assessments/citation_audit/official_source_trace.csv` | Official-source verification queue | Created |

## Current priority

Stage 3 is active: source acquisition and page-level binding. All expected source-document paths have been checked; the expected local files are currently missing. Public search did not locate the named WASH assessment/factsheet records. The project should not expand manuscript findings until source files or verified official URLs are bound to exact pages, tables, or figures.

## Claim handling rules

- Verified claims may enter the manuscript body.
- Partially verified claims remain in notes or background only.
- Unverified claims must be labeled `UNVERIFIED -- POSSIBLE SIMULATION` until evidence is attached.
- Imagery-derived observations must include image date, platform or source, band/composite if relevant, and analytic interpretation boundary.
- No unsupported causal claims.
- Local factsheets remain local-only.
- Trend reports remain indicative-only.
- Infrastructure recovery reports remain context-only unless they directly report household outcomes.
- Background mechanism literature may not be used as current field validation.

## Immediate execution sequence

1. ~~Create manuscript scaffold.~~
2. ~~Create source-audit tracker.~~
3. ~~Convert existing presentation logic into section-level manuscript claims.~~
4. Partially complete: verify core citations and official source metadata. Current result: source-acquisition blockers logged.
5. ~~Add figure/table validation script.~~
6. Partially complete: prepare pre-release for contributor review. Current result: blocker checklist created.

## Next executable units

1. Acquire or attach source file for `GJWASH_2025_08`; then record page locations for C001.
2. Acquire or attach source files for `ALMAWASI7_EA32` and `ASSAWARAH_EA8`; then record page locations for C002 and C003.
3. Acquire or attach source files for `LTM_2025_04_R3` and `LTM_2025_06_R4`; then record page locations for C004 and C005.
4. Bind `RDNA_2025_02` to an official report URL or committed source file; then record table/page locations for C006.
5. Resolve or replace `HEALTH_WATER_GAZA` with a verified mechanism source.
6. Keep `SHELTER_WASH_FSS_IDP_2025_07` excluded unless Gaza-specific geography is confirmed.
7. Replace the Discussion placeholder after source binding is complete.
