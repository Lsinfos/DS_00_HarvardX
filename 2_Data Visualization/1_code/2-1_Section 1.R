# SECTION 1: INTRODUCTION TO DATA VISUALIZATION AND DISTRIBUTIONS

# Data visualization provides a powerful way to communicate a data-driven finding. It is the strongest tool for exploratory data analysis (EDA). We'll use ggplot2 from tidyverse package:
library(tidyverse)
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

# 1.3 Cumulative Distribution Functions ####

# When summarizing a list of numeric values, such as heights, it is not useful to construct a distribution that defines a proportion to each possible outcome.
# A more useful way to define a distribution for numeric data is to define a function that reports the proportion of the data below a for all possible values of a. This function is called the cumulative distribution function (CDF): F(a)=Pr(x≤a)
# eCDF: empirical CDF, because CDFs can be defined mathematically the word empirical is added to make the distinction when data is used. 
# E.g, define the height distribution for adult male students
x <- heights %>%
  filter(sex=="Male") %>% 
  pull(height)
# Calculate eCDF
ecdf_x <- ecdf(x)
# Plot the eCDF values
plot(ecdf_x)

# Or using ggplot by first subsetting a data frame just for the height of male students
Male <- heights %>% 
  filter(sex == "Male") 
ggplot(Male, aes(height)) +
  stat_ecdf(geom = "step")
# Similar to what the frequency table does for categorical data, the CDF defines the distribution for numerical data. From the plot, we can see that 16% of the values are below 65, since F(66)= 0.164, or that 84% of the values are below 72, since F(72)= 0.841, and so on.

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

# 1.5 The normal CDF and pnorm ####

# The normal distribution has a mathematically defined CDF which can be computed in R with the function pnorm(). A random quantity is normally distributed with average m and standard deviation s if its probability distribution is defined by:
F(a) = pnorm(a, m, s) 

# We can estimate the probability that a male is taller than 70.5 inches with:
1 - pnorm(70.5, mean(x), sd(x)) # This is useful because if we are willing to use the normal approximation for, say, height, we don’t need the entire dataset to answer questions such as: what is the probability that a randomly selected student is taller then 70 inches? We just need the average height and standard deviation.

# Data is always, technically, discrete. E.g, if we consider the height data categorical with each specific height a unique category. The probability distribution is defined by the proportion of students reporting each height. Plot that probability distribution
plot(prop.table(table(x)), xlab = "a = Height in inches", ylab = "Pr(x = a)")
# With continuous distributions, the probability of a singular value is not even defined. E.g, it does not make sense to ask what is the probability that a normally distributed value is 70. Instead, we define probabilities for intervals, e.g, what is the probability that someone is between 69.5 and 70.5?
# In cases like height, in which the data is rounded, the normal approximation is particularly useful if we deal with intervals that include exactly one round number. 
mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)
# Probabilities in normal approximation match well
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(68.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5, mean(x), sd(x))
# However, the approximation is not as useful for other intervals
mean(x <= 70.9) - mean(x<=70.1)
pnorm(70.9, mean(x), sd(x)) - pnorm(70.1, mean(x), sd(x))
# This situation is called discretization. Although the true height distribution is continuous, the reported heights tend to be more common at discrete values, in this case, due to rounding. 

# 1.6 Histograms ####

# Histograms are much more preferred to display numerical data. Histogram sacrifices a bit of information to produce plots that are easy to interpret.
hist(heights$height) 
# A histogram divides data into non-overlapping bins of the same size and plots the counts of values that fall in that intervals.E.g, the height data splits the range of values into one inch intervals. Histograms don't distinguish between 60.0, 60.1 and 60.2 inches. Given that these differences are almost unnoticeable to the eye, the practical implications are negligible.  
