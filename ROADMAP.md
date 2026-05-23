# Gaza WASH Research Roadmap

## Repository purpose

This repository supports a manuscript-grade Gaza WASH research project focused on conflict-affected water, sanitation, hygiene, infrastructure disruption, and operational public-health assessment.

## Working target

Primary journal target: *Conflict and Health*.

Secondary targets:

- *PLOS Water*
- *PLOS Global Public Health*
- *BMC Public Health*

## Manuscript object map

| Object | Path | Purpose | Status |
|---|---|---|---|
| Main manuscript | `manuscript/main.tex` | Compiled article shell | Pending |
| Introduction | `manuscript/sections/01_introduction.tex` | Problem framing, WASH burden, conflict setting | Pending |
| Methods | `manuscript/sections/02_methods.tex` | Remote-sensing, source audit, infrastructure assessment methods | Pending |
| Results | `manuscript/sections/03_results.tex` | Mapped WASH findings and infrastructure-risk synthesis | Pending |
| Discussion | `manuscript/sections/04_discussion.tex` | Public-health interpretation, limitations, operational implications | Pending |
| References | `manuscript/references.bib` | Verified citation database | Pending |
| Source audit | `docs/source_audit.md` | Claim-by-claim source verification tracker | Pending |
| Figure/table validator | `analysis/validate_figures_tables.R` | Reproducibility and artifact check script | Pending |

## Current priority

Build the source-audit and manuscript skeleton before expanding claims. All manuscript claims must be tied to dated sources, dated imagery, official datasets, peer-reviewed literature, or clearly labeled analytic outputs.

## Claim handling rules

- Verified claims may enter the manuscript body.
- Partially verified claims remain in notes or background only.
- Unverified operational claims must be labeled `UNVERIFIED -- POSSIBLE SIMULATION` until evidence is attached.
- Imagery-derived observations must include image date, platform or source, band/composite if relevant, and analytic interpretation boundary.
- No unsupported causal claims.

## Immediate execution sequence

1. Create manuscript scaffold.
2. Create source-audit tracker.
3. Convert existing presentation logic into section-level manuscript claims.
4. Verify core citations and official source metadata.
5. Add figure/table validation script.
6. Prepare pre-release for contributor review.
