# Thesis Template (English starter)

Hosei University, Intelligent Systems Laboratory

This starter contains only the chapter structure and essential comments. Consult the separately distributed example version for figures, tables and code examples.

## Getting started

1. Students of the Intelligent Systems Laboratory use the Overleaf project prepared by their supervisor.
   Otherwise, copy this entire folder or upload the starter zip to Overleaf (compilation may time out on Overleaf's free plan).
2. Select **LuaLaTeX** as the compiler. Locally, run `latexmk main.tex` in this folder.
3. Set the title, registered name, katakana name, student ID and supervisor in `main.tex`. For a bachelor's thesis, change `master` to `bachelor`.
4. Set `\fiscalyear{2026}` to your submission academic year (April to March) and keep it fixed in the final version.
5. Write your text in `chapters/`, following the comments. Adapt chapter and section names to your research.

The initial PDF intentionally contains headings without body text. Do not edit or delete `hosei-thesis.cls` or `latexmkrc`.
For a Master's thesis written in English, include both the English abstract and Japanese 要旨 (laboratory rule).

## Sources, figures and optional material

- `references.bib` is empty. Add works you have read and preserve every author's name in the original order.
- After adding a `\cite{key}` in the text, uncomment `\bibliography{references}` in `main.tex`. Leave it commented until you have a citation.
- Put your figures in `figures/`. Use `\label{…}` and `\cref{…}` for cross-references.
- Enable lists of figures/tables, publications and appendices only when needed. Appendices also require the `\appendix` line.
- Add `review` to the class options for line numbers, a review date stamp and coloured `\TODO{…}` and `\rev{…}` text.

## Before submission

- [ ] Finish the text and remove empty or unnecessary chapters and sections.
- [ ] Check the cover information and explicitly fixed submission year in `\fiscalyear{…}`.
- [ ] Remove `review` and leave no `\TODO` text.
- [ ] Use actual research results and refer to and explain every figure and table.
- [ ] Separate tuning and final test data; report comparison conditions, seeds, runs and stopping criteria.
- [ ] Explain whether each summary measures variation across instances or across seeds.
- [ ] Check bibliography details against original sources and resolve warnings and undefined references.
- [ ] Check the current submission instructions for the file name, size and submission procedure.
