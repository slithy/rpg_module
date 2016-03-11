TARGET=module.pdf
CLASS=module.cls

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS)
	pdflatex $<

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc

clobber: clean
	rm -f $(TARGET)
