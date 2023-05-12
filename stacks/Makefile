.DEFAULT_GOAL := help

help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk '{ split($$0,a,/:.*##/); printf("%15s :%s\n",a[1],a[2]) }'

clean-cache:  ## clean all terraform caches
	for i in ${stack}; do ( echo "$${i}/.terraform" && rm -rf "$${i}/.terraform" ) ; done
