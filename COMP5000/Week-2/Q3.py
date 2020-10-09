# Q3: Writing a Text File

# import
import datetime


def add_exercise(file, exercise):
    """
    :param file: the file to append to
    :param exercise: the exercise to be added
    """
    # prompt the user to decide whether they want to add the specified exercise to the workout
    while True:
        user_input = input("Would you like to enter {}? (y/n) ".format(exercise)).lower()

        # process user input
        if user_input == 'y':
            # prompt the user to enter the number of repetitions they did
            while True:
                try:
                    if exercise == 'jog':
                        rep_input = int(input("How many meters did you jog? "))
                    else:
                        rep_input = int(input("How many repetitions did you do? "))

                    break
                except ValueError:
                    print("Please enter an integer value")

            # append exercise and details to file
            file.write("{}: {}\n".format(exercise, rep_input))
            break
        elif user_input == 'n':
            break
        else:
            print('Please answer yes (\'y\') or no (\'n\')')


# open the file with append permissions
edit_file = open("exercise-log.txt", 'a')

# append time
date = datetime.datetime.now()
edit_file.write("Time: {}\n".format(date.strftime('%c')))

# append exercises
exercises = ['press-ups', 'sit-ups', 'jog']
for ex in exercises:
    add_exercise(edit_file, ex)

# add line break to the end of the file
edit_file.write("\n")

# close file
edit_file.close()
