# SECTION 3: INDEXING, DATA WRANGLING, BASIC PLOTS

# 3.1 Indexing ####

# R provides a powerful and convenient way of indexing vectors. We can, e.g, subset a vector based on properties of another vector. 

# Subsetting with logicals: e.g, if you're moving from Italy where the murder rate is only 0.71 per capita. You would prefer to move a state with a similar murder rate. R compares a vector with a single number by performing the test for each entry
library(dslabs)
data(murders)
# Compute the murder rates 
murder_rate <- murders$total / murders$population * 100000
ind <- murder_rate <0.71
# or instead we want to know if the value is less or equal
ind <- murder_rate <= 0.71
# To see which states these are, use index with logicals
murders$state[ind]
# Count how many are TRUE, sum() function returns the sum of the entries of a vector and logical vectors get coerced to numeric with TRUE coded as 1 and FALSE as 0
sum(ind)

# Logical operators: make two logicals true only when they are both true. Suppose you want to move to a safe state with the murder rate to be at most 1 in western region:
west <- murders$region == "West"
safe <- murder_rate <= 1
# Use "&" to get a vector of logicals that tells which states satisfy both conditions
ind <- safe & west
murders$state[ind] # 5 states meet this condition.

# which: tells which entries of a logical vector are TRUE. E.g, we want to look up California's murder rate. For this type of operation, it's convenient to convert vectors of logical into indexes instead of keeping long vectors of logicals.
ind <- which(murders$state == "California")
murder_rate[ind]

# match: tells which indexes of a second vector match each of the entries of a first vector. Instead of just one state we could find out the murder rate of several states
ind <- match(c("New York", "Florida", "Texas"), murders$state)
murder_rate[ind]

# %in%: tells whether or not each element of a first vector is in a second vector. E.g, find out if Boston, Dakota and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state
# These two lines produce the same index, although in different order:
match(c("New York", "Florida", "Texas"), murders$state)
which(murders$state %in% c("New York", "Florida", "Texas"))
