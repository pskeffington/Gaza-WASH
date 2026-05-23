# Manuscript Claim Rules

## Purpose

These rules define when an assessment source may support manuscript language in the Gaza WASH public-health intelligence project.

## Rule 1 — Claim weight must match validator role

High-weight household WASH claims require the `core_household_validator` role or another source subsequently promoted to equivalent status after audit.

Local hotspot claims may use `local_hotspot_validator` sources only when the sentence clearly identifies the local geography.

Trend claims may use `indicative_trend_validator` sources only when the sentence is limited to assessed households, assessed locations, key informants, or the report-specific monitoring frame.

Infrastructure and recovery claims may use `infrastructure_recovery_validator` sources. These sources may not be used as household outcome surveys unless the source explicitly reports household outcome measures.

Mechanism claims may use `background_mechanism_validator` sources. These sources may not validate current field conditions by themselves.

## Rule 2 — Excluded or restricted sources cannot carry Gaza claims

A source marked `excluded_or_restricted` cannot support Gaza claims unless its geography is verified and the restriction is removed in `exclusion_log.md` and `manifest.csv`.

## Rule 3 — Secondary-extracted indicators require confirmation

Secondary-extracted water-quality indicators cannot carry manuscript weight until confirmed against WV/OEHS-equivalent official records for local projects or official Gaza/humanitarian validators for this project. For Gaza WASH, use official assessment reports, cluster products, or primary public data portals.

## Rule 4 — No silent generalization

Do not generalize from an enumeration area, site, camp, shelter, assessed household group, or key-informant sample to Gaza-wide conditions unless the source design supports that inference.

## Rule 5 — Citation matrix required

Every manuscript claim using assessment evidence must appear in `citation_audit/source_claim_matrix.csv` before submission.

## Rule 6 — Ambiguous sources are background only

If geography, date, source organization, or sampling frame is unclear, the source remains background-only or excluded until resolved.
