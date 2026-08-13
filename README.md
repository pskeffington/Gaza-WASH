# Gaza WASH Public Health Research

Reproducible secondary-data research workspace for Gaza WASH conditions, environmental health, displacement, and health-system access using public humanitarian sources.

**Maintainer:** Paul Skeffington, MS, MPH  
**Repository status:** active secondary-data research scaffold; all indicators require source logging and verification before manuscript-weight use.  
**Last documentation review:** 2026-08-12

## Public-interest research boundary

This repository is maintained for public-health scholarship, humanitarian open-data methods, civic documentation, and reproducible secondary-data analysis. It supports source registration, environmental-health documentation, WASH access review, geospatial context, uncertainty tracking, and human-reviewed manuscript development.

It does not provide operational direction, enforcement capability, automated decision authority, emergency authority claims, real-time access instructions, site-level tasking, household-level exposure findings, clinical determinations, or policy mandates. Outputs are intended to support documentation, quality review, and further research.

## Core research question

How can public humanitarian, WASH, health-facility, displacement, and spatial data be organized to describe where service disruptions and health-system constraints overlap, while preserving uncertainty, source dates, and reporting limitations?

## Current research status

The repository remains in source-registration, methods-design, and descriptive index-scaffolding mode. The immediate priority is to refresh the public source register, convert `docs/data_inventory.md` into a structured manifest, and keep every WASH, health-access, displacement, and access-limitation indicator tied to date-stamped source metadata before any composite score is treated as evidence.

### Current stage

- Stage: Rapid secondary-data research scaffold
- Evidence status: Internal repository evidence available; external validation pending
- Data status: Public humanitarian, WASH, health-facility, and spatial data only unless otherwise documented
- Primary limitation: Requires source verification, redistribution review, sensitivity analysis, and temporal harmonization before manuscript-weight use

## Working study title

**Descriptive Small-Area WASH and Health-Service Constraints in Gaza Using Open Humanitarian Data**

## Contribution

This repository supports a reproducible descriptive framework integrating public humanitarian data, WASH indicators, health-service functionality, displacement context, and geospatial metadata.

Any composite index should be treated as an analytic summary of selected public indicators, not as an operational priority score, causal exposure estimate, or recommendation engine.

## Current scope

- WASH service disruption and access constraints.
- Environmental-health context.
- Health-system access constraints.
- Displacement and vulnerability indicators at appropriate aggregation levels.
- Source and access-limitation metadata.
- Transparent descriptive scoring where used.
- Sensitivity analysis and missing-data review.

## Public source classes

| Source class | Research use |
|---|---|
| OCHA oPt public reporting and data products | Time-stamped humanitarian context and public indicators |
| WASH Cluster / ReliefWeb public materials | WASH access, sanitation, hygiene, solid-waste, and service-gap documentation |
| WHO / Health Cluster public materials | Health-facility functionality and health-service context |
| HDX and other public geodata | Boundaries, facility context, and humanitarian geospatial metadata where redistribution permits |

Access routes, dates, licenses, and verification status should be recorded in `references/source_register.md` before use.

## Repository structure

```text
.
├── data/
│   └── README.md
├── docs/
│   ├── data_inventory.md
│   ├── methods_plan.md
│   └── research_questions.md
├── manuscript/
│   └── outline.md
├── references/
│   └── source_register.md
├── scripts/
│   └── README.md
├── .gitignore
├── CHANGELOG.md
└── README.md
```

## Data-governance boundaries

This workspace should not use restricted partner dashboards, individual patient records, scraped private data, household-level coordinates, or unverified disease-incidence estimates in public analyses.

Do not commit raw humanitarian extracts when redistribution terms are unclear. Commit source registers, metadata, reproducible scripts, derived non-sensitive tables, and manuscript-ready summaries that preserve source limitations.

## Documentation standards

- Treat source date, geography, access route, update cadence, and verification status as required metadata.
- Preserve uncertainty flags for estimates affected by access constraints, reporting gaps, displacement, or dashboard changes.
- Document every indicator, transformation, weight, and sensitivity test if a composite score is used.
- Separate field-context narrative from source-verified public data.
- Avoid causal claims when the underlying data are cross-sectional, ecological, incomplete, or temporally mismatched.
- Do not describe a descriptive index as clinical or operational decision support.

## Next actions

1. Refresh `references/source_register.md` against current public sources and access constraints.
2. Convert `docs/data_inventory.md` into a structured source manifest.
3. Draft a descriptive scoring specification with explicit missing-data and temporal-harmonization rules.
4. Add a methods note explaining the limits of secondary-data, small-area analysis.
5. Add sensitivity analyses showing how results change under alternate inclusion, weighting, and missingness assumptions.
6. Connect validated outputs to the broader public-health portfolio evidence ledger.

## Supported contribution

A reproducible, source-bounded descriptive framework for studying WASH and health-service constraints using public humanitarian data.

## Unsupported contribution

No operational prioritization, field tasking, causal exposure attribution, household-level risk finding, clinical determination, or policy mandate is made.
