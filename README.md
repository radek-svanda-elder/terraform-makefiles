# Makefiles for our terraform/terragrunt setup

Set of Makefiles to further simplify use of [terragrunt-starter](https://github.com/elderstudios/terragrunt-starter) based infra projects.

## Usage

### Get help

When not sure run

```
make help
```

### Clean up

To clean built artifacts (plans, etc.) run

```
make clean
```

To clean up all cached artifacts, including terraform providers, run

```
make clean-cache
```

### Init terraform modules/providers

To download used providers and make sure you have everything for `plan`/`apply` stages

```
make init
```

It runs `terraform get` in each directory under `stacks/` and `terragrunt run-all init` in `terraform/` dir, but only when there were changes in .tf files

