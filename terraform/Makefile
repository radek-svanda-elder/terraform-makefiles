.DEFAULT_GOAL := help
.ONESHELL:
SHELL := /bin/bash

env ?= env_not_set

# text file with generated change plan
text_plan_name := terraform-plan.txt
# marker file for init phase
init_mark := $(env)/.makefile_init

workdir := ./$(env)
tg_params :=

# list of used terraform modules. `modules.json` gets generated during `init` stage in `stacks`
modules := $(shell find ../stacks/*/.terraform -name modules.json)

help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean-cache:  ## remove cached files (including providers)
	find $(env) -type d -name ".terragrunt-cache" -print -prune -exec rm -rf {} \;

clean:  ## clean caches
	rm -f $(text_plan_name) $(init_mark)

init: $(init_mark)  ## run init on all stacks in the environment
	$(info Terraform init done.)

# run init only when modules changed in stacks (after running `make get` there)
$(init_mark): $(modules)
	terragrunt run-all init --terragrunt-working-dir "$(workdir)" $(tg_params) && touch $@
