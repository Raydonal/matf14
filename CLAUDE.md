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
- `index.Rmd`/`index.html`: the course landing page at the repo root (rendered with
  `prettydoc::html_pretty`), published via GitHub Pages from `main`/`/`. Links out to the book,
  and lists the same schedule as `README.md` — update both when the schedule changes.
- `README.md` has the full 2026.2 class schedule (date → deck mapping) and the rationale for
  merging/skipping specific lecture numbers — consult it before renumbering or reordering decks.

## Build / render commands

**Book** (from repo root, in R):
```r
bookdown::render_book("Livro/index.Rmd")
```
Output config lives in `Livro/_bookdown.yml` (chapter order, `output_dir: "."`) and
`Livro/_output.yml` (gitbook options). `_bookdown.yml` must keep `new_session: no` — with `yes`,
each chapter knits in isolation and the generated `<img src>` paths point one directory level
above where the images actually land, silently breaking every figure without a render error.
Chapters are numbered `01-`..`07-` but the *rendered*
numbering is Capítulo 1–4 plus three unnumbered (A/B/C) appendices (`05-ferramentas-rpython.Rmd`
starts the `(APPENDIX)` block — R/Python tooling reference, mirrors `Aulas2026/MATF14-02.Rmd`;
`06-revisao-calculo.Rmd` and `07-formulario.Rmd` follow) — the file-number prefix and the in-book
chapter/appendix number intentionally diverge. Only `05-ferramentas-rpython.Rmd` should contain the
`# (APPENDIX) Apêndices {-}` marker line — bookdown errors ("more than one appendix title") if it
appears in more than one file.

**One slide deck** (from repo root, in R):
```r
rmarkdown::render("Aulas2026/MATF14-NN.Rmd")
```
Decks read `empresas.csv` and `dados_prefeitos.csv` via relative paths, so render from within
`Aulas2026/` or otherwise ensure the working directory resolves those files (they're duplicated,
byte-identical, under `Livro/data/` for the book's own use — keep both copies in sync if the data
changes). Not every schedule slot has its own deck: exam days (P1/P2/P3) have no slide file by
design, they're the continuation of the previous deck.

**Landing page** (from repo root, in R):
```r
rmarkdown::render("index.Rmd")
```
Uses `prettydoc::html_pretty`; output is the committed `index.html` at repo root (GitHub Pages
serves this directly, not via a `docs/` folder or Actions build).

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

## Rendering pitfalls in xaringan slides (`Aulas2026/`)

`rmarkdown::render()` exits 0 even when these break the output — a clean render is not proof the
deck is correct. Always open the generated HTML (or diff it) after editing formulas or dense
slides:

- **Subscripts vanish.** `remark.js` parses markdown *before* MathJax runs, so it doesn't know
  `$$...$$`/`\(...\)` mark math — a lone `_` inside a formula (e.g. multi-subscript sums, `\bar{x}`
  cases) reads as italic open/close and disappears. Fix: escape as `\_` inside math blocks. This
  only applies to `Aulas2026/` (xaringan); `Livro/` (bookdown/pandoc) handles `_` in math fine
  without escaping.
- **`<`/`>` vanish.** Same root cause: `remark.js` reads `<...>` as a possible HTML tag and drops
  everything between the first `<` and the next `>`, even inside `$$`. A backslash escape (`\<`)
  does *not* work here (it tries to match the tag before the escape is processed). Fix: use HTML
  entities `&lt;`/`&gt;` instead of the literal characters. Again, only `Aulas2026/`, not `Livro/`.
- **Slide overflow is invisible in the render.** A slide with too much text/graphic/table stacked
  via `--` progressive reveal can exceed the ~681px visible slide area; `rmarkdown::render()`
  doesn't fail, it just clips silently. Fix by splitting into more slides (`--` → `---`) or shrinking
  `out.width`/`out.height`.
- Do not write literal `R\(` / `R\)` / `R\$` when you mean "R$" (the currency) — those are
  remark.js math delimiters / a Pandoc-only escape that doesn't exist client-side, and MathJax
  will try to render a fragment of the sentence as a formula.
- **Inline math with a single backslash, `\(...\)`, silently fails — use `\\(...\\)` (doubled
  backslash) instead.** Same root cause as the subscript bug: `remark.js`'s markdown parser
  consumes a lone backslash as a generic escape character (the same mechanism that lets `\*`
  print a literal `*` instead of starting emphasis) *before* MathJax ever sees the page, so
  `\(X\)` degrades to the literal text `(X)` with no backslash left for MathJax to recognize as a
  delimiter — no error, no warning, it just silently renders as plain parenthesized text. Doubling
  the backslash (`\\(X\\)`) survives remark's escape-consumption with exactly one backslash intact
  in the final client-side content, which MathJax then reads correctly. This affects **only
  inline** math (`\(...\)`) in `Aulas2026/`; display math (`$$...$$`) is unaffected regardless of
  backslash count, and `Livro/` (pandoc, no remark.js) needs single backslash `\(...\)` as normal.
  Confirmed via isolated render tests in a 2026-09 session, after this exact bug turned out to
  affect 100% of one deck's inline math (`MATF14-05.Rmd`, 29 instances) — screenshot verification
  is the only way to catch this, `rmarkdown::render()` exits 0 regardless.

## Rendering pitfall in `Livro/` raw-HTML callout boxes (`caixa-aplicacao`, `caixa-economia`, `caixa-r`, ...)

Discovered via an actual headless-browser screenshot, not caught by any static check: every
callout box in `Livro/*.Rmd` is written as a raw-HTML block (` ```{=html}\n<div class="caixa-...">...</div>\n``` `).
Pandoc passes raw-HTML blocks straight through to the output **without running its markdown/math
parser on the contents** — so `$...$` inline math typed inside one of these divs is never
converted to `\(...\)`, and MathJax's config here does not recognize bare `$...$` as math either.
The result: the literal text `$P(A\cap B)\approx P(A)P(B)$` (dollar signs and all) is what
students see, not a typeset formula. The same applies to a backslash-escaped currency sign: `R\$`
written inside one of these boxes is never unescaped by Pandoc (that only happens for real
markdown), so a literal backslash shows up in the page (`R\$` instead of `R$`).
**Rule: inside any `{=html}` callout box, write inline math directly as `\(...\)` (never `$...$`),
and write currency as plain `R$` (never `R\$`, never inside math delimiters).** This bug was
pervasive and pre-existing across the whole book (all 4 chapters) before it was found and fixed
project-wide in a 2026-09 session — if you add or edit a callout box, re-check this specifically;
`rmarkdown`/`bookdown` render with exit 0 either way, so only opening the actual page (or a
headless screenshot) catches it. A `` `r ...` `` inline-R expression inside one of these boxes is
still evaluated by knitr as usual (e.g. `` `r df$coluna` ``) — that `$` is R syntax, not math, and
is unaffected by this rule.

### Headless-browser verification recipe that actually works in this sandbox

`chromote` (R package) + the system's `google-chrome` binary are both installed and *can* load
pages including their external CDN scripts (remark.js, MathJax) — network access is not the
problem. The trap: do **not** call/await `Page$loadEventFired()` after `Page$navigate()` on these
files — for reasons not fully diagnosed, `document.readyState` on these pages can get stuck at
`"interactive"` forever even though remark.js/MathJax already finished their work, so waiting for
the load event (or anything built on it) hangs indefinitely (this killed multiple agents with a
600s stall in one revision session). Instead: navigate, then a **fixed `Sys.sleep()`** (~6-8s is
enough for remark.js to build slides and/or MathJax to typeset).

**For a xaringan deck with more than one slide to check, do NOT re-`Page$navigate()` to a new
`#N` URL hash in a loop** — rapid repeated navigation in one session is unreliable (confirmed:
it can silently keep displaying a stale/earlier slide while the visible page-number footer still
looks plausible, giving you a screenshot of the wrong slide with no error). Instead, navigate
**once**, then drive slide changes with remark.js's own JS API, which is instant and reliable:
```r
library(chromote)
b <- ChromoteSession$new()
b$Emulation$setDeviceMetricsOverride(width = 992L, height = 744L, deviceScaleFactor = 1, mobile = FALSE)  # xaringan needs an explicit viewport or screenshots come out blank/tiny
b$Page$navigate(paste0("file://", normalizePath("Aulas2026/MATF14-NN.html")))
Sys.sleep(6)  # let remark.js build the deck + MathJax typeset once
n <- b$Runtime$evaluate("slideshow.getSlideCount()")$result$value  # `slideshow` is remark.create()'s return value, a global in xaringan output
for (i in 1:n) {
  b$Runtime$evaluate(sprintf("slideshow.gotoSlide(%d)", i))
  Sys.sleep(0.8)
  b$screenshot(sprintf("/path/s%02d.png", i), selector = ".remark-slide-container")
}
```
For a single `Livro/*.html` (gitbook) page, there's no `slideshow`/multi-slide concept — just
navigate once and screenshot (no viewport override needed either):
```r
b$Page$navigate(paste0("file://", normalizePath("Livro/some-page.html")))
Sys.sleep(7)
b$screenshot("/path/out.png")
```
Then actually open/read the PNG(s) — do not just check that the call returned without error. To
review many slides economically, `montage` (ImageMagick) a batch into one contact-sheet image
(e.g. `montage s01.png s02.png s03.png s04.png s05.png s06.png -tile 2x3 -geometry 496x372+2+2
-background white /tmp/contact.png`) and read the contact sheet instead of each PNG individually.

### Rendering pitfall: a "Bloco N" divider slide directly followed by code (no `---`)

Found via the recipe above, and it was **pervasive** (11 of the ~15 decks that have a "Bloco 4:
Uso do R" section had this exact bug, pre-existing, not something this session introduced): a
`class: inverse, center, middle` slide (dark background, used for section dividers) is supposed
to be its own slide, with a `---` break before the real content starts. Where that `---` was
missing, the following R code chunk / inline-code-heavy text rendered **on the dark background**,
and the syntax-highlighting theme's code-pill styling (light gray background, dark/muted text)
is illegible there — light-on-light, effectively invisible. This is invisible in a plain render
and in a static grep for math-escaping bugs; only an actual screenshot shows it. Fix: insert a
`---` right after the divider heading, before the code starts, e.g.:
```
class: inverse, center, middle

# Bloco 4: Uso do R

---                      <- this line was missing in 11 decks

```{r uso-r, eval=FALSE}
...
```
```
If you add a new `class: inverse` divider anywhere, always give it its own `---`-delimited slide
before any code or inline-code-heavy content follows.

### Rendering pitfall: a single-line multi-term display formula can overflow horizontally

A `$$...$$` block with several `\qquad`-separated terms on one logical line (e.g.
`$$P(X=0)=\ldots, \qquad P(X=1)=\ldots, \qquad P(X=2)=\ldots$$`) renders as one continuous
un-wrapped line — if the combined width exceeds the slide, the tail gets cut off at the right
edge with no error or visual warning in a plain render. Only a screenshot shows it. Fix: split
into separate `$$...$$` blocks (one term each, stacked vertically) rather than one wide line.
This is a real, screenshot-confirmed instance found in `Aulas2026/MATF14-17.Rmd` — if you write a
multi-term formula spanning a full clause on one line, check it visually, especially with 3+
`\qquad`s or long `\text{}` labels.

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

## Prior session context

`RETOMADA.md` at repo root is a handoff log from a past review session (dated entries, not kept
up to date automatically) — it has the original diagnosis behind the rendering pitfalls above,
plus off-repo backup practice and open professor-facing decisions (e.g. whether to make the repo
private while keeping GitHub Pages public). Worth a skim if picking up open threads, but treat it
as a point-in-time snapshot, not living documentation.
