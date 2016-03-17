TARGET=module.pdf
CLASS=module.cls
STYLES=basic_stats.sty

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLES) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS)
	pdflatex $<

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc

clobber: clean
	rm -f $(TARGET)
