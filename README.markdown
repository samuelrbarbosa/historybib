History Bibliography | [Lincoln Mullen][] | <lincoln@lincolnmullen.com>

This is a [BibTeX][] database that I use for citing works in [Pandoc][]
and [LaTeX][]. It reflects only works that I have cited in certain
projects. The works are mostly about American religious history or early
America. The BibTeX entries are intended to work with Chicago Manual of
Style citations.

Because I now keep most of my reseach in a [Gitit][], I import all the
BibTeX references from that wiki, then `cat` them together with the
older references to create the `master.bib` database. You can probably
safely ignore any of the other BibTeX files in this repository.

You are welcome to use this database however you see fit. You can clone
the database, of course, but I suggest that you [fork the GitHub
repository][] first. Contributions are welcome. You can submit them by
sending a pull request.

The files in the `bibtool-rsc` directory are resource files that sort
and normalize the BibTeX database. I have borrowed these wholesale from
Kieran Healy's [socbibs repository][]. They are intended to be used with
the utility [BibTool][].

I used to generate most of the initial citation data by exports from
[Zotero][]. I've modified Zotero's `bibtex.js` file to give citation
keys in the form `smith1984firstword`, which is the same form used by
Google Books and Google Scholar. Most of the metadata is hand curated.

You might like my [Bibkeys][] Ruby Gem to generate a list of citation
keys.

## A note on using a BibTeX database with Pandoc and LaTeX

There is no perfectly reliable system for generating Chicago
footnote-bibliography citations for historical writing. If you're
preparing a document for publication, there will likely need to be a
stage where you generate an editable version and modify the footnotes by
hand. But this is a brief discussion of your best options for formatting
bibliographies from a BibTeX database, whether from a Pandoc-flavored
Markdown document, or from a LaTeX document.

### Pandoc + citeproc-hs + CSl stylesheet + BibTeX database

Suppose you have a BibTeX database, `history.bib`, and a document
written in Pandoc-flavored Markdown, `document.md`. In that case, you
can use Pandoc in-line citations for items in your database (books and
articles) and Pandoc footnotes for archival citations. For example:

    This sentence has a footnote with a book. [@citationkey2013, p. 145.] 
    This sentence has a footnote with an archival citation. ^[Maryland 
    archives.] This sentence has a footnote with a book and an archival 
    citation.^[Maryland archives; [@citationkey2013, p. 145.]

You can convert this document using Pandoc, which will convert the
citations in your BibTeX database by sending them through citeproc-hs
according to the rules in a Citation Style Language document (see [this
repository][] for a collection of CSL files, including Chicago style).

The Pandoc command will look like this.

    pandoc document.md --bibliography=history.bib --csl=chicago.csl -o 
    document.pdf

If you wish to be able to edit the citations, you should convert the
document to LaTeX, edit them, then convert to PDF using pdflatex.

### Pandoc/LaTeX + biblatex + Historian + BibTeX database

Instead of using Pandoc's citeproc-hs engine and CSL, you can instead
use the tools that come with LaTeX, namely, biblatex and the
biblatex-chicago package.

To do this, you need to include a call to biblatex and historian either
in your Pandoc LaTeX template, or in your LaTeX document class. You can
tweak these options by looking at the [biblatex-chicago package][]
documentation, but this is what I've found works best:

```
% use BibLaTeX with Chicago style
\usepackage[notes,              %use footnotes rather than author-date
            backend=biber,      %use biber to format citations
            autocite=footnote,  %turn autocites into footnotes
            isbn=false,         %don't print ISBNs
            doi=true,           %print DOIs
            url=false,          %don't print URLs
            noibid,             %ibid belongs in the nineteenth century,
            ]{biblatex-chicago}

% Define which BibTeX database to use
\bibliography{history.bib}
```

Then, you need use a switch to tell Pandoc to pass the citations on to
Biblatex instead of handing them to citeproc-hs.

    pandoc document.md --bib=history.bib --biblatex -o document.pdf

Note that this of course works for documents written in LaTeX directly
without the step of converting from Markdown to LaTeX via Pandoc.

  [Lincoln Mullen]: http://lincolnmullen.com
  [BibTeX]: http://www.bibtex.org/
  [Pandoc]: http://johnmacfarlane.net/pandoc/
  [LaTeX]: http://www.latex-project.org/
  [Gitit]: https://github.com/jgm/gitit
  [fork the GitHub repository]: http://help.github.com/fork-a-repo/
  [socbibs repository]: https://github.com/kjhealy/socbibs
  [BibTool]: http://www.gerd-neugebauer.de/software/TeX/BibTool/index.en.html
  [Zotero]: http://zotero.org
  [Bibkeys]: https://github.com/lmullen/bibkeys
  [this repository]: https://github.com/citation-style-language/styles
  [biblatex-chicago package]: http://www.ctan.org/pkg/biblatex-chicago
