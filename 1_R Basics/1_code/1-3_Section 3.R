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
# Check how many states have murder rate below avarage
sum(murder_rate < mean(murder_rate))

# Logical operators: make two logicals true only when they are both true. Suppose you want to move to a safe state with the murder rate to be at most 1 in western region:
west <- murders$region == "West"
safe <- murder_rate <= 1
# Use "&" to get a vector of logicals that tells which states satisfy both conditions
ind <- safe & west
murders$state[ind] # 5 states meet this condition.

# which: tells which entries of a logical vector are TRUE. E.g, we want to look up California's murder rate. For this type of operation, it's convenient to convert vectors of logical into indexes instead of keeping long vectors of logicals.
ind <- which(murders$state == "California")
murder_rate[ind]
# Get the indices of entries that are below 1
which(murder_rate < 1)
# Names of states with murder rates lower than 1
murders$state[murder_rate < 1]

# match: tells which indexes of a second vector match each of the entries of a first vector. Instead of just one state we could find out the murder rate of several states
ind <- match(c("New York", "Florida", "Texas"), murders$state)
murder_rate[ind]
# Identify the states with abbreviations AK, MI, and IA
ind <- match(c("AK", "MI", "IA"), murders$abb)
murders$state[ind]

# %in%: tells whether or not each element of a first vector is in a second vector. E.g, find out if Boston, Dakota and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state
# These two lines produce the same index, although in different order:
match(c("New York", "Florida", "Texas"), murders$state)
which(murders$state %in% c("New York", "Florida", "Texas"))

# 3.2 Basic Data Wrangling ####

# For more advanced analyses, we use dplyr package to manipulate data tables. Install and load dplyr
install.packages("dplyr")
library(dplyr)
# Add the murder rate to the data frame with mutate() function
murders <- mutate(murders, rate = total/population*100000) # "total" and "population" are not defined in the workspace, but mutate() knows to look for these variables in the data frame. 
# Check the data frame again
head(murders) # a new column "rate" is added.

# filter(): takes the data table as the first argument and the conditional statement as the next. Filter the data table to only show the entries for which murder rate is lower than 0.71:
filter(murders, rate <= 0.71)
# Show the top 5 states with the highest murder rates
murders <- mutate(murders, rank = rank(-rate))
filter(murders, rank <= 5)
# filter with !=
no_south <- filter(murders, region != "South")
# Use nrow() to calculate the number of states in this category
nrow(no_south)

# select(): select just the columns you want to work with
new_table <- select(murders, state, region, rate)
# Filter the new table with entries that have murder rate lower than 0.71
filter(new_table, rate <= 0.71) # first argument is an object.
# Create a table, call it my_states, that satisfies both the conditions: it is in the Northeast or West and the murder rate is less than 1. 
my_states <- filter(murders, region %in% c("Northeast","West") & rate < 1)
select(my_states, state, rate, rank)

# Pipe operator (%>%): performs a series of operations in dplyr by sending the results of one function to another function
murders %>% select(state, region, rate) %>% filter(rate <= 0.71) # same result as the previous code.
# Use one line of code to create a new data frame
my_states <- murders %>% mutate(rate = total/population*100000, rank = rank(-rate)) %>%
  filter(region %in% c("Northeast", "West") & rate < 1) %>%
  select(state, rate, rank)

# data.frame(): create a data frame. E.g,
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"),
                     exam_1 = c(95, 80, 90, 85),
                     exam_2 = c(90, 85, 85, 90))
# Define a variable to determine the population size ranks
ranks <- rank(pop)
# Create a data frame with the state name and its rank
data.frame(murders$state, ranks)
# Order the data frame and its rank from least to most populous
ind <- order(pop)
data.frame(murders$state[ind], ranks[ind])

# 3.3 Basic Plots ####

# plot(): can be used to make a scattered plot. Make a plot of total murders vs. population
x <- murders$population/10^6
y <- murders$total
plot(x, y)
# For quick plot that avoids accessing variables twice, use with()
with(murders, plot(population, total))
# Transform the variables using the log base 10 transformation
plot(log10(x), log10(y))

# Create a histogram
x <- with(murders, total/population*100000)
hist(x) # the plot shows there's a wide range of values with most of them between 2 and 3 and one very extreme case with a murder rate of more than 15
murders$state[which.max(x)] # "District of Columbia"

# Create a boxplot
murders$rate <- with(murders, total/population*100000)
boxplot(rate~region, data = murders) # the plot shows the South has higher murder rate than other regions.

# image(): displays the values in a matrix using color
x <- matrix(1:120, 12, 10)
image(x)