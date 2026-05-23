# Methods Plan

## Design

Rapid secondary-data public-health systems analysis using public humanitarian, WASH, health-facility, and geospatial data.

## Unit of analysis

Preferred units, in order:

1. Gaza municipality or administrative area if consistent geodata and indicators are available.
2. Displacement site or site cluster if public site-level data are available.
3. Health-service catchment if facility functionality and spatial boundaries can be defensibly constructed.

## Index domains

| Domain | Description | Example indicators | Score |
|---|---|---|---|
| WASH service stress | disruption to water, sanitation, hygiene, or solid-waste systems | water access limitation, sanitation disruption, WASH facility generator dependence | 0--2 |
| Environmental-health hazard burden | reported hazards that increase communicable or environmental disease risk | sewage exposure, stagnant water, solid waste, pests, crowding | 0--2 |
| Health-system access constraint | constrained access to functional care | distance to functional facility, facility non-functionality, limited mobile services | 0--2 |
| Population vulnerability | concentration of vulnerable groups or displaced households | displacement density, children, older adults, pregnant women if reported | 0--2 |
| Operational access constraint | barriers to response or repair | electricity, fuel, crossing limits, road disruption | 0--2 |

## Priority score

Total score range: 0--10.

| Score range | Priority class |
|---|---|
| 0--3 | lower priority |
| 4--6 | moderate priority |
| 7--10 | high priority |

## Sensitivity analysis

Run at least three versions:

- equal-weight index;
- WASH-weighted index;
- health-access-weighted index.

Report whether top-priority areas remain stable across specifications.

## Minimum reproducibility standard

- Every source must be logged in `docs/data_inventory.md`.
- Every extracted value must preserve source date and access date.
- Every transformation must be scripted or manually documented.
- Every map must state the geography, date range, and source layer.
- Dashboard values must not be treated as stable unless exported or date-captured.

## Preferred outputs

- `tables/source_inventory.csv`
- `tables/indicator_crosswalk.csv`
- `tables/index_scores.csv`
- `figures/gaza_priority_index_map.png`
- `figures/domain_score_maps/`

## Claims discipline

Use: associated with, converges with, co-occurs with, prioritizes, stratifies.

Avoid: causes, proves, demonstrates effect, estimates burden, mortality attributable to.
