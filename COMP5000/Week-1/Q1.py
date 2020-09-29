# Q1: Inputting and Storing Numbers
num_list = []

while True:
    user_input = int(input('Enter a positive integer (negative to terminate app): '))

    if user_input >= 0:
        num_list.append(user_input)
    else:
        print('Sum of list values: {}'.format(sum(num_list)))
        break