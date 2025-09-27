# SENSES (HSSTT) Algorithm

[![CI](https://github.com/KraftyUX/SENSES/actions/workflows/ci.yml/badge.svg)](https://github.com/KraftyUX/SENSES/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This repository contains a Python implementation of the SENSES algorithm for evaluating the quality of AI-generated prompts using five metaphorical sensory scores:
- Hear: coherence and logical flow
- See: structural clarity and organization
- Smell: novelty via deviation patterns
- Touch: practical usability via success rates
- Taste: subjective preference and satisfaction

The composite score is the arithmetic mean of these five scores.

## Requirements
- Python 3.8+
- NumPy

Install dependencies:

1) Create/activate a virtual environment (recommended)
2) Install requirements

PowerShell example:
- python -m venv .venv
- .\.venv\Scripts\Activate.ps1
- pip install -r requirements.txt

## Usage
Example:

from senses import compute_senses

ratings = {
    'coherence_ratings': [0.8, 0.9, 0.7],
    'structural_feedback': [0.85, 0.75, 0.9],
    'novelty_indicators': [1.2, 0.5, -0.3],
    'application_successes': [True, True, False],
    'likability_scores': [4.5, 5.0, 3.8]
}

metadata_json, composite = compute_senses(ratings)
print(metadata_json)  # e.g. {"hear": 0.8, "see": 0.83, "smell": 0.56, "touch": 0.67, "taste": 0.86}
print(composite)      # e.g. 0.74

To change the outlier Z-score threshold:

metadata_json, composite = compute_senses(ratings, z_threshold=2.0)

## Running tests
- python -m unittest discover -v

## Utilities
- PowerShell setup: `./prepare_repo.ps1 -CreateVenv`

## Project layout
- senses.py: main module (includes logging and input validation)
- tests/: unit tests that validate core behavior
- requirements.txt: Python dependencies

## Releasing on GitHub (manual)
1) Ensure tests pass locally
2) Commit changes and tag a version
- git add .
- git commit -m "chore: prepare v0.1.0"
- git tag -a v0.1.0 -m "Initial release"
3) Push to GitHub
- git push origin main --tags
4) Draft a new Release on GitHub using tag v0.1.0 and summarize changes from CHANGELOG.md

## License
MIT License — see LICENSE for details.
