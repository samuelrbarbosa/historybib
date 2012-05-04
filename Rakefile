desc 'sort bibliography'
task :sort do
        puts 'Sorting the bibliography.'
        sh 'bibtool -s -i history.bib -o history.bib'
        sh 'bibtool -r bibtool-rsc/crossref.rsc -i history.bib -o history.bib'
        sh 'bibtool -r bibtool-rsc/fix-page-range.rsc -i history.bib -o history.bib'
        puts 'Finished sorting the bibliography.'
end
