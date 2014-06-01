Project.pdf: *tex
	ruby erstat.rb
	pdflatex Projekt.tex

clean:
	rm -f *aux *toc *log *pdf *~ *out
