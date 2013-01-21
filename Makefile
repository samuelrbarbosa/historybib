# Commands using bibtool to clean up the bibliography

all : wiki sort keys

# Import refs from the research wiki, then cat to existing refs
wiki : 
	bibtool ~/acad/research/wikidata/*.page > wiki.bib 2> /dev/null
	cat library.bib wiki.bib > master.bib

# sorting the bibliography
sort : master.bib
	bibtool -s -i master.bib -o master.bib
	bibtool -r bibtool-rsc/crossref.rsc -i master.bib -o master.bib
	bibtool -r bibtool-rsc/fix-page-range.rsc -i master.bib -o master.bib

keys : master.bib
	bibkeys -s master.bib > citekeys.txt

push : sort keys master.bib
	git add master.bib
	git commit -m "updated bib"
	git push origin master
