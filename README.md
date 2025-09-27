# SENSES (HSSTT) Algorithm

[![CI](https://github.com/KraftyUX/SENSES/actions/workflows/ci.yml/badge.svg)](https://github.com/KraftyUX/SENSES/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

SENSES is a lightweight Python library that quantifies the quality of AI prompts/responses across five sensory-inspired dimensions:
- Hear: coherence and logical flow
- See: structural clarity and organization
- Smell: novelty via deviation patterns
- Touch: practical usability via success rates
- Taste: subjective preference and satisfaction

It returns per-dimension scores and a composite score (simple mean), and is robust to noisy inputs via outlier handling.

## When to use SENSES
Use SENSES when you need to:
- Track quality trends of prompts/responses over time
- Compare models or prompt variants with a single composite metric
- Detect regressions in structure, coherence, or user satisfaction
- Normalize subjective ratings into consistent 0–1 ranges

## Installation
Requirements:
- Python 3.8+
- NumPy

Install in a virtual environment (recommended):

```bash
python -m venv .venv
. ./.venv/Scripts/Activate.ps1  # PowerShell on Windows
pip install -r requirements.txt
```

## Usage
Basic example:

```python
from senses import compute_senses

data = {
    'coherence_ratings': [0.8, 0.9, 0.7],
    'structural_feedback': [0.85, 0.75, 0.9],
    'novelty_indicators': [1.2, 0.5, -0.3],
    'application_successes': [True, True, False],
    'likability_scores': [4.5, 5.0, 3.8]
}

metadata_json, composite = compute_senses(data)
print(metadata_json)  # {"hear": 0.8, "see": 0.83, "smell": 0.56, "touch": 0.67, "taste": 0.86}
print(composite)      # 0.74
```

Custom Z-score threshold for outlier filtering:

```python
metadata_json, composite = compute_senses(data, z_threshold=2.0)
```

## How it works (in brief)
- Filters invalid values (e.g., out-of-range ratings)
- Removes outliers via Z-score thresholding
- Normalizes dimensions to 0–1 where applicable
- Averages Hear/See/Smell/Touch/Taste into a composite score

## Development
Set up tooling (formatting, linting, tests):

```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
pip install ruff black pre-commit
pre-commit install
```

Run checks locally:
```bash
ruff .
black --check .
python -m unittest discover -v
```

## Project layout
- senses.py: main module (logging, validation, outlier handling)
- tests/: unit tests (unittest-discoverable)
- .github/workflows/ci.yml: CI for lint, format, tests
- pyproject.toml: project metadata and tool configuration

## License
MIT License — see LICENSE for details.
