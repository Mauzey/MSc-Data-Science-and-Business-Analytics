# Task 1
#   Write a python script to compute the mean of a set of values

values = [67, 80, 39, 36]

def calculate_mean(values):    
    # sum the items in the list
    value_sum = 0
    for value in values:
        value_sum += value
    
    # divide this sum by the number of items in the list
    mean = value_sum / len(values)
    
    return mean

# execute function and print
print(calculate_mean(values))