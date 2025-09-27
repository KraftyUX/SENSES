#!/bin/bash

# prepare_repo.sh
# ~~~~~~~~~~~~~~~
#
# This script prepares and optimizes the local GitHub repository for the Prompty SENSES algorithm.
# It performs the following tasks:
#   - Creates necessary directories.
#   - Copies and organizes files.
#   - Installs dependencies.
#   - Runs tests and profiling.
#   - Generates documentation stubs.
#   - Initializes a Git repository (if not already initialized).
#   - Creates a .gitignore file.
#   - Adds open-source licenses and attributions.
#
# Usage: ./prepare_repo.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Define the project name and directories
PROJECT_NAME="prompty-senses"
AUTHOR="Krafty"
AUTHOR_EMAIL="your.email@example.com"  # Replace with your email
SRC_DIR="src"
TEST_DIR="tests"
DOCS_DIR="docs"
GITHUB_DIR=".github"
WORKFLOWS_DIR="$GITHUB_DIR/workflows"

# Create directories
echo "Creating directory structure..."
mkdir -p "$SRC_DIR"
mkdir -p "$TEST_DIR"
mkdir -p "$DOCS_DIR"
mkdir -p "$GITHUB_DIR"
mkdir -p "$WORKFLOWS_DIR"

# Copy source files
echo "Copying source files..."
cp prompty_senses.py "$SRC_DIR/$PROJECT_NAME.py"
cp prepare_repo.sh .
cp README.md .

# Copy test files
echo "Copying test files..."
cp test_prompty_senses.py "$TEST_DIR/test_$PROJECT_NAME.py"

# Create a basic .gitignore file
echo "Creating .gitignore..."
cat > .gitignore <<EOL
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually checks for 'waf' and 'pyc' files
*spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# IDE-specific files
.idea/
.vscode/
*.swp
*.swo

# Profiling results
profile.prof

# Data files
*.csv
*.json
*.db
*.sqlite
EOL

# Create a basic requirements.txt
echo "Creating requirements.txt..."
cat > requirements.txt <<EOL
numpy>=1.21.0
EOL

# Create a basic setup.py for package installation
echo "Creating setup.py..."
cat > setup.py <<EOL
from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="$PROJECT_NAME",
    version="0.1.0",
    author="$AUTHOR",
    author_email="$AUTHOR_EMAIL",
    description="SENSES (HSSTT) algorithm for evaluating AI prompt quality.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/yourusername/$PROJECT_NAME",
    packages=find_packages(where="$SRC_DIR"),
    package_dir={"": "$SRC_DIR"},
    install_requires=[
        "numpy>=1.21.0",
    ],
    python_requires=">=3.8",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "Topic :: Scientific/Engineering :: Artificial Intelligence",
    ],
)
EOL

# Create a MIT License file
echo "Creating LICENSE (MIT)..."
cat > LICENSE <<'EOL'
MIT License

Copyright (c) 2025 Krafty

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOL

# Create a basic CONTRIBUTING.md
echo "Creating CONTRIBUTING.md..."
cat > CONTRIBUTING.md <<EOL
# Contributing to Prompty SENSES

Thank you for your interest in contributing to **Prompty SENSES**! This project is open-source under the [MIT License](LICENSE), and we welcome contributions from everyone.

## How to Contribute

### Reporting Bugs
- Open an issue on [GitHub](https://github.com/yourusername/$PROJECT_NAME/issues) with a clear description of the bug.
- Include steps to reproduce the issue, expected behavior, and actual behavior.

### Suggesting Features
- Open an issue on [GitHub](https://github.com/yourusername/$PROJECT_NAME/issues) with a detailed description of the feature.
- Explain why the feature would be useful and how it could be implemented.

### Submitting Pull Requests
1. **Fork the repository** and create a new branch for your changes.
2. **Make your changes**, ensuring the code follows the project's style and passes all tests.
3. **Write clear, concise commit messages**.
4. **Push your changes** to your fork and submit a pull request to the main repository.

### Code Style
- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) guidelines for Python code.
- Use descriptive variable and function names.
- Include docstrings for all functions and classes.
- Write unit tests for new features and bug fixes.

### Running Tests
To run the unit tests locally:
\`\`\`bash
python -m unittest discover tests
\`\`\`

### Profiling
To profile the code locally:
\`\`\`bash
python -m cProfile -o profile.prof -s cumulative src/$PROJECT_NAME.py
\`\`\`

## Code of Conduct
Please follow our [Code of Conduct](CODE_OF_CONDUCT.md) in all interactions.

## License
By contributing to this project, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
EOL

# Create a basic CODE_OF_CONDUCT.md
echo "Creating CODE_OF_CONDUCT.md..."
cat > CODE_OF_CONDUCT.md <<EOL
# Code of Conduct

## Our Pledge
We, as members, contributors, and leaders, pledge to make participation in our community a harassment-free experience for everyone, regardless of age, body size, visible or invisible disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

We pledge to act and interact in ways that contribute to an open, welcoming, diverse, inclusive, and healthy community.

## Our Standards
Examples of behavior that contributes to a positive environment for our community include:
- Demonstrating empathy and kindness toward other people.
- Being respectful of differing opinions, viewpoints, and experiences.
- Giving and gracefully accepting constructive feedback.
- Accepting responsibility and apologizing to those affected by our mistakes, and learning from the experience.
- Focusing on what is best not just for us as individuals, but for the overall community.

Examples of unacceptable behavior include:
- The use of sexualized language or imagery, and sexual attention or advances of any kind.
- Trolling, insulting or derogatory comments, and personal or political attacks.
- Public or private harassment.
- Publishing others' private information, such as a physical or email address, without their explicit permission.
- Other conduct which could reasonably be considered inappropriate in a professional setting.

## Enforcement Responsibilities
Community leaders are responsible for clarifying and enforcing our standards of acceptable behavior and will take appropriate and fair corrective action in response to any behavior that they deem inappropriate, threatening, offensive, or harmful.

Community leaders have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned with this Code of Conduct, and will communicate reasons for moderation decisions when appropriate.

## Scope
This Code of Conduct applies within all community spaces, and also applies when an individual is officially representing the community in public spaces. Examples of representing our community include using an official e-mail address, posting via an official social media account, or acting as an appointed representative at an online or offline event.

## Enforcement
Instances of abusive, harassing, or otherwise unacceptable behavior may be reported to the community leaders responsible for enforcement at [$AUTHOR_EMAIL](mailto:$AUTHOR_EMAIL).
All complaints will be reviewed and investigated promptly and fairly.

All community leaders are obligated to respect the privacy and security of the reporter of any incident.

## Attribution
This Code of Conduct is adapted from the [Contributor Covenant](https://www.contributor-covenant.org), version 2.1.
EOL

# Create a GitHub Actions workflow file
echo "Creating GitHub Actions workflow..."
cat > "$WORKFLOWS_DIR/test_and_profile.yml" <<EOL
name: Test and Profile

on: [push, pull_request]

jobs:
  test:
    name: Test (Python \${{ matrix.python-version }})
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.8", "3.9", "3.10"]

    steps:
      - uses: actions/checkout@v3

      - name: Set up Python \${{ matrix.python-version }}
        uses: actions/setup-python@v4
        with:
          python-version: \${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run unit tests
        run: |
          python -m unittest discover tests

  profile:
    name: Profile
    runs-on: ubuntu-latest
    needs: test

    steps:
      - uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Profile with cProfile
        run: |
          python -m cProfile -o profile.prof -s cumulative src/$PROJECT_NAME.py

      - name: Log profiling results
        run: |
          echo "Top 10 functions by cumulative time:"
          python -c "
          import pstats
          p = pstats.Stats('profile.prof')
          p.sort_stats('cumulative').print_stats(10)
          "

      - name: Upload profiling results
        uses: actions/upload-artifact@v3
        with:
          name: profile-results
          path: profile.prof
EOL

# Update README.md with attribution
echo "Updating README.md with attribution..."
cat > README.md <<EOL
# Prompty SENSES Algorithm

[![Test and Profile](https://github.com/yourusername/$PROJECT_NAME/actions/workflows/test_and_profile.yml/badge.svg)](https://github.com/yourusername/$PROJECT_NAME/actions/workflows/test_and_profile.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Prompty SENSES** is an open-source Python algorithm for evaluating AI prompt quality using metaphorical sensory scores (HSSTT: Hear, See, Smell, Touch, Taste). It aggregates user ratings and feedback to compute a composite quality metric.

**Author**: [Krafty](https://github.com/yourusername)

---

## Features

- **Hear**: Measures response coherence and logical flow.
- **See**: Evaluates structural clarity and organization.
- **Smell**: Detects novelty through deviation patterns.
- **Touch**: Assesses practical usability via success rates.
- **Taste**: Quantifies subjective preference and satisfaction.
- **Customizable**: Adjust the Z-score threshold for outlier removal.
- **Extensible**: Add your own metrics or sensory dimensions.
- **Robust**: Handles edge cases, large datasets, and invalid inputs gracefully.

---

## Installation

### Prerequisites

- Python 3.8+
- NumPy

### Install the Package

\`\`\`bash
git clone https://github.com/yourusername/$PROJECT_NAME.git
cd $PROJECT_NAME
pip install -r requirements.txt
\`\`\`

Or install directly from PyPI (if published):

\`\`\`bash
pip install $PROJECT_NAME
\`\`\`

---

## Usage

### Basic Example

\`\`\`python
from $PROJECT_NAME import compute_senses

data = {
    'coherence_ratings': [0.8, 0.9, 0.7],
    'structural_feedback': [0.85, 0.75, 0.9],
    'novelty_indicators': [1.2, 0.5, -0.3],
    'application_successes': [True, True, False],
    'likability_scores': [4.5, 5.0, 3.8]
}

metadata, composite = compute_senses(data)
print(metadata)  # '{"hear": 0.8, "see": 0.83, "smell": 0.56, "touch": 0.67, "taste": 0.86}'
print(composite)  # 0.744
\`\`\`

### Custom Z-Score Threshold

\`\`\`python
metadata, composite = compute_senses(data, z_threshold=2.0)
\`\`\`

---

## API Reference

### \`compute_senses(ratings_data, z_threshold=3.0)\`

**Parameters:**

- \`ratings_data\` (dict): Dictionary of user ratings and feedback.
  - \`coherence_ratings\` (list[float]): Scores for response coherence (0-1).
  - \`structural_feedback\` (list[float]): Scores for structural clarity (0-1).
  - \`novelty_indicators\` (list[float]): Deviation scores for novelty.
  - \`application_successes\` (list[bool]): Boolean indicators of successful applications.
  - \`likability_scores\` (list[float]): Subjective ratings (1-5).
- \`z_threshold\` (float, optional): Z-score threshold for outlier removal. Defaults to 3.0.

**Returns:**

- \`metadata\` (str): JSON string of rounded SENSES scores.
- \`composite\` (float): Arithmetic mean of all SENSES scores.

---

## Development

### Running Tests

\`\`\`bash
python -m unittest discover tests
\`\`\`

### Profiling

\`\`\`bash
python -m cProfile -o profile.prof -s cumulative src/$PROJECT_NAME.py
\`\`\`

### Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

For questions or feedback, please open an issue or contact [Krafty](mailto:$AUTHOR_EMAIL).
EOL

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Run tests
echo "Running unit tests..."
python -m unittest discover tests

# Profile the code
echo "Profiling the code..."
python -m cProfile -o profile.prof -s cumulative src/$PROJECT_NAME.py

# Initialize Git repository (if not already initialized)
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: Prepare repository for open-source release"
else
    echo "Git repository already initialized."
fi

echo "Repository preparation complete!"
echo "Don't forget to:"
echo "1. Replace 'yourusername' and 'your.email@example.com' in the generated files."
echo "2. Push the repository to GitHub."
