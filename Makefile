# mahai, 20180416

define usageStr =
Usage:	make <target>

This is the make-method of this repository.
with <target> one of:
    (neutral targets)
    help			Print this help.
    info			Print info about this repository.
    (destructive targets)
    clean		Remove all intermediary files from this repo.
    cleanall		Remove all intermediary and output files from this repo.
      (productive targets)
      p13n		Create a config file for personalization.
      conf		Create a personalized configuration.
      init		Create an emacs file.
        (export targets - manipulating context)
        link		Link the repository with the user environment.
        unlink		Unlink the repository from the user environment.
        run		Runs \`make export\' recursively. 
endef
export usageStr

projectName := mahai-elisp
confName := $(projectName)

.PHONY: usage help conf userconf clean cleanall

usage: 
	@echo "$$usageStr"
	false

help:
	@echo "$$usageStr"

info:
	less README.md

clean:
	-latexmk -c
	-rm -i *.conf

cleanall: clean
	-latexmk -C
	-rm -i *.el

p13n: $(confName).conf

%.conf:
	@[ ! -e "$@" ] && echo "# mahai $(shell /bin/date "+%Y%m%d-%H%M%S")" > "$@"

#confCmd := conf2el.sh
#conf: p13n
#	@[ -f $(confCmd) ] && $(confCmd) $(confName) > $(confName).el
#
#initCmd := createInitFile
#initFile := emacs.el
#init: conf
#	@[ -f $(initCmd) ] && $(initCmd) $(confName).el > $(initFile)
#
#symlinkCmds := $(shell readsymlinkCmds $(confName).conf)
#link:
#	$(symlinkCmds) > .links
#
#unlink:
#	for l in .links;do rm -i $$l;done
#
#
#run:
#	fail
#	cd subdir && make export
