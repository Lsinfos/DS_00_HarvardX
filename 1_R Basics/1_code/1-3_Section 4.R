# SECTION 4: PROGRAMMING BASICS

# R is not just a data analysis environment but also a programming language. 3 key programming concepts are: conditional expressions, for-loops, and functions.

# 4.1 Conditional expressions ####

# Conditional expressions are used for what is called flow control.
# If-else statement:
a <- 0
if(a!=0){
  print(1/a)
} else{
  print("No reciprocal for 0.")
}
# Using the US murder data frame
library(dslabs)
data("murders")
murder_rate <- murders$total / murders$population * 100000
# Determine which states have a murder rate lower than 0.5
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5){
  print(murders$state[ind])
} else {
  print("No state has murder rate that low")
}
# If we try again with a rate of 0.25, we get a different answer
if(murder_rate[ind] < 0.25){
  print(murder$state[ind])
} else {
  print ("No state has murder rate that low")
}

# ifelse function: takes 3 arguments (a logical and two possible answers). If the logical is TRUE, the value in the second argument is returned. If FALSE, the value in the third argument is returned.
a <- 0
ifelse(a > 0, 1/a, NA)
# ifelse works on vector: examines each entry of the logical vector a <- c(0, 1, 2 , -4, 5 )
result <- ifelse(a > 0, 1/a, NA)
# Use ifelse to replace all missing values in a vector with zeros
data("na_example")
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))

# any(): takes a vector of logicals and returns TRUE if any of the entries is TRUE.
# all(): takes a vector of logicals and returns TRUE if all of the entries are TRUE.
z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)

# 4.2 Functions ####

# As you become more experienced, you will need to perform the same operations over and over. E.g, commputing the average of vector x by using the sum(x)/length(x). It's more efficient to write a function for this operation
avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}
x <- 1:100
avg(x)
# R already provides the function mean(x) for computing averages
identical(mean(x), avg(x)) #returns the same result.
# Variables defined inside a function are not saved in the workspace. While we use s and n when we call avg, the values are created and changed only during the call. 
# In general, functions are objects that are assigned with <-. Function() tells R to define a function. 

# The defined function can have multiple arguments as well as default values. E.g, define a function that computes either the arithmetic or geometric average depending on a user defined variable
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x/n), prod(x)^(1/n))
}

# 4.3 For-loops ####

# For-loops perform the same task over and over while changing the variable. E.g, write a function to calculate the sum 1 + 2 + 3 +...+ n
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}
# How can we compute Sn for various values of n, e.g, 25? Do we write 25 lines of code calling compute_s_n? For-loops let us define the range the variable takes, then change the value and evaluate expression as you loop
for(i in 1:5){
  print(i)
}
# Write the for-loop for Sn
n <- 25
for(i in 1:n){
  print(compute_s_n(i))
}
# We could also compute Sn and store it in the nth entry of the sum
m <- 25
s_n <- vector(length = m) # create an empty vector
for(n in 1:m){
  s_n[n] <- compute_s_n(n)
} # in each iteration n = 1, n = 2, etc..., we compute Sn and store it in the nth entry of s_n.
# Create a plot to search for a pattern
n <- 1:m
plot(n, s_n) # the plot appeears to be a quadratic, that match the formular 1 + 2 +...+ n = n(n+1)/2.

#4.4 Vectorization and functionals ####

# Although for-loops are an important concept, they're rarely used in R. Vectorization is actually preferred over for-loops since it results in shorter and clearer code.
# Vectorized function: a function that will apply the same operation on each of the vectors.
x <- 1:10
sqrt(x)
y <- 1:10
x*y # to make these calculations, there's no need for for-loops. However, not all function works element-wise. E.g, compute_s_n is expecting a scalar. 
n <- 1:25
compute_s_n(n) # This doesn't run on each entry of n.

# Functionals: funtions that help us apply the same function to each entry in a vector, matrix, data frame, or list. E.g, sapply() permits us to perform element-wise operations on any function
x <- 1:10
sapply(x, sqrt) # the result is a vector that has the same lenght.