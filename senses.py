# SPDX-License-Identifier: MIT
# Copyright (c) 2025 KraftyUX

"""
senses.py
~~~~~~~~~

This module implements the SENSES (HSSTT) algorithm for evaluating the quality of
AI-generated prompts based on user ratings and feedback. The algorithm computes five
metaphorical sensory scores:

- Hear: Measures the coherence and logical flow of responses.
- See: Evaluates the structural clarity and organization of outputs.
- Smell: Detects novelty and innovation through deviation patterns.
- Touch: Assesses practical usability via application success rates.
- Taste: Quantifies subjective user preference and satisfaction.

The composite score is the arithmetic mean of these five sensory scores.
"""

import json
import logging
from typing import Optional, TypedDict

import numpy as np

# Configure logging to track function calls and errors
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# TypedDict for input data structure
class RatingsData(TypedDict, total=False):
    """
    TypedDict to define the structure of input ratings and feedback data.

    Attributes:
        coherence_ratings (list[float]): Scores for response coherence (0-1).
        structural_feedback (list[float]): Scores for structural clarity (0-1).
        novelty_indicators (list[float]): Deviation scores for novelty (e.g., z-scores).
        application_successes (list[bool]): Boolean indicators of successful applications.
        likability_scores (list[float]): Subjective ratings (1-5).
        custom_metric (Optional[list[float]]): Placeholder for additional custom metrics.
    """

    coherence_ratings: list[float]
    structural_feedback: list[float]
    novelty_indicators: list[float]
    application_successes: list[bool]
    likability_scores: list[float]
    custom_metric: Optional[list[float]]


def remove_outliers(data_list: list[float], threshold: float = 3.0) -> list[float]:
    """
    Removes outliers from a list of numerical values using the Z-score method.

    The Z-score measures how many standard deviations a value is from the mean.
    Values with a Z-score beyond the threshold are considered outliers and removed.

    Args:
        data_list (List[float]): List of numerical values.
        threshold (float): Z-score threshold for outlier detection. Defaults to 3.0.

    Returns:
        List[float]: List with outliers removed.
    """
    if len(data_list) < 2:
        # If the list has fewer than 2 elements, outliers cannot be meaningfully detected
        return data_list

    # Convert the list to a NumPy array for vectorized operations
    data_arr = np.array(data_list)
    mean, std = np.mean(data_arr), np.std(data_arr)

    # If the standard deviation is zero, all values are identical; no outliers
    if std == 0:
        return data_list

    # Calculate Z-scores for all values
    z_scores = np.abs((data_arr - mean) / (std + 1e-9))  # Add small value to avoid division by zero

    # Filter out values with Z-scores beyond the threshold
    return data_arr[z_scores <= threshold].tolist()


def compute_senses(ratings_data: RatingsData, z_threshold: float = 3.0) -> tuple[str, float]:
    """
    Computes the SENSES (HSSTT) scores from user ratings and feedback.

    This function processes input data to derive metaphorical sensory scores,
    applies outlier removal, and computes a composite quality metric.

    Args:
        ratings_data (RatingsData): Dictionary of user-provided metrics.
        z_threshold (float): Custom Z-score threshold for outlier removal. Defaults to 3.0.

    Returns:
        Tuple[str, float]:
            - JSON string of rounded SENSES scores.
            - Composite score (arithmetic mean of all SENSES scores).

    Raises:
        RuntimeError: If input validation fails or unexpected errors occur.
    """
    logger.info("Starting SENSES computation with Z-threshold: %s", z_threshold)

    try:
        # --- Input Validation ---
        if not isinstance(ratings_data, dict):
            raise ValueError("ratings_data must be a dictionary")

        # Check for missing required keys
        required_keys = [
            "coherence_ratings",
            "structural_feedback",
            "novelty_indicators",
            "application_successes",
            "likability_scores",
        ]
        missing_keys = [key for key in required_keys if key not in ratings_data]
        if missing_keys:
            raise ValueError(f"Missing required keys: {', '.join(missing_keys)}")

        # --- Hear: Coherence ---
        # Convert to NumPy array and filter invalid values outside [0, 1]
        coherence_arr = np.array(ratings_data["coherence_ratings"], dtype=float)
        coherence_filtered = coherence_arr[(coherence_arr >= 0) & (coherence_arr <= 1)].tolist()

        # Remove outliers and compute the mean
        coherence_clean = remove_outliers(coherence_filtered, z_threshold)
        hear = float(np.mean(coherence_clean)) if len(coherence_clean) else 0.0

        # --- See: Structural Feedback ---
        structural_arr = np.array(ratings_data["structural_feedback"], dtype=float)
        structural_filtered = structural_arr[(structural_arr >= 0) & (structural_arr <= 1)].tolist()

        # Remove outliers and compute the mean
        structural_clean = remove_outliers(structural_filtered, z_threshold)
        see = float(np.mean(structural_clean)) if len(structural_clean) else 0.0

        # --- Smell: Novelty ---
        novelty = np.array(ratings_data['novelty_indicators'], dtype=float)

        # Remove outliers and compute the mean of absolute values
        novelty_clean = remove_outliers(novelty.tolist(), z_threshold)
        novelty_abs = np.abs(novelty_clean)

        # Normalize the mean to [0, 1] by dividing by the maximum absolute value
        max_abs = np.max(novelty_abs) if len(novelty_abs) and np.any(novelty_abs > 0) else 1.0
        smell = float(np.mean(novelty_abs) / max_abs) if len(novelty_abs) else 0.0

        # --- Touch: Success Rate ---
        successes = ratings_data["application_successes"]

        # Validate that all values are boolean
        if not all(isinstance(x, bool) for x in successes):
            raise ValueError("application_successes must contain booleans")

        # Compute the proportion of successful applications
        touch = sum(successes) / len(successes) if successes else 0.0

        # --- Taste: Likability ---
        likability_arr = np.array(ratings_data["likability_scores"], dtype=float)

        # Filter invalid values outside [1, 5]
        likability_filtered = likability_arr[(likability_arr >= 1) & (likability_arr <= 5)].tolist()

        # Remove outliers and normalize the mean to [0, 1]
        likability_clean = remove_outliers(likability_filtered, z_threshold)
        taste = float((np.mean(likability_clean) - 1) / 4) if len(likability_clean) else 0.0

        # --- Composite Score ---
        # Compute the arithmetic mean of all SENSES scores
        hsstt_values = [hear, see, smell, touch, taste]
        composite_score = float(np.mean(hsstt_values))

        # --- Serialize Metadata ---
        # Round scores to two decimal places and serialize as JSON
        senses_metadata = {
            "hear": round(hear, 2),
            "see": round(see, 2),
            "smell": round(smell, 2),
            "touch": round(touch, 2),
            "taste": round(taste, 2),
        }
        serialized_metadata = json.dumps(senses_metadata)

        logger.info("SENSES computation completed. Composite score: %s", composite_score)
        return serialized_metadata, composite_score

    except (ValueError, TypeError) as e:
        # Log and re-raise input validation errors
        logger.error("Input validation error: %s", str(e))
        raise RuntimeError(f"Error processing ratings_data: {str(e)}") from e
    except Exception as e:
        # Log and re-raise unexpected errors
        logger.error("Unexpected error: %s", str(e))
        raise RuntimeError(f"Unexpected error: {str(e)}") from e
