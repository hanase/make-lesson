COUNT_SCRIPT=wordcount.py
PLOT_SCRIPT=plotcount.py
TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))
PNG_FILES=$(patsubst books/%.txt, %.png, $(TXT_FILES))

analysis.zip : $(DAT_FILES) $(PNG_FILES) $(COUNT_SCRIPT) $(PLOT_SCRIPT)
	zip $@ $^

.PHONY : dats
dats : $(DAT_FILES)
#dats : isles.dat abyss.dat last.dat

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)
	@echo DAT_FILES: $(DAT_FILES)

# count words
%.dat : books/%.txt $(COUNT_SCRIPT)       
	python $(COUNT_SCRIPT) $< $*.dat  
 
%.png : %.dat $(PLOT_SCRIPT)
	python $(PLOT_SCRIPT) $< $@

#isles.dat : books/isles.txt wordcount.py
#	python wordcount.py $< $@
##	python wordcount.py books/isles.txt isles.dat

#abyss.dat : books/abyss.txt wordcount.py
#	python wordcount.py $< $@

#last.dat : books/last.txt wordcount.py
#	python wordcount.py $< $@


.PHONY : clean
clean : 
	rm -f $(DAT_FILES) $(PNG_FILES)
	rm -f analysis.zip

# $@ is target; $^ mean all dependencies
# use %. only in target-dependencies line 
# use $* only in action line. %. and $* mean the same thing
# $< means the first dependency 
# for including script:
# include "script.var"
# @ means don't print out the command itself