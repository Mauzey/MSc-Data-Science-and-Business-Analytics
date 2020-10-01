# Basic Commands --------------------------------------

2 + 2 # basic math
1:100 # prints numbers 1 to 100 across several lines
print('Hello World!') # prints 'Hello World' to the console

# Assigning Values ------------------------------------

# individual values
a <- 1 # use <- and not =
2 -> b # can go the other way, but this is bad practice
c <- d <- e <- 3 # multiple assignments

# multiple values
x <- c(1, 2, 5, 9) # c = combine/concatenate
x # prints the contents of x to the console

# Sequences -------------------------------------------

# create sequential data
0:10 # 0 through 10
10:0 # 10 through 0
seq(10) # 1 to 10
seq(30, 0, by=-3) # count down from 30 by 3

# Math ------------------------------------------------

# surround command with parenthesis to also print
(y <- c(5, 1, 0, 10))
x + y # adds corresponding elements in x and y
x * 2 # multiplies each element in x by 2
2 ^ 6 # powers/exponents
sqrt(64) # square root
log(100) # natural log: base e (2.71828...)
log10(100) # base 10 log

# Clean Up --------------------------------------------

# clear environment
rm(list = ls())
