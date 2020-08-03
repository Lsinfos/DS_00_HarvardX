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

# 2.3 Sorting ####

# sort() function: sorts a vector in increasing order.
# E.g, use sort() to rank the states from least to most gun murders
library(dslabs)
data(murders)
sort(murders$total) # however, this does not give much information about which states have which murder totals.

# order() function: takes a vector as input and returns the vector of indexes that sorts the input vector
x <- c(31, 4, 15, 92, 65)
order(x)
index <- order(x)
x[index] # same output as order(x)

# In the case study, the entries of vectors accessed with $ follow the same order as the rows in the table
murders$state[1:6]
murders$abb[1:6] #state names and abbreviations match respectively.
# This means we can order the state names by their total murders. First obtain the index that orders the vectors according to murder totals and then index the state names vector:
ind <- order(murders$total)
murders$abb[ind] # Carlifornia has the most murders.

# max(): gives the largest value
max(murders$total)

# which.max(): gives index of the largest value
i_max <- which.max(murders$total)
murders$state[i_max]

# min() and which.min(): similarly for the minimum value.

# rank(): returns a vector with the rank of the input vector:
rank(x)

# Recycling: vectors are added elementwise. If the vectors don't match in length, it is natural to assume that we should get an error. But R recycles the vector's elements and only gives warning 
y <- c(1, 2, 3)
y <- c(10, 20, 30, 40, 50, 60, 70)
x + y

# 2.4 Vector arithmetics ####

# California had the most murders, but does it mean it is the most dangerous state? What if it just has many more people? Confirm by
murders$state[which.max(murders$population)] # California has indeed the largest population in the US.
# To compare how safe different states are, what we should compute is the murders per capita by using vector arithmetic capibilities.

# Rescale a vector: arithmetic operations on vectors occur element-wise. E.g, suppose we have height in inches:
inches <- c(69, 62, 66, 70, 73, 67, 73, 67, 70)
# Convert to centimeters
inches * 2.54 # each element is multiplied by 2.54

# Two vectors: if two vectors have the same length, the sum will be added entry by entry. The same holds for other mathematical operations, such as -, * and /
# Compute the murder rates 
murder_rate <- murders$total / murders$population * 100000
# Order the states by the murder rate, in decreasing order
murders$state[order(murder_rate, decreasing = TRUE)] # California is not even in the top 10.

# 2.5 Indexing ####

# R provides a powerful and convenient way of indexing vectors. We can, e.g, subset a vector based on properties of another vector. 

# Subsetting with logicals: e.g, if you're moving from Italy where the murder rate is only 0.71 per capita. You would prefer to move a state with a similar murder rate. R compares a vector with a single number by performing the test for each entry
ind <- murder_rate <0.71
# or instead we want to know if the value is less or equal
ind <- murder_rate <= 0.71
# To see which states these are, use index with logicals
murders$state[ind]
# Count how many are TRUE, sum() function returns the sum of the entries of a vector and logical vectors get coerced to numeric with TRUE coded as 1 and FALSE as 0
sum(ind)