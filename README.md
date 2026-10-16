# Financial Optimisation with AMPL — Warwick IB3K2 (2022/23)

An archive of my undergraduate coursework for **IB3K2 Financial Optimisation** at the University of Warwick. It includes a written assignment with mathematical formulations, scenario trees and results, alongside AMPL model, data and run files. The examples cover bond cash-flow matching, portfolio decisions and scenario-based investment planning.

This repository records work submitted and developed in **2022/23**. It is an educational archive, not current investment advice or an officially maintained course resource. The module continues to evolve; see the [Warwick module catalogue](https://courses.warwick.ac.uk/modules/2026/IB3K2-15) for the current description.

## Contents

| Location | Contents |
| --- | --- |
| [`assignment/`](assignment/) | A copy of my five-page submission with my student number removed, plus the original Q1c and Q2 AMPL files. Q1 concerns bond portfolio dedication with uncertain rates; Q2 concerns investment decisions over a nine-year scenario tree. |
| [`weekly-exercises/`](weekly-exercises/) | My Week 3–9 quiz model, data and run files, grouped by topic. |
| [`notes/ampl-quickstart.md`](notes/ampl-quickstart.md) | A short companion guide distilled from my personal AMPL notes. |

## Weekly exercises

| Week | Topic | Files |
| --- | --- | --- |
| 3 | Security selection and portfolio return | `W3_Quiz.*` |
| 4 | Project selection and bond portfolio dedication | `W4_Quiz1.*`, `W4_Quiz2.*` |
| 5 | Bond duration and convexity matching | `W5_Quiz.*` |
| 6 | Mean–variance portfolio allocation | `W6_Quiz.*` |
| 7 | Robust portfolio allocation | `W7_Quiz.*` |
| 8 | Scenario-based cash-flow matching | `W8_Quiz.*` |
| 9 | Scenario-based asset–liability management | `W9_Quiz.*` |

## Reading the AMPL files

Each example typically has a `.mod` model, a `.dat` input file and a `.run` command script. Open AMPL in that example's directory and run `include filename.run;` to execute its original script. The scripts refer to Gurobi or CPLEX; using them requires access to the named solver. The code is presented **exactly as it was in the original coursework files**, including historical mistakes or incomplete scripts. I have not updated or re-tested these models for modern AMPL versions. The report likewise preserves the original modelling and results; only the student number and PDF metadata have been removed.

The assignment uses generated example data. Results are the outcomes reported in the 2023 submission, not independently verified results from a fresh run.

## Scope

This is my own coursework archive. Original lecturer handouts, lecture slides, software bundles, screenshots from course resources, and versions labelled with other people's names are not included. No separate licence is granted for reuse of the code or report.
