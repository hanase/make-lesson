analysis.zip : *.dat wordcount.py
	zip $@ $^
#	zip analysis.zip isles.dat abyss.dat last.dat wordcount.py

.PHONY : dats
dats : isles.dat abyss.dat last.dat

# count words
isles.dat : books/isles.txt wordcount.py
	python wordcount.py $< $@
#	python wordcount.py books/isles.txt isles.dat

abyss.dat : books/abyss.txt wordcount.py
	python wordcount.py $< $@

last.dat : books/last.txt wordcount.py
	python wordcount.py $< $@


.PHONY : clean
clean : 
	rm -f *.dat 
	rm -f *.zip
