# Files not managed by latex-make
SVG_FILES =

SVG_PDFT_FILES =

DOT_CIRCO_FILES =

DOT_DOT_FILES =

DOT_NEATO_FILES =

DOT_PATCHWORK_FILES =

DOT_FILES = $(DOT_CIRCO_FILES) $(DOT_DOT_FILES) $(DOT_NEATO_FILES) $(DOT_PATCHWORK_FILES)

PDF_FILES = \
	$(SVG_FILES:.svg=.pdf) \
	$(SVG_PDFT_FILES:.svg=.pdf) \
	$(DOT_FILES:.dot=.pdf)

GEN_TEX_FILES = $(DOT_TEX_FILES:.dot=.tex)

PDFT_FILES = $(SVG_PDFT_FILES:.svg=.svgpdft)

## Default target first
all: main.pdf

# Clear out all suffixes
#.SUFFIXES:
# List only those we will actually use
#.SUFFIXES: .pdf .svg .dot .tex .svgpdft

## Conversion from SVG files
%.pdf : %.svg.pdf
	inkscape --without-gui --export-area-drawing --export-pdf=$@ $<

## Conversion from SVG files
%.svgpdft : %.svg
	inkscape --without-gui --export-area-drawing \
	--export-pdf=$(basename $<).pdf --export-latex $<
	mv $(basename $<).pdf_tex $(basename $<).svgpdft

## Conversion from DOT files
$(DOT_CIRCO_FILES:.dot=.pdf) : $(DOT_CIRCO_FILES)
	circo -T pdf -o $@ $(basename $@).dot
$(DOT_DOT_FILES:.dot=.pdf) : $(DOT_DOT_FILES)
	dot -T pdf -o $@ $(basename $@).dot
$(DOT_NEATO_FILES:.dot=.pdf) : $(DOT_NEATO_FILES)
	neato -T pdf -o $@ $(basename $@).dot
$(DOT_PATCHWORK_FILES:.dot=.pdf) : $(DOT_PATCHWORK_FILES)
	patchwork -T pdf -o $@ $(basename $@).dot

$(DOT_TEX_FILES:.dot=.tex) : $(DOT_TEX_FILES)
	dot2tex --figonly -tmath $(basename $@).dot > $@

# Latex-make stuff follows

FIGURES = $(PDF_FILES) $(PDFT_FILES) $(GEN_TEX_FILES)

LU_FLAVORS = PDF

# Some flags required e.g. by the minted package
PDFLATEX_OPTIONS += --shell-escape

# We require latex-make
include /usr/share/texmf/scripts/latex-make/LaTeX.mk

# Loop target, for automatic rebuilding when a dependency file is updated
loop:
	./ifchanged.py $(TD_main.pdf_INPUTS) $(FIGURES) 'make'

frontespizio:
	pdflatex $(PDFLATEX_OPTIONS) main-frn.tex
	pdflatex $(PDFLATEX_OPTIONS) main.tex

## Additional cleanups
clean::
	rm -f $(PDF_FILES) $(PDFT_FILES) main.pdf main-frn.pdf
