# Gaza WASH Research Roadmap

## Repository purpose

This repository supports a manuscript-grade Gaza WASH public-health research project focused on water, sanitation, hygiene, infrastructure disruption, diagnostic assessment, and evidence controls.

## Working target

Primary journal target: *Conflict and Health*.

Secondary targets:

- *PLOS Water*
- *PLOS Global Public Health*
- *BMC Public Health*

## Manuscript and report object map

| Object | Path | Purpose | Status |
|---|---|---|---|
| Main manuscript | `manuscript/main.tex` | Compiled article shell | Created |
| Introduction | `manuscript/sections/01_introduction.tex` | Problem framing and source-gated assessment rationale | Created |
| Methods | `manuscript/sections/02_methods.tex` | Source-gated design, validator roles, claim controls, validation script | Created |
| Results | `manuscript/sections/03_results.tex` | Evidence-control posture and allowed claim families | Created |
| Discussion | `manuscript/sections/04_discussion.tex` | Minimal placeholder pending claim-promotion decision | Created placeholder |
| Diagnostic report | `reports/gaza_wash_diagnostic_report.md` | Baseline-to-crisis diagnostic with evidence gaps | Created |
| References | `manuscript/references.bib` | Citation database | Existing |
| Source audit | `docs/source_audit.md` | Claim-by-claim source verification tracker | Created |
| Source binding status | `assessments/citation_audit/source_binding_status.csv` | Source file and public-record binding status | Created |
| Pre-release checklist | `release/pre_release_review.md` | Contributor-review blocker checklist | Created |
| Figure/table validator | `analysis/validate_figures_tables.R` | Reproducibility and artifact check script | Created |
| Assessment validator | `scripts/validate_assessments.py` | Evidence-control validation script | Created |
| Assessment manifest | `assessments/manifest.csv` | Source registry and validator-role map | Created |
| Claim matrix | `assessments/citation_audit/source_claim_matrix.csv` | Claim-source gatekeeping table | Created |
| Official trace | `assessments/citation_audit/official_source_trace.csv` | Official-source verification queue | Created |
| Derived JMP tables | `assessments/derived/` | Baseline and inequality context tables | Created |

## Current priority

Stage 4 is active: diagnostic report development. Stage 3 source acquisition remains open for blocked household assessment, local factsheet, original LTM, RDNA table, and restricted IDP sources. The diagnostic pathway is partially unblocked because bound sources now support baseline context, localized water-quality mechanism discussion, political-economy interpretation, official time-stamped context, coordination context, and explicit evidence-gap documentation.

## Bound diagnostic source families

- Turkman et al. 2025: localized Khan Younis and Middle Area water-quality and mechanism evidence.
- Fayad et al. 2025: political-economy and governance context.
- OCHA 17 April 2026 and 15 May 2026: official time-stamped situation context.
- WASH Cluster Palestine 2026: coordination hub and source-discovery context.
- JMP 2025 household workbooks: country-level WASH baseline context.
- JMP 2021 inequalities workbook: pre-crisis inequality and Gaza-region context.
- JMP 2024 WinHCF workbook: health-care-facility WASH baseline context.

## Claim handling rules

- Verified and page-bound claims may enter the diagnostic report.
- Context sources remain context sources; do not promote them into household prevalence findings.
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
4. Partially complete: verify core citations and official source metadata. Current result: source-acquisition blockers logged and multiple context sources bound.
5. ~~Add figure/table validation script.~~
6. Partially complete: prepare pre-release for contributor review. Current result: blocker checklist created.
7. ~~Create diagnostic report draft from bound context and baseline sources.~~

## Next executable units

1. Promote bound diagnostic claims C007 and C009-C016 into refined report prose with citation-ready wording.
2. Add diagnostic exhibit tables from the derived JMP CSV files.
3. Add a diagnostic evidence-gap table for C001-C006 and C008.
4. Run local validation and record result.
5. Replace or expand `manuscript/sections/04_discussion.tex` only after selecting which diagnostic claims move into the manuscript.
6. Continue acquisition for `GJWASH_2025_08`, `ALMAWASI7_EA32`, `ASSAWARAH_EA8`, `LTM_2025_04_R3`, `LTM_2025_06_R4`, `RDNA_2025_02`, and `SHELTER_WASH_FSS_IDP_2025_07`.
