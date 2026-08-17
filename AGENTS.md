# Repository Guidelines

## Project Structure & Module Organization
The core class lives in `rpg-module.cls`, with system-specific styles (`rpg-basic-stats.sty`, `rpg-1e-stats.sty`, `rpg-dcc-stats.sty`) and their `.def` lookup tables alongside it. `doc/rpg-module.tex` is the single-source manual; its Makefile installs the PDF into the repository root. Example sources sit in `examples_src/<system>/`, each `make install` exporting PDFs into the generated `examples/` gallery. Keep graphics, CSV seeds, and helper scripts in `src/`. Treat `out/` as scratch output and avoid committing extra logs or `.synctex` files.

## Build, Test, and Development Commands
- `make`: rebuilds the manual and refreshes stat definitions before installing artifacts.
- `make examples`: forces a clean rebuild of every sample module into `examples/`.
- `cd doc && make`: compiles documentation only; rerun when LaTeX requests another pass.
- `make clean`: removes LaTeX auxiliary files across `doc/` and `examples_src/`.
- `make zip`: assembles `/tmp/rpg-module.zip` for release packaging.

## Coding Style & Naming Conventions
Use spaces for alignment, following the two-space indentation around `\DeclareOption` blocks and macro bodies. Prefix class helpers with `\module@` and system-specific hooks with `\basic@`, `\dcc@`, etc., to avoid namespace clashes. Keep filenames lower-case and hyphenated. Limit `%` comments to clarifying TeX primitives, and follow existing `%%` banner formatting.

## Testing Guidelines
With no automated tests, every build doubles as regression coverage. After style or data edits, run `make` and inspect the PDFs for overfull boxes, spacing shifts, or missing glyphs; clear LaTeX warnings before pushing. When monster tables change, spot-check entries in `rpg-module.pdf` and the affected example modules to confirm movement codes and hit dice display correctly.

## Commit & Pull Request Guidelines
Recent history uses sentence-case, present-tense summaries (e.g., `Fixes above spacing for sections at the top of a column`). Keep the first line under ~70 characters and scope commits narrowly by subsystem (`basic`, `dcc`, `docs`). Pull requests should describe the intent, list the build commands executed, call out any intentional PDF diffs, and link issues or forum threads. Provide screenshots for layout changes whenever the PDF output shifts.

## Asset & Data Updates
Regenerate `monster_list.csv` by running `sh src/convert` inside `src/` after editing `monster_list_orig.csv`, then review the diff to confirm label ordering. Store editable artwork (SVG/XCF) alongside exported PNGs in `src/`, and reference only the optimized asset in LaTeX. Note asset provenance in comments or the PR description.
