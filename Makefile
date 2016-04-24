STYLE=basic_stats

TARGET=module.pdf
CLASS=module.cls
STYLE_FILE=$(STYLE).sty
STAT_FILE=$(STYLE).def

ZIP_TARGET=/tmp/module.zip
ZIPFILES=module.tex $(TARGET) $(CLASS) $(STYLE_FILE) $(STAT_FILE) module_art_cover.png module_art_interior.png module_logo.pdf module_map.png LICENSE examples/*

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

%.pdf: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE) %.toc
	pdflatex $<

%.toc: %.tex $(CLASS) $(STYLE_FILE) $(STAT_FILE)
	pdflatex $<

$(STAT_FILE): $(STYLE)/publish $(STYLE)/$(STYLE).csv
	$(STYLE)/publish $(STYLE)/$(STYLE).csv > $@

zip: $(ZIPFILES)
	zip $(ZIP_TARGET) $(ZIPFILES)

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut

clobber: clean
	rm -f $(TARGET) $(STAT_FILE)
