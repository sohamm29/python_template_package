#!/usr/bin/env bash

# Mirrors the CI workflows (ci.yml, ruff.yml, pytest.yml) so failures can be
# caught locally before pushing.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Sync dependencies"
uv sync --all-extras --dev

echo "==> Pre-commit hooks"
uv run pre-commit run --all-files

echo "==> Ruff lint"
uv run ruff check .

echo "==> Ruff format"
uv run ruff format --check .

echo "==> Pytest"
uv run pytest
