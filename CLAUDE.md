# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Course material for **MATF14: Estatística Econômica I** (UFBA, Departamento de Estatística),
turma 2026.2. This is not a software project — there is no application code, no test suite, and
no linter. The "artifacts" are a textbook, slide decks, and exercise lists, all generated from
source files (R Markdown, LaTeX) via rendering commands.

## Repository structure

- `Apoio/`: the original professor's material from a previous semester (`.odp` slides, R labs,
  exercise lists, already-applied exams). **Not modified by this project** — treat as read-only
  reference unless explicitly asked to change it.
- `Livro/`: the textbook, built with [bookdown](https://bookdown.org/) (gitbook output).
- `Aulas2026/`: lecture slide decks in [xaringan](https://slides.yihui.org/xaringan/), one `.Rmd`
  per entry in the official 2026.2 schedule.
- `Listas2026/`: exercise lists in LaTeX, sharing `preamble.tex`.
- `README.md` has the full 2026.2 class schedule (date → deck mapping) and the rationale for
  merging/skipping specific lecture numbers — consult it before renumbering or reordering decks.

## Build / render commands

**Book** (from repo root, in R):
```r
bookdown::render_book("Livro/index.Rmd")
```
Output config lives in `Livro/_bookdown.yml` (chapter order, `output_dir: "."`) and
`Livro/_output.yml` (gitbook options). Chapters are numbered `01-`..`06-` but the *rendered*
numbering is Capítulo 1–4 plus two unnumbered appendices (`05-revisao-calculo.Rmd` starts an
`(APPENDIX)` block, `06-formulario.Rmd` is the reference formulary) — the file-number prefix and
the in-book chapter number intentionally diverge.

**One slide deck** (from repo root, in R):
```r
rmarkdown::render("Aulas2026/MATF14-NN.Rmd")
```
Decks read `empresas.csv` and `dados_prefeitos.csv` via relative paths, so render from within
`Aulas2026/` or otherwise ensure the working directory resolves those files (they're duplicated,
byte-identical, under `Livro/data/` for the book's own use — keep both copies in sync if the data
changes). Not every schedule slot has its own deck: exam days (P1/P2/P3) have no slide file by
design, they're the continuation of the previous deck.

**Exercise lists** (from `Listas2026/`):
```bash
pdflatex ListaNN.tex   # or latexmk -pdf ListaNN.tex
```
`ListaNN.tex` files `\input{preamble}` for shared styling/macros (`\questao`, `\solucao`,
`\cabecalho`, MATF14 color scheme). `preamble.tex` itself is not compiled standalone.

## Critical constraint: answer keys (gabaritos)

Gabaritos (answer keys) for `Listas2026/` and `Apoio/Listas/` must **never** be committed to this
repository — students have access to this repo (directly or via the course page it feeds), and
answers live in a separate private repo (`matf14-gabaritos-privado`). This is enforced by
`.gitignore` (`Listas2026/Gabarito*.tex`, `Listas2026/Gabarito*.pdf`,
`Apoio/Listas/*gabarito_lista_*.pdf`). Do not create/commit a Gabarito file in `Listas2026/` or
`Apoio/Listas/` even if asked to draft solutions — write those elsewhere. Note this rule does
*not* extend to `Apoio/provas/` (already-applied exams with keys are intentionally tracked there
from the prior semester).

## Conventions when editing content

- Slide decks and book chapters are in Brazilian Portuguese; keep new content in the same
  register and terminology (e.g., "variável aleatória", not "random variable").
- Xaringan decks follow a fixed frontmatter (`metropolis` + `metropolis-fonts` +
  `custom-styles.css`, `seal: false`) and use `---` for slide breaks, `--` for incremental
  reveals within a slide — match existing decks rather than introducing new xaringan themes.
- The book and the slides intentionally overlap in content (the book is closer to a full
  textbook treatment; slides are the in-class presentation) — check both when a topic's content
  changes, since they aren't generated from a single source.
- Companion course: this repo follows the same organizational pattern as
  [MATD48](https://github.com/Raydonal/matd48); when in doubt about a structural convention,
  that repo is the precedent.
