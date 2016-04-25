TARGET=rpg-module.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex %.toc
	pdflatex $<

%.toc: %.tex
	pdflatex $<

install: $(TARGET)
	mv $(TARGET) ..

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut
