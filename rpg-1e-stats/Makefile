TARGET=test.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex
	pdflatex $<

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET)
