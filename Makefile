.PHONY: all
all:
	@echo Makefile for RADEX build.
	@echo - - - - - - - - - - - - -
	@echo $$ make build: build RADEX binaries
	@echo $$ make install: build and install binaries
	@echo $$ make uninstall: remove and unlink binaries
	@echo $$ make clean: remove intermediate files

# name of radex binaries
RADEX_1 := radex-uni
RADEX_2 := radex-lvg
RADEX_3 := radex-slab

# config for build and installation
URL := https://personal.sron.nl/~vdtak/radex
DIST := radex_public.tar.gz
RADEX_SRC := radex-src
HOME_BINDIR := $(HOME)/.local/bin
USR_BINDIR := /usr/local/bin

# config for custom paths
DATADIR_ORG := /Users/floris/Radex/moldat/
DATADIR :=
LOGFILE_ORG := ./radex.log
LOGFILE := ./radex.log

# just internal use
MAKEFLAGS := -j 1
PARAM_1 := .*parameter.*method.*1.*$$
PARAM_2 := .*parameter.*method.*2.*$$
PARAM_3 := .*parameter.*method.*3.*$$
PARAM_ALL := .*parameter.*method.*$$

.PHONY: build
build: $(RADEX_1) $(RADEX_2) $(RADEX_3)

.PHONY: install
install: build
	mkdir -p $(HOME_BINDIR)
	mv $(RADEX_1) $(HOME_BINDIR)
	mv $(RADEX_2) $(HOME_BINDIR)
	mv $(RADEX_3) $(HOME_BINDIR)
	ln -sf $(HOME_BINDIR)/$(RADEX_1) $(USR_BINDIR)
	ln -sf $(HOME_BINDIR)/$(RADEX_2) $(USR_BINDIR)
	ln -sf $(HOME_BINDIR)/$(RADEX_3) $(USR_BINDIR)

.PHONY: uninstall
uninstall:
	rm -rf $(USR_BINDIR)/$(RADEX_1)
	rm -rf $(USR_BINDIR)/$(RADEX_2)
	rm -rf $(USR_BINDIR)/$(RADEX_3)

.PHONY: clean
clean:
	rm -rf $(RADEX_SRC)
	rm -rf $(DIST)

$(RADEX_SRC):
	mkdir $(RADEX_SRC)
	curl -fsO $(URL)/$(DIST)
	@tar xf $(DIST) -C $(RADEX_SRC) --strip 2 '*/src'
	@sed -i'.bak' -e 's@$(DATADIR_ORG)@${DATADIR}@g' $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e 's@$(LOGFILE_ORG)@${LOGFILE}@g' $(RADEX_SRC)/radex.inc

$(RADEX_1): $(RADEX_SRC)
	@echo build $(RADEX_1)
	@sed -i'.bak' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e 's@^c*\($(PARAM_1)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_1) BINDIR=../ >/dev/null 2>&1

$(RADEX_2): $(RADEX_SRC)
	@echo build $(RADEX_2)
	@sed -i'.bak' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e 's@^c*\($(PARAM_2)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_2) BINDIR=../ >/dev/null 2>&1

$(RADEX_3): $(RADEX_SRC)
	@echo build $(RADEX_3)
	@sed -i'.bak' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e 's@^c*\($(PARAM_3)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_3) BINDIR=../ >/dev/null 2>&1
