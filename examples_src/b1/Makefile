INSTALLDIR=../../examples
TARGET=b1.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE)
	pdflatex $<

install: $(TARGET)
	mv $(TARGET) $(INSTALLDIR)
	cp $(subst pdf,tex,$(TARGET)) $(INSTALLDIR)

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET)
