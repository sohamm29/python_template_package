# Contributing

Thanks for contributing. This guide covers the workflow for this project and any
repository generated from this template.

## Getting Started

1. Install [uv](https://github.com/astral-sh/uv).
2. Sync the environment and install the hooks:

   ```bash
   uv sync
   uv run pre-commit install --install-hooks
   ```

See [docs/setup.md](docs/setup.md) for the full setup and commit walkthrough.

## Workflow

1. Open an issue describing the bug or feature before starting work.
2. Create a branch. Ideally create it directly from the issue so it follows
   GitHub's default naming norm `<issue#>-<short-description>` (e.g.
   `42-add-health-check`). If the work is not associated with an issue, prefix
   the branch with `no-issue` and the change type:
   - `no-issue-feat-<short-description>` for features
   - `no-issue-fix-<short-description>` for bug fixes
   - `no-issue-docs-<short-description>` for documentation
   - `no-issue-chore-<short-description>` for tooling and maintenance
3. Make your changes. Keep reusable logic in `src/`; keep experiments in
   `notebooks/`.
4. Commit using [Conventional Commits](https://www.conventionalcommits.org) messages:

   ```bash
   git commit -m "feat(api): add health check endpoint"
   ```

5. Open a pull request, describe the change, and link the related issue.

## Code Quality

Pre-commit hooks run automatically on commit (ruff, pyright, gitleaks,
interrogate, and more). To run them all manually before committing:

```bash
uv run pre-commit run -a
```

A commit that fails the hooks will not go through. Fix the reported issues
rather than bypassing the checks.

## Issues

Use the provided templates when opening an issue (bug report, feature request,
or documentation update). Apply a `priority:*` label and the relevant
`subject:*` label to help with triage.
