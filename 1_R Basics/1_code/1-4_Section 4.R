# SECTION 4: PROGRAMMING BASICS

# R is not just a data analysis environment but also a programming language. Three key programming concepts are: conditional expressions, for-loops, and functions.

# 4.1 Conditional expressions ####

# Conditional expressions are used for what is called flow control.
# If-else statement:
a <- 0
if(a != 0){
  print(1/a)
} else{
  print("No reciprocal for 0.")
}
# Using the US murder data frame:
library(dslabs)
data("murders")
murder_rate <- murders$total / murders$population * 100000
# Determine which states have a murder rate lower than 0.5:
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5){
  print(murders$state[ind])
} else {
  print("No state has murder rate that low")
}
# If we try again with a rate of 0.25, we get a different answer.
if(murder_rate[ind] < 0.25){
  print(murder$state[ind])
} else {
  print ("No state has murder rate that low")
}

# ifelse(): takes 3 arguments (a logical and two possible answers). If the logical is TRUE, the value in the second argument is returned. If FALSE, the value in the third argument is returned.
a <- 0
ifelse(a > 0, 1/a, NA)
# ifelse works on vector: examines each entry of the logical vector.
a <- c(0, 1, 2 , -4, 5 )
result <- ifelse(a > 0, 1/a, NA)
# Use ifelse to replace all missing values in a vector with zeros:
data("na_example")
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))
# The function ifelse is useful because you convert a vector of logicals into something else. E.g, some datasets use the number -999 to denote NA. Convert the -999 in a vector to NA using ifelse call:
x <- c(2, 3, -999, 1, 4, 5, -999, 3, 2, 9)
ifelse(x == -999, NA, x)

# nchar(): tells you how many characters long a character vector is.
char_len <- nchar(murders$state)
head(char_len)
# Assign the state abbreviation when the state name is longer than 8 characters: 
ifelse(nchar(murders$state) > 8, murders$abb, murders$state)

# any(): takes a vector of logicals and returns TRUE if any of the entries is TRUE.
# all(): takes a vector of logicals and returns TRUE if all of the entries are TRUE.
z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)
# The expressions is always FALSE when at least one entry of a logical vector x is TRUE.
all(!x)
# Combine with if-else conditionals:
x <- c(1,2,-3,4)
if(all(x>0)){
  print("All Positives")
} else{
  print("Not All Positives")
}

# 4.2 Functions ####

# As you become more experienced, you will need to perform the same operations over and over, e.g, computing the average of vector x by using the sum(x)/length(x). It's more efficient to write a function for this operation.
avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}
x <- 1:100
avg(x)
# R already provides the function mean(x) for computing averages.
identical(mean(x), avg(x)) # returns the same result.
# Variables defined inside a function are not saved in the workspace. While we use s and n when we call avg, the values are created and changed only during the call. In general, functions are objects that are assigned with <-. function() tells R to define a function. 

# Defined functions can have multiple arguments as well as default values. E.g, define a function that computes either the arithmetic or geometric average depending on a user-defined variable:
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x/n), prod(x)^(1/n))
}

# Create function called sum_n that for any given value, say n, creates the vector 1:n, and then computes the sum of the integers from 1 to n:
sum_n <- function(n){
  sum(1:n)
}
# Use the function to determine the sum of integers from 1 to 5000:
sum_n(5000)

# Functions could be defined with multiple variables.
log_plot <- function(x, y){
  plot(log10(x), log10(y))
}
log_plot(100, 200) # This function does not return anything. It just makes a plot.

# Lexical scoping: determines when an object is available by its name. E.g, x is available at different points in the code.
x <- 8
my_func <- function(y){
  x <- 9
  print(x)
  y + x
}
my_func(x)
print(x) # x changed inside the function but not outside.

# 4.3 For-loops ####

# For-loops perform the same task over and over while changing the variable. E.g, write a function to calculate the sum 1 + 2 + 3 +...+ n.
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}
# How can we compute Sn for various values of n, e.g, 25? Do we write 25 lines of code calling compute_s_n? For-loops let us define the range the variable takes, then change the value and evaluate expression as you loop
for(i in 1:5){
  print(i)
}
# Write the for-loop for Sn:
n <- 1:25
s_n <- vector("numeric", 25) # create an empty vector to store data
for(i in n){   
  s_n[i] <- compute_s_n(i)
} # in each iteration n = 1, n = 2, etc..., we compute Sn and store it in the nth entry of s_n.
# Create a plot to search for a pattern:
plot(n, s_n) # the plot appears to be a quadratic, that match the formula 1 + 2 +...+ n = n(n+1)/2.

# Write a function with argument n that for any given n computes the sum of 1 + 2^2 + ...+ n^2.
compute_s_n2 <- function(n){
  n*(n+1)*(2*n+1)/6
}
# Report the value of the sum when n = 10:
compute_s_n2(10)
# Write for-loop:
for(i in n){
  s_n[i] <- compute_s_n2(i)
}
# Check that s_n is identical to the mathematical formula:
identical(s_n, n*(n+1)*(2*n+1)/6)

# 4.4 Vectorization and functionals ####

# Although for-loops are an important concept, they're rarely used in R. Vectorization is actually preferred over for-loops since it results in shorter and clearer code.
# Vectorized function: a function that will apply the same operation on each of the vectors.
x <- 1:10
sqrt(x)
y <- 1:10
x*y # to make these calculations, there's no need for for-loops. However, not all function works element-wise. E.g, compute_s_n is expecting a scalar. 
n <- 1:25
compute_s_n(n) # this doesn't run on each entry of n.

# Functionals: functions that help us apply the same function to each entry in a vector, matrix, data frame, or list. E.g, sapply() permits us to perform element-wise operations on any function.
x <- 1:10
sapply(x, sqrt) # the result is a vector that has the same length.