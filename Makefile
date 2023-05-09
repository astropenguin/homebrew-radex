# parameters
DATADIR :=
LOGFILE := ./radex.log
MINITER := 10
MAXITER := 9999

# constants
RADEX_CMD := radex
RADEX_INC := src/radex.inc
RADEX_SRC := radex_public
RADEX_URL := https://personal.sron.nl/~vdtak/radex

# subcommands
build: $(RADEX_CMD)-uni $(RADEX_CMD)-lvg $(RADEX_CMD)-slab

clean:
	rm -rf $(RADEX_SRC)*

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
	tar xf $(<) --transform "s/Radex/$(@:%.tar.gz=%)/g"

	sed -r -i.bak "s|^c*(.*method *= *[1-3])|c\1|g" $(@:%.tar.gz=%)/$(RADEX_INC)
	sed -r -i.bak "s|^c(.*method *= *$(*))|\1|g" $(@:%.tar.gz=%)/$(RADEX_INC)
	sed -r -i.bak "s|(radat *= *)'.*'|\1'${DATADIR}'|g" $(@:%.tar.gz=%)/$(RADEX_INC)
	sed -r -i.bak "s|(logfile *= *)'.*'|\1'${LOGFILE}'|g" $(@:%.tar.gz=%)/$(RADEX_INC)
	sed -r -i.bak "s|(miniter *= *)[0-9]*|\1${MINITER}|g" $(@:%.tar.gz=%)/$(RADEX_INC)
	sed -r -i.bak "s|(maxiter *= *)[0-9]*|\1${MAXITER}|g" $(@:%.tar.gz=%)/$(RADEX_INC)

	tar czf $(@) $(@:%.tar.gz=%) --remove-files

$(RADEX_SRC).tar.gz:
	curl -sO $(RADEX_URL)/$(@)
