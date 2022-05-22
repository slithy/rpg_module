#TARGET=test_gnoll.pdf
TARGET=test_all.pdf

all: $(TARGET)

show: $(TARGET)
	evince $(TARGET)

$(TARGET): rpg-1e-stats.def

%.pdf: %.tex
	pdflatex $<

all-monsters.csv: mm.csv ff.csv mm2.csv
	$(RM) all-monsters.csv
	touch all-monsters.csv
	tail -n +3 mm.csv >> all-monsters.csv
	tail -n +3 ff.csv >> all-monsters.csv
	tail -n +3 mm2.csv >> all-monsters.csv

rpg-1e-stats.def: all-monsters.csv
	./convert all-monsters.csv

install: rpg-1e-stats.def
	cp rpg-1e-stats.def ..

clean:
	$(RM) *.aux *.bbl *.blg *.log *.dvi *.bak *.lof *.log *.lol *.lot *.out *.toc *.cut
	$(RM) all-monsters.csv

clobber: clean
	$(RM) $(TARGET)

.PHONY: convert
