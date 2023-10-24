.DEFAULT_GOAL := help
.ONESHELL:
SHELL := /bin/bash

env ?= env_not_set

# text file with generated change plan
text_plan_name := terraform-plan.txt
# marker file for init phase
init_mark := $(env)/.makefile_init
# use global cache (change to true)
# see https://github.com/gruntwork-io/terragrunt/issues/561#issuecomment-1032170292
use_global_cache ?= false

workdir := ./$(env)
tg_params :=
plan_suffix := $(env)

# when stack parameter is used
ifdef stack
	workdir := $(workdir)/$(stack)
	plan_suffix := $(plan_suffix)-$(stack)
# should dependencies be included?
	ifdef deps
		tg_params := --terragrunt-include-external-dependencies
	else
		tg_params := --terragrunt-ignore-external-dependencies
	endif
endif

# name for the plan binary file
plan_name := terraform-plan-$(plan_suffix).tfplan

sources := $(shell find ../ -name \*.tf -o -name \*.hcl -o -name \*.yaml | grep -v "\.terragrunt-cache" | grep -v "\.terraform" | grep -v "/init/" | grep -v .skel)

# list of used terraform modules. `modules.json` gets generated during `init` stage in `stacks`
modules := $(shell find ../stacks/*/.terraform -name modules.json)

help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean-cache:  ## remove cached files (including providers)
	find . -type d -name ".terragrunt-cache" -print -prune -exec rm -rf {} \;

clean:  ## clean caches
	rm -f $(text_plan_name) $(init_mark)

init: $(init_mark)  ## run init on all stacks in the environment
	$(info Terraform init done.)

pwd := $(shell pwd)
terragrunt_cache := $(pwd)/.terragrunt-cache
plugin_cache := $(terragrunt_cache)/.plugins
ifeq ($(use_global_cache), true)
	tg_caches := TERRAGRUNT_DOWNLOAD=$(terragrunt_cache) TF_PLUGIN_CACHE_DIR=$(plugin_cache)
endif

GRUNT_PLAN := $(tg_caches) terragrunt run-all plan --terragrunt-log-level info --terragrunt-working-dir "$(workdir)" $(tg_params) -lock=false -out=${plan_name}

plan: $(sources) $(plugin_cache)  ## perform plan on all stacks
ifeq ($(CI), true)
	set -o pipefail && \
	${GRUNT_PLAN} -input=false -no-color -compact-warnings --terragrunt-non-interactive 2>&1 \
	| sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' \
	| tee ${text_plan_name}
else
	${GRUNT_PLAN} -input=false
endif

GRUNT_APPLY := $(tg_caches) terragrunt run-all apply --terragrunt-log-level info --terragrunt-working-dir "$(workdir)" $(tg_params) -input=false

apply: $(plugin_cache) ## apply changes on all stacks
ifeq ($(CI), true)
	${GRUNT_APPLY} --terragrunt-non-interactive -auto-approve ${plan_name}
else
	${GRUNT_APPLY} ${plan_name}
endif

$(plugin_cache):
	mkdir -p $(plugin_cache)

# run init only when modules changed in stacks (after running `make get` there)
$(init_mark): $(modules)
	terragrunt run-all init --terragrunt-working-dir "$(workdir)" $(tg_params) && touch $@

.PHONY: secrets
secrets: $(env)/secrets.yaml  ## edit secrets
	sops ./$(env)/secrets.yaml

$(env)/secrets.yaml:
	echo 'foo: bar' > $@
	sops --encrypt --config .sops.yaml --in-place $@
