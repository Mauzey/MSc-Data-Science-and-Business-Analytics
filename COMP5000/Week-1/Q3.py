# Q3: Comparing Strings
#   Write a python function to return the number of 'cat' and 'dog' instances in the list

pets = ['cat', 'dog', 'dog', 'cat', 'dog', 'dog']


def count_pets(pet_list):
    cat_count = pet_list.count('cat')
    dog_count = pet_list.count('dog')

    return cat_count, dog_count


print(count_pets(pets))