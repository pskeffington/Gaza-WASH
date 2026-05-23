# Submission Gate Tracker

## Gate 1. Add WHO / Health Cluster facility-functionality layer

Status: partially engaged; pending extractable values.

Current evidence handling:

- WHO EMRO lists public dashboard links for the Emergency Medical Teams Coordination Cell and WHO Health Cluster Dashboard.
- Values from those dashboards are not yet incorporated into the scoring table because field names, date stamps, and exportable records still need verification.
- Manuscript references currently treat WHO dashboards as a validation layer, not as scored evidence.

Required next step:

- Record dashboard access date, variable names, geography, and any export method before scoring.

## Gate 2. Add HDX boundary / facility geodata layer

Status: partially engaged; pending usable download verification.

Current evidence handling:

- HDX State of Palestine health and geodata pages are listed in the source inventory.
- HDX content was not used as scored evidence in the first-pass index.
- Boundary and facility files must be downloaded, dated, licensed, and checked before spatial joins.

Required next step:

- Add downloaded HDX file metadata to the source inventory and document coordinate reference system, geography, and update date.

## Gate 3. Strengthen transferability beyond Gaza

Status: engaged in literature review and discussion; needs further polishing.

Current manuscript handling:

- Literature review now frames the method as a staged, auditable secondary-data prioritization approach for conflict-affected settings.
- Discussion should be expanded to state how the index can transfer to other humanitarian WASH settings.

Required next step:

- Add a discussion paragraph on transferability, minimum data requirements, and adaptation to other crisis settings.

## Gate 4. Ensure every claim is tied to extraction table and citation

Status: partially engaged.

Current manuscript handling:

- Introduction, methods, and results now include citation keys.
- Manual extraction table includes 12 public OCHA-derived indicators.
- A formal claim audit file is still needed.

Required next step:

- Build `docs/claim_audit.md` mapping manuscript claims to extraction rows and citations.

## Gate 5. Compile LaTeX cleanly

Status: engaged; pending workflow confirmation.

Current manuscript handling:

- Manuscript is segmented.
- Table 3 column mismatch was corrected.
- LaTeX workflow now builds from the `manuscript/` directory.
- GitHub connector has not exposed workflow runs, so manual GitHub Actions dispatch may be required.

Required next step:

- Run the LaTeX workflow through GitHub UI or local `pdflatex` / `bibtex` sequence.

## Gate 6. Keep index framed as prioritization, not disease-burden estimation

Status: engaged.

Current manuscript handling:

- Methods, results, limitations, and literature review explicitly distinguish risk signals from individual-level outcomes.
- Tables describe scores as rapid prioritization, not causal estimation.

Required next step:

- Maintain this language through all future edits.
