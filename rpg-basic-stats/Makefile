install: rpg-basic-stats.def
	cp $< ..

rpg-basic-stats.def: publish rpg-basic-stats.csv
	./publish rpg-basic-stats.csv > $@
