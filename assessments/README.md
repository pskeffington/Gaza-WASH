# Assessments

This directory controls the assessment evidence layer for the Gaza WASH public-health intelligence project.

The purpose is not to store every possible source. The purpose is to classify, audit, and validate source roles before evidence is allowed to carry manuscript weight.

## Evidence-control principle

Every assessment source must be assigned a validator role before it supports a manuscript claim.

Accepted roles:

- `core_household_validator`
- `local_hotspot_validator`
- `indicative_trend_validator`
- `infrastructure_recovery_validator`
- `background_mechanism_validator`
- `excluded_or_restricted`

## Required metadata

Each source must be represented in `manifest.csv` with:

- stable source identifier
- source title
- geography
- reporting period
- source organization
- file path or public URL
- original-or-derived status
- validation status
- manuscript role
- use limitation

## Manuscript gate

A claim may move into manuscript text only when it can be traced to `citation_audit/source_claim_matrix.csv` and does not violate `validation_notes/manuscript_claim_rules.md`.

## Current validator posture

The August 2025 Gaza Joint WASH Assessment is treated as the core household WASH validator. Enumeration-area factsheets are local validators only. Light-Touch Monitoring reports are indicative trend validators only. The Gaza IRDNA/RDNA is an infrastructure and recovery-context validator, not a household LPPD outcome survey. Background water-quality synthesis may support mechanism only.
