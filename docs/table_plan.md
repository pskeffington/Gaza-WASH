# Table Plan

## Table 1. Public source inventory

Purpose: document accessible data streams and verification status.

Input file: `tables/source_inventory_validated.csv`

Expected columns:

- source name
- owner
- geography
- variables expected
- extraction method
- verification status

## Table 2. Indicator crosswalk

Purpose: link each analytic domain to specific indicators, source classes, and scoring rules.

Input file: `tables/indicator_crosswalk_validated.csv`

Expected columns:

- domain
- indicator name
- definition
- source class
- standardized field
- score rule

## Table 3. WASH--Health priority index

Purpose: present area-level domain scores, total score, and priority class.

Input file: `tables/index_scores.csv`

Expected columns:

- area name
- geography type
- score date
- five domain scores
- total priority score
- priority class
- source count
- verification status

## Table 4. Sensitivity analysis

Purpose: test whether priority classification changes under alternate weighting assumptions.

Input file: `tables/index_sensitivity_scores.csv`

Expected columns:

- area name
- equal-weight score
- equal-weight class
- WASH-weighted score
- WASH-weighted class
- health-access-weighted score
- health-access-weighted class

## Figure 1. Gaza WASH--Health priority map

Purpose: map priority class using the best available public boundary geography.

Input files:

- `tables/index_scores.csv`
- boundary layer from verified public geodata source

## Figure 2. Domain score maps

Purpose: show which domains drive the total score.

Suggested panels:

- WASH service stress
- environmental-health hazard burden
- health-system access constraint
- population vulnerability
- operational access constraint
