## Make

This repository's `Makefile` is intentionally tiny — it inherits its targets from the [aws-code-habits](https://github.com/awslabs/aws-code-habits) submodule mounted under `habits/`:

```makefile
export WORKSPACE = $(shell pwd)
export HABITS    = $(WORKSPACE)/habits

include $(WORKSPACE)/tools.env
include $(HABITS)/lib/make/Makefile
include $(HABITS)/lib/make/*/Makefile
```

That means **the submodule must be initialized before any `make` target will work**. If you cloned without `--recurse-submodules`, run:

```bash
git submodule update --init --recursive
```

To list every available target after init, run:

```bash
make help
```

### Targets used by this repository

The targets below are the ones this repository's CI (`.github/workflows/test.yml` and `.github/workflows/hygiene.yml`) actually exercises. They are the demonstrably-working surface area — anything else `make help` reports comes from `aws-code-habits` and may or may not be relevant here.

#### Bootstrapping a host (used by `test.yml`)

| Target | What it does |
|---|---|
| `ansible/install` | Install Ansible on the host (used to drive the rest of the install playbooks). |
| `ansible/playbooks/ubuntu/install` | Run the bundled Ubuntu setup playbook (common packages, build deps). |

#### Cloud CLIs

| Target | What it does |
|---|---|
| `aws/cli/install/v2` | Install AWS CLI v2. |
| `aws/cli/autocomplete` | Wire up shell autocompletion for the AWS CLI. |

#### Terraform & ecosystem

| Target | What it does |
|---|---|
| `terraform/install` | Install the Terraform CLI. |
| `terraform-docs/install` | Install `terraform-docs` (version pinned via `TERRAFORM_DOCS_VERSION` in `tools.env`). |
| `tflint/install` | Install `tflint` plus the AWS ruleset (version pinned via `TFLINT_AWS_RULESET_VERSION`). |
| `tfsec/install` | Install `tfsec` (version pinned via `TFSEC_VERSION`). |
| `terrascan/install` | Install `terrascan` (version pinned via `TERRASCAN_VERSION`). |
| `checkov/install` | Install `checkov` (Python-based static analysis for IaC). |
| `tfswitch/install` | Install `tfswitch` for switching Terraform versions. |

> **Note**: `tfswitch/install` is scheduled to be replaced by [`tenv`](https://github.com/tofuutils/tenv) (see issue #12). New work should not depend on `tfswitch` long-term.

#### Documentation

| Target | What it does |
|---|---|
| `doc/build` | Regenerate `doc/`-rooted documentation (used by the `doc-hygiene` CI job, which fails the build if the result differs from what was committed). |

### Other targets

`aws-code-habits` ships many additional targets covering pre-commit, Python, Node.js, Go, Docker hygiene, and gitignore management. They are not exercised by this repository's CI, so they are not documented here. Run `make help` after the submodule is initialized for the full list, and treat anything outside the table above as best-effort.

### Updating this document

This file is hand-maintained. If you add a new target invocation to `.github/workflows/`, please add a row to the appropriate table above.
