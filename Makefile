TARGET=module.pdf
CLASS=module.cls
STYLES=basic_stats.sty
ZIP_TARGET=/tmp/module.zip
ZIPFILES=LICENSE basic_stats.sty module_art_cover.png module_art_interior.png module.cls module_logo.pdf module_map.png module.pdf module.tex

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLES) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS)
	pdflatex $<

zip: $(ZIPFILES)
	zip $(ZIP_TARGET) $(ZIPFILES)

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET)
