# Q4: Python Manipulation
#   Compute the standard deviation and the sum of a series of squares should
#   be computed

# import
import statistics

def calculate_squares(n, verbose=False):
    """ Calculates the square of each value between 1 and 'n', before returning:

            - The sum of these squares
            - The standard deviation of these squares
    """

    # calculate the sum of squares between 0 and n
    squares_list = []
    for i in range(1, n + 1):
        squares_list.append(i * i)

    # calculate the sum of all values in 'squares_list'
    squares_sum = sum(squares_list)

    # calculate the standard deviation of 'squares_list'
    squares_std_dev = statistics.stdev(squares_list)

    # print and return
    if verbose:
        print('[INFO] Sum of the squares of (1 - {}): {}'.format(n, squares_sum))
        print('[INFO] Standard Deviation of these squares: {}'.format(squares_std_dev))

    return squares_sum, squares_std_dev
###

calculate_squares(4, verbose=True)