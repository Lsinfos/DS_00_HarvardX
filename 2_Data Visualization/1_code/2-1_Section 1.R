# SECTION 1: INTRODUCTION TO DATA VISUALIZATION AND DISTRIBUTIONS

# Data visualization provides a powerful way to communicate a data-driven finding. It is the strongest tool for exploratory data analysis (EDA). We'll use ggplot2 from tidyverse package:
library(tidyverse)
# Examine the heights dataset
library(dslabs)
data("heights")
# Extract the variable names from a dataset
names(heights)

# 1.1 Variable types ####
# Categorical data: variables that are defined by a small number of groups. Categorical data can be divided into 2 groups:
# ordinal: data which have an inherent order to the categories (small/medium/large) and non-ordinal.
# Non-ordinal: data that have no inherent order (male/female)
heights$sex # non-ordinal categorical data
# Numerical data: take a variety of numeric values. Numerical data can be continuous or discrete.
# continuous variables: those that can take any values, such as heights, if measured with enough precision.
heights$height 
# discrete variables: round numbers (population count...etc). Discrete numerical data could be considered categorical or ordinal. E.g, height could be ordinal if it's reported in a small number of values (short, medium, tall). 
# Explore how many unique values are used in the heights variable with unique() function.
unique(heights$height)
# Combine with length() to determine how many unique heights 
length(unique(heights$height))

# 1.2 Data distribution ####
# The most basic statistical summary of a list of objects or numbers is its distribution. Once a vector has been summarized as a distribution, there are several data visualization techniques to effectively relay this information. 
# E.g, with categorical data, the distribution simply describes the proportion of each unique category.
table(heights$sex)
# The two-category frequency table is the simplest form of distribution.
prop.table(table(heights$sex)) # no need to visualize since the number already describes everything we need to know.
# Compute the frequencies of each unique height value:
tab <- table(heights$height) # reports the number of times each unique value appears.
# For values reported only once tab will be 1. Use logicals and the function sum to count the number of times this happens.
sum(tab == 1) # treating the reported heights as an ordinal value is not useful.
# When there are more categories, a simple barplot can describe the distribution. 
data("murders")
region <- prop.table(table(murders$region))
ggplot(murders, aes(region, fill = region)) + geom_bar() # barplots are often used to display a few numbers.

# 1.3 Cumulative Distribution Functions ####
# When data is not categorical, reporting the frequency of each unique entry is not an effective summary. E.g, while several students reporte a height of 68 inches, it is actually 68.504 and 68.898 converted from 174 to 175 cm respectively.
# A more useful way to define a distribution for numeric data is to define a function that reports the proportion of the data below "a" for all possible values of "a". This function is called the cumulative distribution function (CDF): F(a)=Pr(x≤a)
# eCDF: empirical CDF, because CDFs can be defined mathematically the word empirical is added to make the distinction when data is used. 
# Use ggplot with stat_ecdf to plot the distribution of the male students' height.
Male <- heights %>% # subset the male students.
  filter(sex == "Male") 
ggplot(Male, aes(height)) +
  stat_ecdf(geom = "step")
# Similar to what the frequency table does for categorical data, the CDF defines the distribution for numerical data. From the plot, we can see that 14% of the students in the class have heights below 66 inches. 84% of the students have heights below 72 inches.
# For datasets that are not normal, the CDF can be calculated manually by defining a function.
a <- seq(min(heights$height), max(heights$height), 
         length = 100) # define range of values spanning the dataset
cdf_function <- function(x) { # probability for a single value.
  mean(heights$height <= x)
}
cdf_values <- sapply(a, cdf_function)
plot(a, cdf_values)
# To define the proportion of values above  "a" , we compute:
1 - F(a)
#  To define the proportion of values between "a" and "b", we compute: 
F(b) - F(a)
# CDF can help compute probabilities. The probability of observing a randomly chosen value between "a" and  "b" is equal to the proportion of values between "a" and "b", which we compute with the CDF.

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
# Although CDF is a common method in statistics that provides all the information needed, its plot is not very popular in practice. It doesn't convey easily characteristics of interest, such as at what value is the distribution centered, is the distribution symmetric, what range contains 95% data. Histograms are much more preferred to display numerical data. Histogram sacrifices a bit of information to produce plots that are easy to interpret.
ggplot(heights, aes(height)) + geom_histogram() # easily see the majority of male students are between 63 and 75 inches.
# A histogram divides data into non-overlapping bins of the same size and plots the counts of values that fall in that intervals.E.g, the height data splits the range of values into one inch intervals. Histograms don't distinguish between 60.0, 60.1 and 60.2 inches. Given that these differences are almost unnoticeable to the eye, the practical implications are negligible.  