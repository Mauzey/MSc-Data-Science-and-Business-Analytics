# Q1: String Manipulation
forenames = ['William', 'James', 'Logan', 'Benjamin']
surnames = ['Wilson', 'Davies', 'Walker', 'Hall']
usernames = []

for i, name in enumerate(forenames):
    usernames.append(name.lower() + surnames[i].lower())

print(usernames)
