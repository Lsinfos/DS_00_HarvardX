# SECTION 1: INTRODUCTION TO DATA VISUALIZATION AND DISTRIBUTIONS

# Data visualization provides a powerful way to communicate a data-driven finding. It is the strongest tool for exploratory data analysis (EDA).
# Examine the heights dataset
library(dslabs)
data("heights")
# Extract the variable names from a dataset
names(heights)

# 1. 1 Variable types ####

# Categorical data: variables that are defined by a small number of groups. Categorical data can be divided into 2 groups:
# ordinal: data which have an inherent order to the categories (small/medium/large) and non-ordinal.
# Non-ordinal: data that have no inherent order (male/female)
table(heights$sex) # non-ordinal categorical data

# Numerical data: take a variety of numeric values. Numerical data can be continuous or discrete.
# continuous variables: those that can take any values, such as heights, if measured with enough precision.
heights$height 
# discrete variables: round numbers (population count...etc). Discrete numerical data could be considered categorical or ordinal. E.g, height could be ordinal if it's reported in a small number of values (short, medium, tall). 
# Explore how many unique values are used in the heights variable with unique() function.
height <- heights$height
unique(height)
# Combine with length() to determine how many unique heights 
length(unique(height))

# 1.2 Data distribution ####

# The most basic statistical summary of a list of objects or numbers is its distribution. Once a vector has been summarized as a distribution, there are several data visualization techniques to effectively relay this information. 
# E.g, with categorical data, the distribution simply describes the proportion of each unique category.
table(heights$sex)
# The two-category frequency table is the simplest form of distribution.
prop.table(table(heights$sex)) # no need to visualize since the number already describes everything we need to know.

# When there are more categories, a simple barplot can describe the distribution. Example with the state regions
data("murders")
region <- prop.table(table(murders$region))
barplot(region) # barplots are often used to display a few numbers.

# For continuous numerical data, reporting the frequency of each unique entry is not an effective summary as many or most values are unique. 

# 1.3 Histograms ####

# Histograms are much more preferred to display numerical data. Histogram sacrifices a bit of information to produce plots that are easy to interpret.
hist(heights$height) 
# A histogram divides data into non-overlapping bins of the same size and plots the counts of values that fall in that intervals.E.g, the height data splits the range of values into one inch intervals. Histograms don't distinguish between 60.0, 60.1 and 60.2 inches. Given that these differences are almost unnoticeable to the eye, the practical implications are negligible.  

# 1.4 Normal Distribution ####

# The normal distribution is defined by 2 parameters: the average and the standard deviation.
# Define x as a vector of male heights 
index <- heights$sex == "Male"
x <- heights$height[index]
# Calculate the mean and standard deviation
average <- sum(x)/length(x)
SD <- sqrt(sum((x - average)^2)/length(x))  #SD can be interpreted as the average distance between values and their average.
# Or using the built-in mean() and sd() functions
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

# Standard units: For data that is approximately normal distributed, it is convenient to think in terms of standard units. The standard unit tells how many standard deviations away from the average it is. In R, standard units can be obtained with scale()
z <- scale(x)
# Calculate proportion of values within 2 SD of mean 
mean(abs(z) < 2) # x 95%, which is what the normal distribution predicts.