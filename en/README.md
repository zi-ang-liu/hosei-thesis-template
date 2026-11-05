# Master's Thesis Template (English)

Hosei University, Graduate School of Science and Engineering — Intelligent Systems Laboratory

## Read this first

- Compile with **LuaLaTeX**.
- Edit only the files below. **Do not edit or delete** `hosei-thesis.cls` or `latexmkrc`.

| File | Contents |
|---|---|
| `main.tex` | Thesis information (title, name, student ID, ...) and the list of chapters |
| `chapters/` | One file per chapter |
| `references.bib` | Bibliography data |
| `figures/` | Figure files (PDF, PNG, JPEG) |

Each chapter file explains, in comments (lines starting with `%%`), what to write in that chapter and how to write it in LaTeX.

This is the **example version**. Blocks labelled "Writing guidance (remove before submission)" explain how to write; they are not thesis text.
Delete each `writingnote` environment before submission and replace the example prose with your own research.
The experimental figures and tables contain fictional data and must not be used as measured results.
To start with only the chapter structure and essential comments, use the separately distributed **`hosei-thesis-en-starter.zip`** (`starter/en/` in the repository).

## Structure of the thesis

| File | Chapter | Contents |
|---|---|---|
| `01-introduction.tex` | Introduction | background, problem, objective, contributions, organization |
| `02-preliminaries.tex` | Preliminaries | definition of the target problem and basics of the methods used (**existing knowledge**) |
| `03-related-work.tex` | Related Work | related studies and the position of this work (the gap that motivates your method) |
| `04-method.tex` | Proposed Method | **your own contribution**, in enough detail to be reproduced |
| `05-experiments.tex` | Computational Experiments | settings (instances, methods compared, metrics, parameters, environment), results, discussion |
| `06-conclusion.tex` | Conclusion | summary and future work |
| `publications.tex` | List of Publications | your papers and presentations (delete the line in `main.tex` if you have none) |

Keep the Preliminaries (what textbooks and papers say) clearly separate from the Proposed Method (your contribution).
You may change the number and names of chapters to suit your research.

## On Overleaf

1. Students of the Intelligent Systems Laboratory are invited by their supervisor to a project prepared for them. Open it from the invitation email and use it as it is.
   If you copy it to your own account, compilation may time out on Overleaf's free plan (limit: 10 seconds).
2. Otherwise, download a zip file from [Releases](https://github.com/zi-ang-liu/hosei-thesis-template/releases/latest) on GitHub,
   upload it with New Project → Upload Project in Overleaf, and set Menu → Settings → Compiler to **LuaLaTeX**.
   If compilation times out on the free plan, compile on your own computer (see below).
3. The first compilation may take a while because the fonts have to be prepared.

## On your own computer

- Install TeX Live 2023 or later.
- Run `latexmk main.tex` in this folder to produce `main.pdf` (`latexmkrc` selects LuaLaTeX and upBibTeX).
- In VS Code (LaTeX Workshop), choose the recipe **"latexmk (latexmkrc)"**.

## Sending a draft to your supervisor (review mode)

Add `review` to the class options in `main.tex`:

```latex
\documentclass[en,master,review]{hosei-thesis}
```

- Line numbers appear in the left margin, so comments can refer to "line 12".
- `\TODO{write this later}` is shown in red.
- `\rev{revised sentence}` is shown in blue (use it to mark what you changed since the last draft).
- Each page is stamped "Review copy" with the date.

Remove `review` for the final version. `\TODO` is then hidden (and a warning is shown if any remain), and `\rev` becomes normal text.

## Common commands

| Task | Command |
|---|---|
| Chapters and sections | `\chapter{…}`, `\section{…}`, `\subsection{…}` |
| Cross-references | add `\label{fig:result}` and write `\cref{fig:result}` → "Figure 4.1" (`\Cref` at the start of a sentence) |
| Citations | `\cite{dantzig1957discrete}` → a number such as "[1]"; several at once with `\cite{a,b}` |
| Figures | `\includegraphics[width=0.8\linewidth]{file}` (files in `figures/`) |
| Figures side by side | `subfigure` environment (example in `chapters/05-experiments.tex`) |
| Simple diagrams | `tikzpicture` environment (TikZ; example in `chapters/04-method.tex`) |
| Tables | `table` environment with `tabular` (examples in `chapters/03-related-work.tex` and `05-experiments.tex`) |
| Math | inline `$…$`, displayed `equation`, multi-line `align` (optimization model in `chapters/02-preliminaries.tex`) |
| Lists of definitions | `description` environment (example in `chapters/04-method.tex`; a list of symbols is shown in a comment in `02-preliminaries.tex`) |
| Lists | `itemize` (bullets), `enumerate` (numbers) |
| Algorithms | `algorithm` environment (example in `chapters/02-preliminaries.tex`) |
| Source code | `lstlisting` environment (example in `chapters/appendix.tex`) |

The examples in the chapters (the 0-1 knapsack problem and so on) only show how to write. Replace them with the content of your research.

- `\cref` adds "Figure", "Table", "Chapter", "Eq." and the number automatically. Never type numbers by hand.
- Start label names with `chap:`, `sec:`, `fig:`, `tab:`, `eq:`, `alg:` or `lst:` to keep them organized.

## Bibliography (references.bib)

`references.bib` contains an example of each type (books, journal articles, conference papers, Japanese articles and web pages).
It includes Zobel's *Writing for Computer Science*, which is worth reading before you start writing.
The writing guidance also cites Glasman-Deal's *Science Research Writing for Non-Native Speakers of English*, which explains the typical structure of each part of a thesis, and the free *Academic Phrasebank* (<https://www.phrasebank.manchester.ac.uk/>), which collects phrases commonly used in academic writing.

**Finding sources and BibTeX entries**

- English works: Google Scholar (Cite → BibTeX), DBLP (computer science), or the publisher's page.
- Japanese works: CiNii Research and J-STAGE (BibTeX can be downloaded from the article page).
- Automatically generated BibTeX often contains errors or omissions. Always check the authors, title, volume, number, pages and year against the original.
- If you have many references, a reference manager such as Zotero can export BibTeX for you (optional).

**Writing entries**

- Use ASCII keys such as `dantzig1957discrete` (first author's surname + year + first word of the title).
- Japanese works can be written in the same way. Separate authors with `and`.
- Record all authors in the original order instead of shortening the data with `and others`. Let the bibliography style handle any abbreviation in the output.
- For web pages, use the misc type with the URL and the access date (see the example in `references.bib`).
- Never write the at-sign character in comments in a `.bib` file. BibTeX does not treat `%` lines as comments and will report an error.
- Only the works you `\cite` appear in the reference list, numbered in the order of citation.

**What to cite**

- Cite primary sources such as peer-reviewed journal and conference papers and books. Do not cite a work you have only seen quoted elsewhere without reading the original.
- Do not cite Wikipedia, personal blogs or the output of generative AI. Cite web pages only for official information such as software documentation or public statistics.

## Requirements for the Master's thesis

- Include **both** the English Abstract and the Japanese 要旨 (`chapters/abstract.tex`).
- The cover page contains all items required by the Graduate School, and its labels are in Japanese. Fill in `\titleEN`, `\titleJA`, `\author`, `\authorkana` (フリガナ), `\studentid` and `\supervisor`.
- Submit a PDF named `<student ID><name>.pdf` without a space, e.g. `24R0000法政太郎.pdf`, of at most 20 MB. LuaLaTeX embeds all fonts automatically.
- The 論文要旨 is a separate document (2–8 pages). Follow the Graduate School's instructions and form on Hoppii.

## Tips

- Separate paragraphs with an empty line. Do not use `\\` to break lines.
- Make figures as PDF (vector graphics) whenever possible: save diagrams from draw.io or PowerPoint as PDF, and save matplotlib plots with `plt.savefig("figure.pdf")`. Use PNG or JPEG for photos.
- When an error occurs, read the **first** error in the log: find the line starting with `!` and its line number.
- Choose where long titles break on the cover with `\\`, e.g. `\titleEN{First half\\second half}`. This matters especially for the Japanese title, which can otherwise break in the middle of a word.
- Set `\fiscalyear{2026}` in `main.tex` to your submission academic year (April to March) and keep it fixed in the final version. Omitting it makes the year depend on the compilation date, so recompiling years later would change the cover.
- Follow the notation of the standard textbook in your field (for reinforcement learning, the textbook by Sutton and Barto), and use it consistently throughout the thesis (e.g., bold for vectors, calligraphic letters for sets).

## Checklist before submission

- [ ] The `review` option has been removed (no line numbers, no "Review copy" stamp).
- [ ] No `\TODO` remains (no "TODO remains" warning in the log).
- [ ] The log shows no warnings, in particular no "undefined" references or citations.
- [ ] The title, name, フリガナ, student ID and supervisor on the cover are correct.
- [ ] The correct submission academic year is explicitly set with `\fiscalyear{…}` and checked on the cover.
- [ ] Every figure and table is referred to and explained in the text.
- [ ] The authors, titles, volumes, numbers, pages and years of all references have been checked.
- [ ] No placeholder text ("…", "XX", "○○") remains.
- [ ] All `writingnote` environments have been removed and fictional figures, tables and comparisons have been replaced with actual research content.
- [ ] The file name and the submission method follow the instructions.
