# SECTION 2: VECTORS AND SORTING

# 2.1 Vectors ####

# In R, the most basic objects available to store data are vectors. Complex datasets can usually be broken down into components that are vectors. E.g, in a data frame, each column is a vector.

# Creating vectors: using c() function (stands for concatenate).
codes <- c(380, 124, 818)
codes
# Create character vectors:
country <- c("italy", "canada", "egypt")
country # characters must be in quotes "".

# Name: sometimes it is useful to name the entries of a vector.
codes <- c(italy = 380, canada = 124, egypt = 818)
# The object codes continues to be a numeric vector.
class(codes)
# but with names
names(codes)
# Names could be also assigned with names() function.
names(codes) <- country

# Sequence: another useful function for creating vectors generates sequences
seq(1, 10)
# The default is to go up in increments of 1, this could be changed with a third argument
seq(1, 10, 2)
# Shorthand for consecutive integers:
1:10 # this function only produces integers, not numeric, because they are typically used to index something
class(1:10)
# If the sequence contains a non-integers, the class changes.
class(seq(1, 10, 0.5))
# Determine the length of the sequence:
length(seq(1, 10, 2))
# length.out: this argument generates sequences that are increasing by the same amount but are of the prescribed length.
seq(1, 10, length.out = 100)

# Subsetting: use square bracket [] to access specific elements of a vector.
codes[2] 
# Get more than one entry using a multi-entry vector as an index:
codes[c(1,3)]
# The sequences are particularly useful to access consecutive elements.
codes[1:2]
# If the elements have names, we can also access the entries using names.
codes["canada"]
codes[c("egypt", "italy")]

# 2.2 Coercion ####

# In general, coercion is an attempt by R to be flexible with data types. If we try to combine different types of data, e.g:
x <- c(1, "canada", 3) # R coerced the data into characters!
# We can avoid issues with coercion in R by changing characters to numerics and vice-versa. This is known as typecasting.
x <- 1:5
y <- as.character(x)
class(y) # change from integer to character.
as.numeric(y)
class(y) # turns it back to numeric.

# Not available (NA): when a function tries to coerce one type to another and encounters an impossible case, it turns the entry into a special value called NA. E.g:
x <- c("1", "b", "3")
as.numeric(x) # R does not have any guess for what number stands for "b", so it returns a NA value.
# In data science, NAs are often used for missing data, a common problem in real-world datasets.

# is.na(): returns a logical vector that tells us which entries are NA.
# The na_example dataset which is a part of the dslabs package represents a series of counts
data("na_example")
# Checking out the structure of the dataset:
str(na_example) 
# Find out the mean() of the entire dataset:
mean(na_example) # returns NA because there's NA value in it.
# Compute the average, for entries of na_example that are not NA:
mean(na_example[!is.na(na_example)])
# Determine how many NAs there are in the dataset.
sum(is.na(na_example)) # sum() counts TRUE as 1.

# 2.3 Sorting ####

# sort(): sorts a vector in increasing order.
# E.g, use sort() to rank the states from least to most gun murders.
library(dslabs)
data(murders)
sort(murders$total) # however, this does not give much information about which states have which murder totals.
# When looking at the dataset, we may want to sort the data in an order that makes more sense for analysis. E.g, sort the states alphabetically:
states <- sort(murders$state)
# Report the first alphabetical value:
state[1]

# order(): takes a vector as input and returns the vector of indexes that sorts the input vector.
x <- c(31, 4, 15, 92, 65)
order(x)
index <- order(x)
x[index] # same output as order(x).
# This can be useful for finding row numbers with certain properties, e.g "the state with the smallest population".
pop <- murders$population
order(pop)[1]

# In the case study, the entries of vectors accessed with $ follow the same order as the rows in the table.
murders$state[1:6]
murders$abb[1:6] # state names and abbreviations match respectively.
# This means we can order the state names by their total murders. First obtain the index that orders the vectors according to murder totals and then index the state names vector:
ind <- order(murders$total)
murders$abb[ind] # California has the most murders.

# max(): gives the largest value.
max(murders$total)

# which.max(): gives index of the largest value.
i_max <- which.max(murders$total)
states[i_max]

# min() and which.min(): similarly for the minimum value.
i_min <- which.min(murders$population)
states[i_min]

# rank(): returns a vector with the rank of the input vector.
rank(x)
# Determine the population size ranks:
ranks <- rank(pop)
# If rank(x) gives you the ranks of x from lowest to highest, rank(-x) gives you the ranks from highest to lowest.
rank(-x)
# Determine the population size rank (from smallest to biggest) of each state:
ranks <- rank(murders$population)
# Create a data frame with state names and their respective ranks:
rank_df <- data.frame(murders$state, ranks)
rank_df

# Recycling: vectors are added element-wise. If the vectors don't match in length, it is natural to assume that we should get an error. But R recycles the vector's elements and only gives warning. 
y <- c(1, 2, 3)
y <- c(10, 20, 30, 40, 50, 60, 70)
x + y

# 2.4 Vector arithmetic ####

# California had the most murders, but does it mean it is the most dangerous state? What if it just has many more people? Confirm by
murders$state[which.max(murders$population)] # California has indeed the largest population in the US.
# To compare how safe different states are, what we should compute is the murders per capita by using vector arithmetic capabilities.

# Rescale a vector: arithmetic operations on vectors occur element-wise. E.g, suppose we have height in inches:
inches <- c(69, 62, 66, 70, 73, 67, 73, 67, 70)
# Convert to centimeters:
inches * 2.54 # each element is multiplied by 2.54

# Two vectors: if two vectors have the same length, the sum will be added entry by entry. The same holds for other mathematical operations, such as -, * and /.
# Compute the murder rates: 
murder_rate <- murders$total / murders$population * 100000
# Calculate the average rate in the US:
mean(murder_rate)
# Order the states by the murder rate, in decreasing order:
murders$state[order(murder_rate, decreasing = TRUE)] # California is not even in the top 10.