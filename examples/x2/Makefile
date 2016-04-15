TARGET=x2.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE)
	pdflatex $<

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET)
