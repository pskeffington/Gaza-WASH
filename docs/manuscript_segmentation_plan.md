# Manuscript Segmentation Plan

The manuscript should remain segmented before substantive polishing, citation expansion, or submission formatting.

## Principle

The main manuscript file should function as a shell. Major manuscript sections should live in separate files so each object can be reviewed, replaced, cited, versioned, and reused independently.

## Segment map

| Segment | File | Status | Purpose |
|---|---|---|---|
| Title and preamble | `manuscript/gaza_wash_health_index.tex` | active shell | assemble manuscript and global packages |
| Abstract | `manuscript/sections/abstract.tex` | to build | structured summary after methods/results stabilize |
| Introduction | `manuscript/sections/introduction.tex` | to build | research problem, gap, contribution, TDI alignment |
| Methods | `manuscript/sections/methods.tex` | source exists as `methods_first_pass.tex` | study design, data sources, extraction, scoring, sensitivity |
| Results | `manuscript/sections/results.tex` | source exists as `results_first_pass.tex` | extracted indicators, index scores, sensitivity findings |
| Discussion | `manuscript/sections/discussion.tex` | to build | interpretation, contribution, implications |
| Limitations | `manuscript/sections/limitations.tex` | to build | data limits, noncausal design, dashboard volatility |
| Conclusion | `manuscript/sections/conclusion.tex` | to build | concise closing claim |
| Tables | `manuscript/tables/*.tex` | partially built | source inventory, indicator crosswalk, priority index, sensitivity |
| References | `manuscript/references.bib` | to build | verified APA/BibTeX source base |

## Required workflow

1. Build or migrate one manuscript segment at a time.
2. Keep the shell limited to preamble, title block, and `\input{}` calls.
3. Do not polish the whole manuscript as one block.
4. Verify citations before finalizing a segment.
5. Keep tables as separate LaTeX fragments.
6. Keep source/data audit files outside the manuscript body.

## Immediate correction

The current manuscript shell still contains inline abstract, introduction, discussion, limitations, and conclusion text. These should be split into files before further manuscript polishing.
