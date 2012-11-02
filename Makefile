# Commands using bibtool to clean up the bibliography

all : sort keys

sort : history.bib
	# sorting the bibliography
	bibtool -s -i history.bib -o history.bib
	bibtool -r bibtool-rsc/crossref.rsc -i history.bib -o history.bib
	bibtool -r bibtool-rsc/fix-page-range.rsc -i history.bib -o history.bib

keys : history.bib
	bibkeys -s history.bib > citekeys.txt

push : sort keys history.bib
	git add history.bib
	git commit -m "updated bib"
	git push origin master
