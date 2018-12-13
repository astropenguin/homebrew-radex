.PHONY: all
all:
	@echo Makefile for RADEX build.
	@echo - - - - - - - - - - - - -
	@echo $$ make build: build RADEX binaries
	@echo $$ make install: build and install binaries
	@echo $$ make uninstall: remove and unlink binaries

# name of radex binaries
RADEX_1 := radex-sphere
RADEX_2 := radex-lvg
RADEX_3 := radex-slab

# config for build and installation
URL := https://personal.sron.nl/~vdtak/radex
DIST := radex_public.tar.gz
RADEX_SRC := radex-src
RADEX_DIR := $(HOME)/.radex
BIN_DIR := /usr/local/bin
MOLDAT_ORG := /Users/floris/Radex/moldat/

# just internal use
PARAM_1 := .*parameter.*method.*1.*$$
PARAM_2 := .*parameter.*method.*2.*$$
PARAM_3 := .*parameter.*method.*3.*$$
PARAM_ALL := .*parameter.*method.*$$

.PHONY: build
build: $(RADEX_1) $(RADEX_2) $(RADEX_3) clean

.PHONY: install
install: build
	mkdir -p $(RADEX_DIR)
	mv $(RADEX_1) $(RADEX_DIR)
	mv $(RADEX_2) $(RADEX_DIR)
	mv $(RADEX_3) $(RADEX_DIR)
	ln -sf $(RADEX_DIR)/$(RADEX_1) $(BIN_DIR)
	ln -sf $(RADEX_DIR)/$(RADEX_2) $(BIN_DIR)
	ln -sf $(RADEX_DIR)/$(RADEX_3) $(BIN_DIR)

.PHONY: uninstall
uninstall:
	rm -rf $(RADEX_DIR)
	rm -rf $(BIN_DIR)/$(RADEX_1)
	rm -rf $(BIN_DIR)/$(RADEX_2)
	rm -rf $(BIN_DIR)/$(RADEX_3)

.PHONY: clean
clean:
	rm -rf $(RADEX_SRC)
	rm -rf $(DIST)

$(RADEX_SRC):
	mkdir $(RADEX_SRC)
	curl -fsO $(URL)/$(DIST)
	@tar xf $(DIST) -C $(RADEX_SRC) --strip 2 '*/src'
	@sed -i '' -e 's@$(MOLDAT_ORG)@${MOLDAT}@g' $(RADEX_SRC)/radex.inc

$(RADEX_1): $(RADEX_SRC)
	@echo build $(RADEX_1)
	@sed -i '' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i '' -e 's@^c*\($(PARAM_1)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_1) BINDIR=../ >/dev/null 2>&1

$(RADEX_2): $(RADEX_SRC)
	@echo build $(RADEX_2)
	@sed -i '' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i '' -e 's@^c*\($(PARAM_2)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_2) BINDIR=../ >/dev/null 2>&1

$(RADEX_3): $(RADEX_SRC)
	@echo build $(RADEX_3)
	@sed -i '' -e 's@^c*\($(PARAM_ALL)\)@c\1@g' $(RADEX_SRC)/radex.inc
	@sed -i '' -e 's@^c*\($(PARAM_3)\)@\1@g' $(RADEX_SRC)/radex.inc
	@make -C $(RADEX_SRC) EXEC=$(RADEX_3) BINDIR=../ >/dev/null 2>&1
