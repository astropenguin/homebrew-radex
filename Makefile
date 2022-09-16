# parameters
DATADIR :=
LOGFILE := ./radex.log
MINITER := 10
MAXITER := 9999

# constants
RADEX_URL := https://personal.sron.nl/~vdtak/radex/radex_public.tar.gz
RADEX_SRC_1 := src-uni
RADEX_SRC_2 := src-lvg
RADEX_SRC_3 := src-slab
RADEX_1 := radex-uni
RADEX_2 := radex-lvg
RADEX_3 := radex-slab

# targets
build: $(RADEX_1) $(RADEX_2) $(RADEX_3)

clean:
	rm -rf $(RADEX_SRC_1) $(RADEX_1)
	rm -rf $(RADEX_SRC_2) $(RADEX_2)
	rm -rf $(RADEX_SRC_3) $(RADEX_3)

$(RADEX_1): $(RADEX_SRC_1)
	sed -r -i.bak "s|^c(.*method *= *1)|\1|g" $</radex.inc
	make -j1 -C $< BINDIR=../ EXEC=$@

$(RADEX_2): $(RADEX_SRC_2)
	sed -r -i.bak "s|^c(.*method *= *2)|\1|g" $</radex.inc
	make -j1 -C $< BINDIR=../ EXEC=$@

$(RADEX_3): $(RADEX_SRC_3)
	sed -r -i.bak "s|^c(.*method *= *3)|\1|g" $</radex.inc
	make -j1 -C $< BINDIR=../ EXEC=$@

$(RADEX_SRC_1) $(RADEX_SRC_2) $(RADEX_SRC_3):
	mkdir -p $@
	curl -s -o - $(RADEX_URL) | tar xzf - -C $@ --strip-components 2
	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $@/radex.inc
	sed -r -i.bak "s|(radat *= *)'.*'|\1'${DATADIR}'|g" $@/radex.inc
	sed -r -i.bak "s|(logfile *= *)'.*'|\1'${LOGFILE}'|g" $@/radex.inc
	sed -r -i.bak "s|(miniter *= *)[0-9]*|\1${MINITER}|g" $@/radex.inc
	sed -r -i.bak "s|(maxiter *= *)[0-9]*|\1${MAXITER}|g" $@/radex.inc
