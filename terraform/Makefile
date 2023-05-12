.DEFAULT_GOAL := help
.ONESHELL:
SHELL := /bin/bash

env ?= env_not_set

text_plan_name := terraform-plan.txt
init_mark := $(env)/.makefile_init

help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean-cache:  ## remove cached files (including providers)
	find $(env) -type d -name ".terragrunt-cache" -print -prune -exec rm -rf {} \;

clean:  ## clean caches
	rm -f $(text_plan_name) $(init_mark)
