TARGET=module.pdf
CLASS=module.cls
STYLES=basic_stats.sty basic_stats.lst
ZIP_TARGET=/tmp/module.zip
ZIPFILES=module.pdf module.cls module.tex basic_stats.sty basic_stats.lst module_art_cover.png module_art_interior.png module.cls module_logo.pdf module_map.png LICENSE

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLES) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS)
	pdflatex $<

basic_stats.lst: basic_stats/publish basic_stats/basic_stats.csv
	basic_stats/publish basic_stats/basic_stats.csv > $<

zip: $(ZIPFILES)
	zip $(ZIP_TARGET) $(ZIPFILES)

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET) basic_stats.lst
