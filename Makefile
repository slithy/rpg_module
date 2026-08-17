STAT_FILE=rpg-basic-stats.def rpg-1e-stats.def
STYLE_FILE=rpg-basic-stats.sty rpg-1e-stats.sty

TARGET=rpg-module.pdf
CLASS=rpg-module.cls

ZIP_TARGET=/tmp/rpg-module.zip
ZIPFILES=README LICENSE $(TARGET) $(CLASS) $(STYLE_FILE) $(STAT_FILE) LICENSE doc/ examples/

all: $(TARGET) examples

$(TARGET): $(STAT_FILE)
	cd doc; make install

examples: $(STAT_FILE)
	mkdir -p examples
	cd examples_src; for dir in *; do if [ -d $$dir ]; then cd $$dir; make install; cd ..; fi; done
	cp examples_src/README examples/README.examples

show: $(TARGET)
	evince $(TARGET)

$(STAT_FILE):
	(cd ${@:.def=}; make install)

zip: $(ZIPFILES) clean
	rm -f $(ZIP_TARGET)
	rm -rf /tmp/rpg-module
	mkdir /tmp/rpg-module
	cp -r $(ZIPFILES) /tmp/rpg-module
	find /tmp/rpg-module -name Makefile -exec rm -f {} \;
	cd /tmp; zip -r $(ZIP_TARGET) rpg-module/

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut
	cd doc; make clean
	cd examples_src; for dir in *; do if [ -d $$dir ]; then cd $$dir; make clean; cd ..; fi; done

clobber: clean
	rm -f $(TARGET) $(STAT_FILE)
	rm -rf examples/*
