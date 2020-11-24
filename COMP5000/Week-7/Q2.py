# Q2: Testing Framework

# Import and Setup
import unittest


def contant_model(x, c):
    return c


def linear_model(x, m, c):
    return m * x + c


def quadratic_model(x, a, b, c):
    return (a * x^2) + (b * x) + c


class TestModels(unittest.TestCase):
    def test_constant_model(self):
        self.assertEqual(contant_model(2, 5.5), 5.5, "Should return 5.5")

    def test_linear_model(self):
        self.assertEqual(linear_model(1, 1, 1), 2, "Should return 2")

    def test_quadratic_model(self):
        self.assertEqual(quadratic_model(5, 3, 2, 4), 27, "Should be 27")


if __name__ == '__main__':
    unittest.main()

    print(quadratic_model(5, 3, 1, 2))
