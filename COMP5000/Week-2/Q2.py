# Q2: Counting Words
text = "I watched a great film last night called Speed. There was a bomb on a bus. If the bus " \
       "slowed down, then the bomb exploded and everyone died. The guy who put the bomb on the " \
       "bus was crazy."

# split the text into words
split_text = text.lower().rstrip().rsplit()

# calculate the number of occurrences for each word
occurrences = {}
for word in split_text:
    if word in occurrences:
        occurrences[word] += 1
    else:
        occurrences[word] = 1

print(occurrences)
