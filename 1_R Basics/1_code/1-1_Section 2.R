# SECTION 2: VECTORS AND SORTING

# 2.1 Vectors ####

# In R, the most basic objects available to store data are vectors. Complex datasets can usually be broken down into components that are vectors. E.g, in a data frame, each column is a vector.

# Creating vectors: using c() function (stands for concatenate)
codes <- c(380, 124, 818)
codes
# Create character vectors
country <- c("italy", "canada", "egypt")
country # characters must be in quotes "".

# Name: Sometimes it is useful to name the entries of a vector
codes <- c(italy = 380, canada = 124, egypt = 818)
# The object codes continues to be a numeric vector
class(codes)
# but with names
names(codes)
# Names could be also assigned with names() function
names(codes) <- country

# Sequence: another useful function for creating vectors generates sequences
seq(1, 10)
# The default is to go up in increments of 1, this could be changed with a third argument
seq(1, 10, 2)
# Shorthand for consecutive integers
1:10 # this function only produces integers, not numeric, because they are typically used to index something
class(1:10)
# If the sequence contains a non-integers, the class changes
class(seq(1, 10, 0.5))

# Subsetting: use square bracket [] to access specific elements of a vector
codes[2] # canada
# Get more than one entry using a multi-entry vector as an index
codes[c(1,3)]
# The sequences are particularly useful to access consecutive elements
codes[1:2]
# If the elements have names, we can also access the entries using names
codes["canada"]
codes[c("egypt", "italy")]

# 2.2 Coercion ####

# In general, coercion is an attempt by R to be flexible with data types. If we try to combine different types of data, e.g:
x <- c(1, "canada", 3) # R coerced the data into characters!
# R also offers functions to change from one type to another
x <- 1:5
y <- as.character(x)
class(y) # change from integer to character.
as.numeric(y)
class(y) # turns it back to numeric.

# Not available (NA): when a function tries to coerce one type to another and encounters an impossible case, it turns the entry into a special value called NA. E.g:
x <- c("1", "b", "3")
as.numeric(x) # R does not have any guess for what number stands for "b", so it returns a NA value.
# In data science, NAs are often used for missing data, a common problem in real-world datasets.
