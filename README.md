# Makefiles for our terraform/terragrunt setup

Set of Makefiles to further simplify use of [terragrunt-starter](https://github.com/elderstudios/terragrunt-starter) based infra projects.

## Targets

- `help` - gives you help generated from Makefile source
- `init` - downloads terraform modules and providers. Runs only after sources change
- `clean` - cleans built artifacts (plain text plan, etc.)
- `clean-cache` - clean all downloaded modules and providers
- `plan` - make terraform plan

## Parameters

- `env` - environment to run in. Name of one of the directories under `terraform/`

## Usage

### Create plan for UAT environment

```
make env=uat init plan
```
