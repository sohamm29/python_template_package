# Setup

## Repository Naming

Name repositories in **all lowercase**, with the project indication first,
followed by the component or purpose. Use hyphens to separate words.

```
<project>-<component>
<project>-<component>-<detail>
```

Examples:

- `glintt-next-template`
- `glintt-billing-api`
- `glintt-billing-etl`

Avoid uppercase letters, spaces, and underscores so names stay consistent across
Git hosts, Docker images, and shell paths.

## Ground Zero

Make sure you have [uv](https://github.com/astral-sh/uv) installed. Then, from
the root of the repository:

```bash
uv sync
```

This creates the virtual environment in `.venv/` and installs every dependency
pinned in `uv.lock`, so the environment is reproducible across machines.

### Adding Dependencies

Do not edit `pyproject.toml` by hand. Use `uv add`, which resolves the version,
updates `pyproject.toml`, and refreshes `uv.lock` in one step:

```bash
# Runtime dependency
uv add requests

# Development/tooling dependency (not shipped to production)
uv add --dev pytest

# Remove a dependency
uv remove requests
```

After adding or removing, commit the updated `pyproject.toml` and `uv.lock`
together.

## Pre-commit

To run pre-commit locally without committing, if installed using uv:

```bash
uv run pre-commit clean
uv run pre-commit install --install-hooks
uv run pre-commit run -a
```

Run this once before committing so common issues like trailing whitespace are
caught early. The `-a` flag runs every hook against all files from scratch;
without it, hooks only run on changed files.

## Commits

Write commit messages following [Conventional Commits](https://www.conventionalcommits.org):

```
<type>(<optional scope>): <description>
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`. Example:

```bash
git commit -m "feat(api): add health check endpoint"
```

If a commit fails the pre-commit checks it will not go through. Fix the reported
issues, or, only when necessary, bypass the checks:

```bash
git commit --no-verify -m "..."
```

## Issues

Open an issue before starting work. Three templates are available when you
create one:

- **Bug Report** (`[BUG]`) - labeled `bug`
- **Feature Request** (`[FEATURE]`) - labeled `enhancement`
- **Documentation Update** (`[DOCS]`) - labeled `documentation`

### Issue Structure

Keep issues short and focused on a single change. A good issue has:

1. A clear title following the template prefix, e.g. `[BUG] sync fails on Python 3.13`.
2. A one or two sentence summary of the problem or request.
3. Enough context to reproduce or understand it (steps, expected vs. actual, or motivation).

### Labels

After opening an issue, apply:

- A **priority** label: `priority:high`, `priority:medium`, or `priority:low`.
- A **subject** label (e.g. `subject: general`) to indicate the area.
- Any relevant type label, such as `duplicate`, `invalid`, or `good first issue`.

### From Issue to Branch

Ideally, create the branch directly from the issue so it follows GitHub's
default naming norm:

- `<issue#>-<short-description>` — e.g. `42-add-health-check`

If the work is not associated with an issue (or the issue-based flow is not
possible), prefix the branch with `no-issue` and the change type:

- `no-issue-feat-<short-description>` for features
- `no-issue-fix-<short-description>` for bug fixes
- `no-issue-docs-<short-description>` for documentation
- `no-issue-chore-<short-description>` for tooling and maintenance

Reference the issue number in the pull request so it closes automatically when
merged.
