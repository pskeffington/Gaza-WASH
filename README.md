# Gaza WASH Public Health Intelligence

Rapid secondary-data research workspace for Gaza WASH, environmental health, displacement, and health-system access analysis.

## Working study title

**Rapid Public-Health Risk Stratification for WASH Recovery in Gaza Using Open Humanitarian Data**

## Core research question

Can readily accessible humanitarian, WASH, health-facility, and spatial data identify high-priority areas in Gaza where WASH disruption and health-service constraints converge?

## Contribution

This repository supports a reproducible rapid-assessment framework that integrates public humanitarian data, WASH indicators, health-service functionality, and geospatial context to produce a Gaza WASH--Health Risk Priority Index.

The intended contribution is practical decision support, not causal attribution. The first paper should remain a secondary-data, small-area public-health systems analysis.

## Current scope

- Gaza Strip public-health risk stratification
- WASH service stress
- environmental-health hazards
- health-system access constraints
- displacement and vulnerability indicators
- operational-access constraints
- transparent index scoring
- sensitivity analysis

## Rapid-access source classes

| Source class | Primary use | Access status |
|---|---|---|
| OCHA oPt data portal | humanitarian indicators, crossings, electricity, maps | public / partially restricted |
| OCHA situation reports | narrative extraction and time-stamped public-health indicators | public |
| WASH Cluster / ReliefWeb | WASH access, sanitation, hygiene, solid waste, response gaps | public page; dashboard may require browser access |
| WHO EMRO / Health Cluster dashboards | facility functionality, health-service availability, EMT coordination | public dashboard links |
| HDX geodata | boundaries, facility points, humanitarian geodata | public page; export access must be verified |

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

## Boundaries

This workspace should not use restricted partner dashboards, individual patient records, scraped private data, or unverified disease incidence estimates in the initial manuscript.
