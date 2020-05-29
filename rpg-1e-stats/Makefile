#TARGET=test_gnoll.pdf
TARGET=test_all.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex
	pdflatex $<

convert:
	./convert

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET)

.PHONY: convert
