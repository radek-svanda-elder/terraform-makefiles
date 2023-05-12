# Makefiles for our terraform/terragrunt setup

Set of Makefiles to further simplify use of [terragrunt-starter](https://github.com/elderstudios/terragrunt-starter) based infra projects.

## Targets

- `help` - gives you help generated from Makefile source
- `init` - downloads terraform modules and providers. Runs only after sources change
- `clean` - cleans built artifacts (plain text plan, etc.)
- `clean-cache` - clean all downloaded modules and providers
- `plan` - make terraform plan
- `apply` - apply changes created by `plan` stage

## Parameters

- `env` - environment to run in. Name of one of the directories under `terraform/`
- `stack` - specify single stack to execute
- `deps` - when running on single stack, should also dependencies be included?

## Usage

### Create plan for UAT environment

```
make env=uat init plan
```

### Create plan and apply it for database stack in dev environment

```
make env=dev stack=database init plan apply
```

To also include changes for dependencies, eg. vpc stack

```
make env=dev stack=database init plan apply deps=true
```

## Installation to your project

Add repository to your remotes

```
git remote add makefiles git@github.com:radek-svanda-elder/terraform-makefiles.git
```

Fetch changes

```
git fetch makefiles
```

Copy files to your branch

```
git checkout makefiles/main Makefile
git checkout makefiles/main stacks/Makefile
git checkout makefiles/main terraform/Makefile
```
