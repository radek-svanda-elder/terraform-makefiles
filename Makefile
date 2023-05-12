.DEFAULT_GOAL := help

# do we run on a CI server?
CI ?= false

# default environment
env ?= prod

# Self documenting help section:
help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean:  ## clean all pre-built artifacts
	cd terraform && $(MAKE) clean env=$(env)

clean-cache:  ## clean all caches
	cd terraform && $(MAKE) clean-cache env=$(env)
	cd stacks && $(MAKE) clean-cache

init:  ## init terraform modules
	cd terraform && $(MAKE) init env=$(env)
	cd stacks && $(MAKE) init

plan:  ## perform terraform plan task and catch result to a file
	cd terraform && $(MAKE) plan env=$(env) stack=$(stack)
