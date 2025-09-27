# SENSES Algorithm

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue)](https://www.python.org/)

SENSES is a Python module that implements the **SENSES (HSSTT) algorithm** for evaluating the quality of AI-generated prompts based on user ratings and feedback. The algorithm computes five metaphorical sensory scores—**Hear, See, Smell, Touch, Taste**—and a composite score as their arithmetic mean.

---

## **Features**

- **Hear**: Measures the coherence and logical flow of responses.
- **See**: Evaluates the structural clarity and organization of outputs.
- **Smell**: Detects novelty and innovation through deviation patterns.
- **Touch**: Assesses practical usability via application success rates.
- **Taste**: Quantifies subjective user preference and satisfaction.
- **Robust Input Validation**: Ensures data integrity and handles edge cases.
- **Outlier Removal**: Uses the Z-score method to filter anomalous data.
- **Normalization**: Ensures scores are comparable and within expected ranges.
- **Extensibility**: Supports additional custom metrics.
- **Logging**: Tracks function calls, errors, and results for debugging.

---

## **Installation**

### **Prerequisites**
- Python 3.8+
- NumPy

### **Install the Package**

```bash
git clone https://github.com/KraftyUX/SENSES.git
cd SENSES
pip install -r requirements.txt
```

Or install directly from PyPI (if published):

```bash
pip install senses
```

---

## **Usage**

### **Basic Example**

```python
from senses import compute_senses

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
```

### **Custom Z-Score Threshold**

```python
metadata, composite = compute_senses(data, z_threshold=2.0)
```

---

## **API Reference**

### **`compute_senses(ratings_data, z_threshold=3.0)`**

**Parameters:**

- `ratings_data` (dict): Dictionary of user ratings and feedback.
  - `coherence_ratings` (list[float]): Scores for response coherence (0-1).
  - `structural_feedback` (list[float]): Scores for structural clarity (0-1).
  - `novelty_indicators` (list[float]): Deviation scores for novelty.
  - `application_successes` (list[bool]): Boolean indicators of successful applications.
  - `likability_scores` (list[float]): Subjective ratings (1-5).
- `z_threshold` (float, optional): Z-score threshold for outlier removal. Defaults to 3.0.

**Returns:**

- `metadata` (str): JSON string of rounded SENSES scores.
- `composite` (float): Arithmetic mean of all SENSES scores.

---

## **Data Structures**

### **`RatingsData` (TypedDict)**

Defines the structure of input data:

- `coherence_ratings`: List of floats (0-1) for response coherence.
- `structural_feedback`: List of floats (0-1) for structural clarity.
- `novelty_indicators`: List of floats (z-scores) for novelty.
- `application_successes`: List of booleans for success rates.
- `likability_scores`: List of floats (1-5) for subjective ratings.
- `custom_metric`: Optional placeholder for additional metrics.

---

## **Error Handling**

- **Input Validation Errors**: Raised for missing keys, invalid types, or out-of-range values.
- **Unexpected Errors**: Logged and re-raised as `RuntimeError` with descriptive messages.

---

## **Performance Considerations**

- Uses **NumPy vectorization** for efficient numerical operations.
- **Logging** helps track performance and debug issues.

---

## **Extensibility**

- The `custom_metric` field in `RatingsData` allows for additional metrics.
- The `z_threshold` parameter in `compute_senses` allows customization of outlier removal.

---

## **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## **Contributing**

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## **Contact**

For questions or feedback, please open an issue or contact [KraftyUX](mailto:your.email@example.com).

---

This `README.md` provides a clear and comprehensive overview of your project, making it easy for users and contributors to understand and use the **SENSES** algorithm.
