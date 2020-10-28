# Q1: Regular Expressions

# import and setup
import re

data = ["The north and south coats of Devon each have both cliffs and sandy shores.",
        "The inland terrain is rural, and generally hilly.",
        "Dartmoor is the largest open space in southern England, at 954km2 (368 square miles)",
        "Its moorland extends across a large expanse of granite bedrock.",
        "To the north of Dartmoor are the Culm Measures and Exmoor.",
        "In the valleys and lowlands of south and east Devon, the soil is more fertile."]


# task 1: print the line, which starts with "To"
def match_first(k, d):
    """
    search a list of strings for elements which begin with a defined keyword and print those that do

    :param k: (string) keyword to search for
    :param d: (list) list of strings to search
    """
    for s in d:
        if re.match(k, s):
            print(s)


# task 2: print the line, which ends with "hilly."
def search_end(k, d):
    """
    search a list of strings for elements which end with a defined keyword and print those that do

    :param k: (string) keyword to search for
    :param d: (list) list of strings to search
    """
    for s in d:
        if re.search(k + '$', s):
            print(s)


# task 3: select the line which contains numbers
def check_for_digit(d):
    """
    search a list of strings for elements which contain numbers and print those that do

    :param d: (list) list of strings to search
    """
    for s in d:
        if any(char.isdigit() for char in s):
            print(s)


# task 4: select the line with two instances of a defined keyword
def check_for_keyword(k, d):
    """
    search a list of strings for elements which contain two instances of a defined keyword, and print those that do

    :param k: (string) keyword to search for
    :param d: (list) list of strings to search
    """
    for s in d:
        if len(re.findall(r'(?:^|\W)' + k + r'(?:$|\W)', s)) == 2:
            print(s)


print('\nANS[1]')
match_first('To', data)
print('\nANS[2]')
search_end('hilly.', data)
print('\nANS[3]')
check_for_digit(data)
print('\nANS[4]')
check_for_keyword('and', data)
