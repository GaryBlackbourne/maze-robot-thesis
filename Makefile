DOCUMENT=thesis
READER=evince

AUX_EXT = aux bbl blg log out thm toc
AUX_FILES = $(foreach EXT, $(AUX_EXT), $(DOCUMENT).$(EXT))

all: clean doc read

read:
	$(READER) output/$(DOCUMENT).pdf &> /dev/null &

doc:
	echo "start build"
	xelatex $(MODE) $(DOCUMENT)
	bibtex $(DOCUMENT)
	xelatex $(MODE) $(DOCUMENT)
	xelatex $(MODE) $(DOCUMENT)
	mkdir -p ./output/aux
	mv $(DOCUMENT).pdf output/$(DOCUMENT).pdf
	mv $(AUX_FILES) output/aux/

clean:
	echo "Cleaning temporary files..."
	@for d in . include text text/chapters; do \
		pushd $$d >> /dev/null; \
		rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg; \
		popd >> /dev/null; \
	done
	@rm -rf output
	@echo "done!"
.PHONY: clean
