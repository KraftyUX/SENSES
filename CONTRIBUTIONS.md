# Contributions

We welcome all contributions — bug reports, feature requests, and pull requests.

## How to contribute
1) Fork the repository and work off the `dev` branch:
   - git checkout dev && git pull
   - git checkout -b feat/your-change
2) Set up your environment:
   - python -m venv .venv
   - ./.venv/Scripts/Activate.ps1  # PowerShell on Windows
   - pip install -r requirements.txt
   - pip install ruff black pre-commit mypy
   - pre-commit install
3) Make your changes with tests.
4) Run checks locally:
   - ruff .
   - black --check .
   - mypy .
   - python -m unittest discover -v
5) Commit using conventional commits when possible (e.g., feat:, fix:, docs:, chore:, ci:, build:).
6) Open a pull request targeting `dev` and describe your changes clearly.

## Code style and quality
- Formatting: black (configured in pyproject.toml)
- Linting: ruff (includes isort and pyupgrade)
- Types: mypy (lenient defaults)

## Reporting issues
- Include steps to reproduce, expected vs actual behavior, and environment info.

## License
By contributing, you agree that your contributions are licensed under the MIT License (see LICENSE).
