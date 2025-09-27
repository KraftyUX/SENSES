# Contributing to SENSES

Thank you for your interest in contributing! This project uses a simple workflow and standard Python tooling to keep quality high and contributions smooth.

## Getting started
1) Fork the repository and create a feature branch from dev:
   - git checkout dev
   - git pull
   - git checkout -b feat/your-change
2) Create a virtual environment and install dependencies:
   - python -m venv .venv
   - ./.venv/Scripts/Activate.ps1  # PowerShell on Windows
   - pip install -r requirements.txt
   - pip install ruff black pre-commit mypy
   - pre-commit install

## Development workflow
- Lint: ruff .
- Type check: mypy .
- Format: black .
- Tests: python -m unittest discover -v

Pre-commit will run these checks automatically on commit.

## Branching and PRs
- All work should branch off dev and target dev in PRs.
- Keep PRs focused and small when possible.
- Ensure CI passes (lint, type, format, tests).
- Add or update tests where reasonable.

## Commit messages
- Conventional style is preferred (e.g., feat:, fix:, docs:, chore:, ci:, build:).

## Code style
- Follow ruff/black defaults (configured in pyproject.toml).
- Use type hints where practical; mypy configuration is lenient by default.

## Reporting issues
- Include steps to reproduce, expected vs actual behavior, and environment info.

## License
- By contributing you agree your contributions are licensed under the MIT License (see LICENSE).
