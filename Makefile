# options
RADEX_DATADIR :=
RADEX_LOGFILE := ./radex.log
RADEX_MINITER := 10
RADEX_MAXITER := 9999

# constants
RADEX_CMD := radex
RADEX_INC := radex.inc
RADEX_SRC := radex_public
RADEX_URL := https://personal.sron.nl/~vdtak/radex

# subcommands
build: $(RADEX_CMD)-uni $(RADEX_CMD)-lvg $(RADEX_CMD)-slab

clean:
	rm -rf $(RADEX_SRC)* $(RADEX_CMD)-*

# targets
$(RADEX_CMD)-uni: $(RADEX_CMD)-1
	cp $(<) $(@)

$(RADEX_CMD)-lvg: $(RADEX_CMD)-2
	cp $(<) $(@)

$(RADEX_CMD)-slab: $(RADEX_CMD)-3
	cp $(<) $(@)

$(RADEX_CMD)-%: $(RADEX_SRC)-%.tar.gz
	tar xf $(<)
	make -j1 -C $(<:%.tar.gz=%)/src BINDIR=../../ EXEC=$(@)

$(RADEX_SRC)-%.tar.gz: $(RADEX_SRC).tar.gz
	mkdir -p $(*)
	tar xzf $(<) -C $(*) --strip-components 1

	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $(*)/src/$(RADEX_INC)
	sed -r -i.bak "s|^c(.*method *= *$(*))|\1|g" $(*)/src/$(RADEX_INC)
	sed -r -i.bak "s|(radat *= *)'.*'|\1'${RADEX_DATADIR}'|g" $(*)/src/$(RADEX_INC)
	sed -r -i.bak "s|(logfile *= *)'.*'|\1'${RADEX_LOGFILE}'|g" $(*)/src/$(RADEX_INC)
	sed -r -i.bak "s|(miniter *= *)[0-9]*|\1${RADEX_MINITER}|g" $(*)/src/$(RADEX_INC)
	sed -r -i.bak "s|(maxiter *= *)[0-9]*|\1${RADEX_MAXITER}|g" $(*)/src/$(RADEX_INC)

	mv $(*) $(@:%.tar.gz=%)
	tar czf $(@) $(@:%.tar.gz=%)
	rm -rf $(*)

$(RADEX_SRC).tar.gz:
	curl -sO $(RADEX_URL)/$(@)
