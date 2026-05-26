# Gaza WASH Public Health Intelligence

Rapid secondary-data research workspace for Gaza WASH, environmental health, displacement, and health-system access analysis.

**Maintainer:** Paul Skeffington, MS, MPH  
**Repository status:** active rapid-assessment scaffold; all indicators require source logging and verification before manuscript-weight use.  
**Last documentation refresh:** 2026-05-26

## Current update — 2026-05-26

The repository remains in source-registration, methods-design, and risk-index scaffolding mode. The immediate documentation priority is to refresh the public source register, convert `docs/data_inventory.md` into a structured manifest, and keep every WASH, health-access, displacement, and operational-access indicator tied to date-stamped source metadata before index scoring is treated as evidence.

## Working study title

**Rapid Public-Health Risk Stratification for WASH Recovery in Gaza Using Open Humanitarian Data**

## Core research question

Can readily accessible humanitarian, WASH, health-facility, and spatial data identify high-priority areas in Gaza where WASH disruption and health-service constraints converge?

## Contribution

This repository supports a reproducible rapid-assessment framework that integrates public humanitarian data, WASH indicators, health-service functionality, and geospatial context to produce a Gaza WASH--Health Risk Priority Index.

The intended contribution is practical decision support, not causal attribution. The first paper should remain a secondary-data, small-area public-health systems analysis.

## Current scope

- Gaza Strip public-health risk stratification.
- WASH service stress.
- Environmental-health hazards.
- Health-system access constraints.
- Displacement and vulnerability indicators.
- Operational-access constraints.
- Transparent index scoring.
- Sensitivity analysis.

## Rapid-access source classes

| Source class | Primary use | Access status |
|---|---|---|
| OCHA oPt data portal | Humanitarian indicators, crossings, electricity, maps | Public / partially restricted |
| OCHA situation reports | Narrative extraction and time-stamped public-health indicators | Public |
| WASH Cluster / ReliefWeb | WASH access, sanitation, hygiene, solid waste, response gaps | Public page; dashboard access must be verified |
| WHO EMRO / Health Cluster dashboards | Facility functionality, health-service availability, EMT coordination | Public dashboard links |
| HDX geodata | Boundaries, facility points, humanitarian geodata | Public page; export access must be verified |

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

## First analytic object

The first reusable object is `docs/data_inventory.md`. Every source must be logged before use with source URL, geography, variable class, extraction method, update status, verification status, and manuscript role.

## Data-governance boundaries

This workspace should not use restricted partner dashboards, individual patient records, scraped private data, or unverified disease incidence estimates in the initial manuscript.

Do not commit raw humanitarian extracts if redistribution terms are unclear. Commit only source registers, metadata, reproducible scripts, derived non-sensitive tables, and manuscript-ready summaries that preserve source limitations.

## Documentation standards

- Treat source date, geography, access route, update cadence, and verification status as required metadata.
- Preserve uncertainty flags for estimates affected by access constraints, reporting gaps, conflict conditions, displacement, or dashboard changes.
- Keep index scoring transparent by documenting every indicator, transformation, weight, and sensitivity test.
- Separate operational observations from source-verified public data.

## Next execution steps

1. Refresh `references/source_register.md` against current public source URLs and access constraints.
2. Convert `docs/data_inventory.md` into a structured source manifest.
3. Draft a reproducible index-scoring specification with explicit missing-data rules.
4. Add a methods note describing why the project is a rapid secondary-data assessment rather than a causal exposure study.

## Current status

Documentation refreshed on 2026-05-26. The repository remains in source-registration, methods-design, and risk-index scaffolding mode.
