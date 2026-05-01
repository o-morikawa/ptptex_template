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

### (Optional) Compile

Added the compilation helper script `texbuild`.

- A script for automating compilation
- Engine selection based on a header directive (`%#! latex-command` at the beginning of the file)
- Automatic BibTeX execution
- Recompilation control
- SyncTeX option support

How to use:

```sh
chmod +x texbuild
./texbuild main.tex
```

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

- `\bra{\psi}` → `⟨ψ|`
- `\ket{\psi}` → `|ψ⟩`
- `\braket{\phi|\psi}` → `⟨φ|ψ⟩`

Auto-sized (good for display math):

- `\Bra{...}`, `\Ket{...}`, `\Braket{...}`

### Blackboard bold sets

- `\bbN`, `\bbZ`, `\bbR`, `\bbC`, `\bbH`

### Sub/superscripts as *labels* (roman)

Use these to avoid things like `V_{eff}` being read as a product of variables:

- `\vsub{V}{eff}` → $begin:math:text$V\_\{\\mathrm\{eff\}\}$end:math:text$
- `\vsup{T}{c}` → $begin:math:text$T\^\{\\mathrm\{c\}\}$end:math:text$

### Quantity + unit

- `\unit{10}{GeV}` → $begin:math:text$10\\\,\\mathrm\{GeV\}$end:math:text$

### Feynman slash

- `\Slash{p}` (minimal definition; adjust if you prefer a dedicated slashed package)

### Draft colors

- `\red{...}`, `\magenta{...}`, `\cyan{...}`, `\blue{...}`, `\teal{...}`

For final submissions you may want to avoid leaving colored text in the output.

### Comments and revision highlights

The class provides a small workflow for internal comments and revised manuscripts.  
These commands are intended for collaborative editing, referee-response revisions, and preparing highlighted revised versions.

#### Internal comments

Internal comments can be shown or hidden by class options.

To show comments:

```tex
\documentclass[preprint,comments]{ptephy_om}
```

To suppress comments:

```tex
\documentclass[preprint,nocomments]{ptephy_om}
```

The basic comment macro is

```tex
\pteCmt{color}{label}{comment}
```

For example,

```tex
\pteCmt{teal}{OM}{Check this statement.}
```

prints a colored comment of the form

```tex
[OM: Check this statement.]
```

when the `comments` option is enabled.  
When `nocomments` is used, the comment is removed from the output.

The template also defines an author-specific shortcut:

```tex
\cmtOM{Check this statement.}
```

If you want to add collaborators, define your own shortcuts in the preamble or in the class file:

```tex
\newcommand{\cmtTH}[1]{\pteCmt{red}{TH}{#1}}
\newcommand{\cmtSO}[1]{\pteCmt{blue}{SO}{#1}}
```

The recommended naming rule is to use a prefix such as `\cmt...` for comment macros.  
Avoid very short names such as `\TH`, since they may conflict with existing LaTeX commands.

#### Revision highlights

Revised manuscripts often require highlighted changes.  
This template provides a numbered revision macro:

```tex
\rev{revision-number}{text}
```

For example:

```tex
\rev{1}{text changed in the first revision}

\rev{2}{text changed in the second revision}
```

Use the `revision` option to enable highlighting:

```tex
\documentclass[preprint,revision]{ptephy_om}
\revisionnum{1}
```

Only the text whose revision number matches `\revisionnum{...}` is highlighted.  
All other `\rev{...}{...}` text is printed normally.

For example,

```tex
\documentclass[preprint,revision]{ptephy_om}
\revisionnum{2}
```

highlights only

```tex
\rev{2}{...}
```

whereas

```tex
\rev{1}{...}
```

is printed as ordinary text.

For a clean version, use

```tex
\documentclass[preprint,norevision]{ptephy_om}
```

or simply omit the `revision` option.

The default revision highlight color is `magenta`.  
To change it in the manuscript preamble, write for example:

```tex
\renewcommand{\pteRevColor}{blue}
```

A typical workflow is:

```tex
% internal draft
\documentclass[preprint,comments,norevision]{ptephy_om}

% first revised manuscript with highlighted changes
\documentclass[preprint,nocomments,revision]{ptephy_om}
\revisionnum{1}

% second revised manuscript with highlighted changes
\documentclass[preprint,nocomments,revision]{ptephy_om}
\revisionnum{2}

% final clean version
\documentclass[preprint,nocomments,norevision]{ptephy_om}
```

This keeps the manuscript source stable: the marked text remains in the source, while the output is controlled by class options and `\revisionnum{...}`.

## Notes

- `main.tex` is intentionally compact; feel free to reformat it for readability/diff-friendly editing.
- The class file already loads a small set of commonly-used math/graphics packages (AMS + `mathtools`, `graphicx`, `xcolor`, `bm`).

---

**Repository:** https://github.com/o-morikawa/ptptex_template