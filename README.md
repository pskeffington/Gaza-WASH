# Gaza WASH Public Health Research

Rapid secondary-data research workspace for Gaza WASH, environmental health, displacement, and health-system access analysis.

**Maintainer:** Paul Skeffington, MS, MPH  
**Repository status:** active rapid-assessment scaffold; all indicators require source logging and verification before manuscript-weight use.  
**Last documentation refresh:** 2026-07-03

## Public-Interest Research Boundary

This repository is maintained for public-health scholarship, humanitarian open-data methods, civic documentation, and reproducible secondary-data analysis. It supports source registration, environmental-health documentation, WASH access review, geospatial context, uncertainty tracking, and human-reviewed manuscript development.

It does not provide operational direction, enforcement capability, automated decision authority, emergency authority claims, real-time access instructions, site-level tasking, household-level exposure findings, clinical determinations, or policy mandates. Outputs are intended to support documentation, quality review, and further research.

## Current Research Status

The repository remains in source-registration, methods-design, and index-scaffolding mode. The immediate documentation priority is to refresh the public source register, convert `docs/data_inventory.md` into a structured manifest, and keep every WASH, health-access, displacement, and access-limitation indicator tied to date-stamped source metadata before index scoring is treated as evidence.

### Current Stage

- Stage: Rapid secondary-data research scaffold
- Evidence status: Internal repository evidence available; external validation pending
- Data status: Public humanitarian, WASH, health-facility, and spatial data only unless otherwise documented
- Primary limitation: Requires source verification, redistribution review, and sensitivity analysis before manuscript-weight use

### Recent Progress

- README framing revised toward public-facing scholarly presentation
- Terminology revised toward public health, humanitarian open data, and reproducible analysis
- Operational language bounded to source limitations and access-context metadata
- Claim boundary preserved against causal, clinical, site-level, or authority claims

### Next Actions

1. Refresh `references/source_register.md` against current public source URLs and access constraints.
2. Convert `docs/data_inventory.md` into a structured source manifest.
3. Draft a reproducible index-scoring specification with explicit missing-data rules.
4. Add a methods note describing why the project is a rapid secondary-data assessment rather than a causal exposure study.
5. Connect outputs to the portfolio evidence ledger.

## Working Study Title

**Rapid Public-Health Risk Stratification for WASH Recovery in Gaza Using Open Humanitarian Data**

## Core Research Question

Can readily accessible humanitarian, WASH, health-facility, and spatial data identify areas where WASH disruption and health-service constraints converge, while preserving uncertainty and source limitations?

## Contribution

This repository supports a reproducible rapid-assessment framework that integrates public humanitarian data, WASH indicators, health-service functionality, and geospatial context to produce a Gaza WASH--Health Risk Priority Index.

The intended contribution is practical public-health documentation and scholarly decision-support evidence, not causal attribution. The first paper should remain a secondary-data, small-area public-health systems analysis.

## Current Scope

- Gaza Strip public-health risk stratification.
- WASH service stress.
- Environmental-health hazards.
- Health-system access constraints.
- Displacement and vulnerability indicators.
- Source and access-limitation metadata.
- Transparent index scoring.
- Sensitivity analysis.

## Rapid-Access Source Classes

| Source class | Primary use | Access status |
|---|---|---|
| OCHA oPt data portal | Humanitarian indicators, crossings, electricity, maps | Public / partially restricted |
| OCHA situation reports | Narrative extraction and time-stamped public-health indicators | Public |
| WASH Cluster / ReliefWeb | WASH access, sanitation, hygiene, solid waste, response gaps | Public page; dashboard access must be verified |
| WHO EMRO / Health Cluster dashboards | Facility functionality, health-service availability, EMT coordination | Public dashboard links |
| HDX geodata | Boundaries, facility points, humanitarian geodata | Public page; export access must be verified |

## Repository Structure

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

## First Analytic Object

The first reusable object is `docs/data_inventory.md`. Every source must be logged before use with source URL, geography, variable class, extraction method, update status, verification status, and manuscript role.

## Data-Governance Boundaries

This workspace should not use restricted partner dashboards, individual patient records, scraped private data, or unverified disease incidence estimates in the initial manuscript.

Do not commit raw humanitarian extracts if redistribution terms are unclear. Commit only source registers, metadata, reproducible scripts, derived non-sensitive tables, and manuscript-ready summaries that preserve source limitations.

## Documentation Standards

- Treat source date, geography, access route, update cadence, and verification status as required metadata.
- Preserve uncertainty flags for estimates affected by access constraints, reporting gaps, displacement, or dashboard changes.
- Keep index scoring transparent by documenting every indicator, transformation, weight, and sensitivity test.
- Separate field-context notes from source-verified public data.

## Current Status

Documentation refreshed on 2026-07-03. The repository remains in source-registration, methods-design, and index-scaffolding mode.
