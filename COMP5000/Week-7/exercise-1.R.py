# Exercise 1
# Create a Cube class which is has methods which return the volume and surface area

# Import and Setup
import unittest


class Cube:
    def __init__(self, x):
        self.x = x

    def volume(self):
        return self.x ** 3

    def surface_area(self):
        return 6 * self.x * self.x


cube = Cube(10)
print("Volume......:", cube.volume())
print("Surface Area:", cube.surface_area())