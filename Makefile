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

# config for custom values
DATADIR :=
LOGFILE := ./radex.log
MINITER := 10
MAXITER := 9999

# config for build and installation
URL := https://personal.sron.nl/~vdtak/radex
DIST := radex_public.tar.gz
RADEX_SRC := radex-src
HOME_BINDIR := $(HOME)/.local/bin
USR_BINDIR := /usr/local/bin
MAKEFLAGS := -j 1

# targets
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
	@tar xf $(DIST) -C $(RADEX_SRC) --strip 2 'Radex/src'
	@sed -i'.bak' -e "s@\(radat *= *\)'\(.*\)'@\1'${DATADIR}'@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@\(logfile *= *\)'\(.*\)'@\1'${LOGFILE}'@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@\(miniter *= *\)\([0-9]*\)@\1${MINITER}@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@\(maxiter *= *\)\([0-9]*\)@\1${MAXITER}@g" $(RADEX_SRC)/radex.inc

$(RADEX_1): $(RADEX_SRC)
	@echo build $(RADEX_1)
	@sed -i'.bak' -e "s@^c*\(.*method *= *[0-9].*\)@c\1@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@^c\(.*method *= *1.*\)@\1@g" $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_1) BINDIR=../ >/dev/null 2>&1

$(RADEX_2): $(RADEX_SRC)
	@echo build $(RADEX_2)
	@sed -i'.bak' -e "s@^c*\(.*method *= *[0-9].*\)@c\1@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@^c\(.*method *= *2.*\)@\1@g" $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_2) BINDIR=../ >/dev/null 2>&1

$(RADEX_3): $(RADEX_SRC)
	@echo build $(RADEX_3)
	@sed -i'.bak' -e "s@^c*\(.*method *= *[0-9].*\)@c\1@g" $(RADEX_SRC)/radex.inc
	@sed -i'.bak' -e "s@^c\(.*method *= *3.*\)@\1@g" $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_3) BINDIR=../ >/dev/null 2>&1
