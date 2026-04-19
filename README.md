# ptptex_template

A minimal **PTEP-style** LaTeX template (with a preprint option) centered on a conservative, submission-friendly workflow.

This repository intentionally ships as a **self-contained directory**: download the whole repository and compile `main.tex`.  
The template is **not** aimed at LaTeX beginners. As a LaTeX writing style, see
https://sites.google.com/view/o-morikawa/latex

## What to download / what to edit

Download **all files** in this repository (as a ZIP, or via `git clone`) and keep them in the same directory:

- `main.tex` — the entry point (edit this)
- `ptephy_om.cls` — the class file (includes a small set of personal “minimal macros”)
- `utphys.bst` — BibTeX style (used by `\bibliographystyle{utphys}`)
- `natbib.sty`, `authblk-TI.sty` — bundled for portability / submission systems

If you use a bibliography, prepare `ref.bib` (or change `\bibliography{ref}` in `main.tex`).

### (Optional) Complile

Added the compilation helper script texbuild.

- A script for automating compilation
- Engine selection based on a header directive (`%#! latex-command` at the beginning of the file)
- Automatic BibTeX execution
- Recompilation control
- SyncTeX option support

`texbuild main.tex`

## Why macros are bundled inside the class

From a programming/design standpoint, separating personal macros into a dedicated `*.sty` is usually cleaner.

However, some journal / preprint submission pipelines (e.g. APS/REVTeX-oriented flows, and certain arXiv processing constraints) can be surprisingly restrictive about multi-file structures and local style loading.  
To reduce friction in practice, this template keeps the “minimal macro set” **inside** `ptephy_om.cls`.

If your environment allows a cleaner split, feel free to move the macro block out into your own `mydefs.sty`—just be aware that portability may decrease.

## Minimal macro set (quick reference)

The following convenience macros are defined in `ptephy_om.cls` under `%% MY SETTING` (near the end of the file).

### Operators

Defined via `\DeclareMathOperator` (so spacing is operator-correct):

- `\tr`, `\Tr`
- `\re`, `\im`, `\Arg`
- `\diag`, `\supp`
- `\Erf`, `\Erfi`
- `\sgn`, `\Res`, `\ord`, `\rank`, `\vol`

### Constants (roman)

- `\rmi` for the imaginary unit
- `\rmd` for differentials
- `\rme` for the base of natural logarithms

### Bra–ket

Fixed-size (good for inline):
- `\bra{\psi}` → ⟨ψ\rvert
- `\ket{\psi}` → \lvert ψ⟩
- `\braket{\phi|\psi}` → ⟨φ\rvertψ⟩

Auto-sized (good for display math):
- `\Bra{...}`, `\Ket{...}`, `\Braket{...}`

### Blackboard bold sets

- `\bbN`, `\bbZ`, `\bbR`, `\bbC`, `\bbH`

### Sub/superscripts as *labels* (roman)

Use these to avoid things like `V_{eff}` being read as a product of variables:

- `\vsub{V}{eff}` → \(V_{\mathrm{eff}}\)
- `\vsup{T}{c}` → \(T^{\mathrm{c}}\)

### Quantity + unit

- `\unit{10}{GeV}` → \(10\,\mathrm{GeV}\)

### Feynman slash

- `\Slash{p}` (minimal definition; adjust if you prefer a dedicated slashed package)

### Draft colors

- `\red{...}`, `\magenta{...}`, `\cyan{...}`, `\blue{...}`, `\teal{...}`

For final submissions you may want to avoid leaving colored text in the output.

## Notes

- `main.tex` is intentionally compact; feel free to reformat it for readability/diff-friendly editing.
- The class file already loads a small set of commonly-used math/graphics packages (AMS + `mathtools`, `graphicx`, `xcolor`, `bm`).

---

**Repository:** https://github.com/o-morikawa/ptptex_template
