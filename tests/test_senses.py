import json
import unittest

from senses import compute_senses


class TestComputeSenses(unittest.TestCase):
    def setUp(self):
        self.sample_data = {
            'coherence_ratings': [0.8, 0.9, 0.7],
            'structural_feedback': [0.85, 0.75, 0.9],
            'novelty_indicators': [1.2, 0.5, -0.3],
            'application_successes': [True, True, False],
            'likability_scores': [4.5, 5.0, 3.8]
        }

    def test_normal_case(self):
        metadata, composite = compute_senses(self.sample_data)
        self.assertAlmostEqual(composite, 0.743, places=3)
        self.assertEqual(
            json.loads(metadata),
            {"hear": 0.8, "see": 0.83, "smell": 0.56, "touch": 0.67, "taste": 0.86}
        )

    def test_empty_lists(self):
        data = {
            'coherence_ratings': [],
            'structural_feedback': [],
            'novelty_indicators': [],
            'application_successes': [],
            'likability_scores': []
        }
        metadata, composite = compute_senses(data)
        self.assertEqual(composite, 0.0)
        self.assertEqual(
            json.loads(metadata),
            {"hear": 0.0, "see": 0.0, "smell": 0.0, "touch": 0.0, "taste": 0.0}
        )

    def test_extreme_outliers(self):
        data = {
            'coherence_ratings': [0.8, 0.9, 1e6],
            'structural_feedback': [0.85, 0.75, 0.9],
            'novelty_indicators': [1.2, 0.5, -1e6],
            'application_successes': [True, True, False],
            'likability_scores': [4.5, 5.0, 1e6]
        }
        metadata, composite = compute_senses(data)
        self.assertAlmostEqual(json.loads(metadata)['hear'], 0.85, places=2)
        self.assertAlmostEqual(json.loads(metadata)['taste'], 0.94, places=2)

    def test_custom_z_threshold(self):
        data = {
            'coherence_ratings': [0.8, 0.9, 2.0],
            'structural_feedback': [0.85, 0.75, 0.9],
            'novelty_indicators': [1.2, 0.5, -0.3],
            'application_successes': [True, True, False],
            'likability_scores': [4.5, 5.0, 3.8]
        }
        metadata, composite = compute_senses(data, z_threshold=1.5)
        self.assertAlmostEqual(json.loads(metadata)['hear'], 0.85, places=2)


if __name__ == "__main__":
    unittest.main()
