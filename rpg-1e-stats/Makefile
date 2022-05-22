TARGET=test_all.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

$(TARGET): rpg-1e-stats.def

%.pdf: %.tex
	pdflatex $<

%.def: %.csv convert
	./convert $<

rpg-1e-stats.csv: mm.csv ff.csv mm2.csv
	$(RM) $@
	tail -n +3 mm.csv >> $@
	tail -n +3 ff.csv >> $@
	tail -n +3 mm2.csv >> $@

install: rpg-1e-stats.def
	cp rpg-1e-stats.def ..

clean:
	$(RM) *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut
	$(RM) all-monsters.csv

clobber: clean
	$(RM) $(TARGET)
