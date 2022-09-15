# parameters
DATADIR :=
LOGFILE := ./radex.log
MINITER := 10
MAXITER := 9999

# constants
RADEX_URL := https://personal.sron.nl/~vdtak/radex/radex_public.tar.gz
RADEX_SRC := radex
RADEX_1 := radex-uni
RADEX_2 := radex-lvg
RADEX_3 := radex-slab

# targets
build: $(RADEX_1) $(RADEX_2) $(RADEX_3)

clean:
	rm -rf $(RADEX_SRC) $(RADEX_1) $(RADEX_2) $(RADEX_3)

$(RADEX_SRC):
	mkdir -p $(RADEX_SRC)
	curl -s -o - $(RADEX_URL) | tar xzf - -C $(RADEX_SRC) --strip-components 2
	sed -r -i.bak "s|(radat *= *)'(.*)'|\1'${DATADIR}'|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|(logfile *= *)'(.*)'|\1'${LOGFILE}'|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|(miniter *= *)([0-9]*)|\1${MINITER}|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|(maxiter *= *)([0-9]*)|\1${MAXITER}|g" $(RADEX_SRC)/radex.inc

.NOTPARALLEL:
$(RADEX_1): $(RADEX_SRC)
	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|^c(.*method *= *1)|\1|g" $(RADEX_SRC)/radex.inc
	make -C $(RADEX_SRC) EXEC=$(RADEX_1) BINDIR=../

.NOTPARALLEL:
$(RADEX_2): $(RADEX_SRC)
	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|^c(.*method *= *2)|\1|g" $(RADEX_SRC)/radex.inc
	make -C $(RADEX_SRC) EXEC=$(RADEX_2) BINDIR=../

.NOTPARALLEL:
$(RADEX_3): $(RADEX_SRC)
	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $(RADEX_SRC)/radex.inc
	sed -r -i.bak "s|^c(.*method *= *3)|\1|g" $(RADEX_SRC)/radex.inc
	make -C $(RADEX_SRC) EXEC=$(RADEX_3) BINDIR=../
