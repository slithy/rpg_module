STYLE=basic-stats
STAT_FILE=$(STYLE).def

TARGET=rpg-module.pdf
CLASS=rpg-module.cls
STYLE_FILE=$(STYLE).sty

ZIP_TARGET=/tmp/rpg-module.zip
ZIPFILES=README LICENSE $(TARGET) $(CLASS) $(STYLE_FILE) $(STAT_FILE) LICENSE doc/ examples/

all: $(TARGET) examples

$(TARGET): $(STAT_FILE)
	cd doc; make install

examples: $(STAT_FILE)
	cd examples_src/monster_manual; make install
	cd examples_src/b1;             make install
	cd examples_src/b3;             make install
	cd examples_src/x2;             make install
	cd examples_src/basic;          make install
	cp examples_src/README examples/README.examples

show: $(TARGET)
	evince $(TARGET)

$(STAT_FILE): $(STYLE)/publish $(STYLE)/$(STYLE).csv
	$(STYLE)/publish $(STYLE)/$(STYLE).csv > $@

zip: $(ZIPFILES) clean
	rm -f $(ZIP_TARGET)
	rm -rf /tmp/rpg-module
	mkdir /tmp/rpg-module
	cp -r $(ZIPFILES) /tmp/rpg-module
	find /tmp/rpg-module -name Makefile -exec rm -f {} \;
	cd /tmp; zip -r $(ZIP_TARGET) rpg-module/

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut
	cd examples_src/monster_manual; make clean
	cd doc;                         make clean
	cd examples_src/b1;             make clean
	cd examples_src/b3;             make clean
	cd examples_src/x2;             make clean
	cd examples_src/basic;          make clean

clobber: clean
	rm -f $(TARGET) $(STAT_FILE)
	rm -rf examples/*
