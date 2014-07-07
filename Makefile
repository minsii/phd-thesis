#
# $Id: Makefile 279 2008-01-27 16:19:38Z balaji $
#
# Copyright (C) 2006-2007, University of Chicago. All rights reserved.
#

HEADER=thesis
PICS=figures
BIB=bib
TEX=text

TARGETS: $(HEADER).pdf
.PHONY: all clean

tex_files = $(shell find $(TEX) -name '*.tex' -print)
bib_files = $(shell find $(BIB) -name '*.bib' -print)
pic_files = $(shell find $(PICS) \
		\( -name '*.eps' -print \) -or \( -name '*.epsi' -print \) \
		-or \( -name '*.ps' -print \) -or \( -name '*.png' -print \) \
		-or \( -name '*.fig' -print \) -or \( -name '*.pdf' -print \) \
	)

thesis.pdf: thesis.dvi
	dvipdfmx thesis
thesis.dvi: $(HEADER).tex $(tex_files) $(bib_files) $(pic_files)
	platex thesis
	# bibtex thesis
	platex thesis
	platex thesis

clean:
	@if test "`which rubber`" != "" ; then \
		rubber -d --clean $(HEADER) ; \
	else \
		find . \( -name '*.blg' -print \) -or \( -name '*.aux' -print \) -or \
			\( -name '*.bbl' -print \) -or \( -name '*~' -print \) -or \
			\( -name '*.lof' -print \) -or \( -name '*.lot' -print \) -or \
			\( -name '*.toc' -print \) | xargs rm -f; \
		rm -f $(HEADER).dvi $(HEADER).log $(HEADER).ps $(HEADER).pdf $(HEADER).out \
			_region_* TAGS ; \
	fi
