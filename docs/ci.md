# Continuous Integration

CI is split into three workflows so each concern gets its own status check and
README badge. All of them run automatically on every push and pull request to
`main` and `dev`, and can be triggered manually from the Actions tab
(`workflow_dispatch`).

## Workflows

| Workflow | File | What it runs |
| --- | --- | --- |
| CI | [`ci.yml`](../.github/workflows/ci.yml) | `pre-commit run --all-files` - the same hooks you run locally (ruff, gitleaks, hadolint, and more). |
| Ruff Linting and Formatting | [`ruff.yml`](../.github/workflows/ruff.yml) | `ruff check .` and `ruff format --check .` |
| Pytest Unit-tests | [`pytest.yml`](../.github/workflows/pytest.yml) | `pytest` over the `tests/` directory. |

Each workflow performs the same setup steps before its checks:

1. **Checkout** the repository.
2. **Install uv** via `astral-sh/setup-uv`.
3. **Install Python** with `uv python install` (version from `.python-version`).
4. **Sync dependencies** with `uv sync --all-extras --dev` so the environment
   matches `uv.lock` exactly.

If any step fails, the workflow fails and the pull request is blocked.

## Status Badges

The README shows one badge per workflow, generated from the workflow file name:

```markdown
[![Ruff Linting and Formatting](https://github.com/<OWNER>/<REPO>/actions/workflows/ruff.yml/badge.svg?branch=main)](https://github.com/<OWNER>/<REPO>/actions/workflows/ruff.yml)
```

After generating a repository from this template, update `<OWNER>/<REPO>` in
the README badge URLs. Note that GitHub does not serve workflow badges for
private repositories to unauthenticated viewers, so badges may show
"no status" until the repository is public or internal.

## Running CI Locally

Before pushing, run the same checks locally with the helper script:

```bash
./scripts/ci.sh
```

This mirrors the CI pipelines (pre-commit, ruff, and pytest), so you can catch
failures before they reach the remote. See [`scripts/ci.sh`](../scripts/ci.sh).

## Other Workflows

- **Sync Labels** (`labels.yml`) - applies `.github/labels.yml` to the repo's
  labels whenever that file changes.
- **Bootstrap Template** (`bootstrap-template.yml`) - runs once in repos
  generated from this template to seed labels and open the first issue, then
  removes itself.

## Extending CI

To add a stage (for example a build or deploy), add a step or job to the
workflow it belongs with, or create a new workflow file alongside the existing
ones. Keep steps using `uv run ...` so they share the synced environment.
