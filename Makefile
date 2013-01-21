# Commands using bibtool to clean up the bibliography

all : wiki sort keys

# Import refs from the research wiki, then cat to existing refs
wiki : 
	bibtool ~/acad/research/wikidata/*.page > wiki.bib 2> /dev/null
	cat library.bib wiki.bib > history.bib

# sorting the bibliography
sort : history.bib
	bibtool -s -i history.bib -o history.bib
	bibtool -r bibtool-rsc/crossref.rsc -i history.bib -o history.bib
	bibtool -r bibtool-rsc/fix-page-range.rsc -i history.bib -o history.bib

keys : history.bib
	bibkeys -s history.bib > citekeys.txt

push : sort keys history.bib
	git add history.bib
	git commit -m "updated bib"
	git push origin master
