.DEFAULT_GOAL := help

# list of directory names
stack ?= $(shell find . -maxdepth 1 -mindepth 1 -type d -not -name ".*")
# list of paths to modules.json file in each directory
modules := $(patsubst %, %/.terraform/modules/modules.json, $(stack))
# list of .tf source files
sources := $(shell find . -type f -name \*.tf | grep -v .terraform)

help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean-cache:  ## clean all terraform caches
	for i in ${stack}; do ( echo "$${i}/.terraform" && rm -rf "$${i}/.terraform" ) ; done

init: $(modules)  ## fetch modules for all stacks
	$(info Init done)

# common task for modules.json files. Runs only when sources change
$(modules): $(sources)
	terraform -chdir=$(firstword $(subst /, ,$@)) get
