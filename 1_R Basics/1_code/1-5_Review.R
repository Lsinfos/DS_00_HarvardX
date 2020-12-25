# REVIEW R BASICS

# 5.1 the "heights" dataset ####
# Load the "heights" dataset from dslabs:
library(dslabs)
data(heights)
options(digits = 3) # report 3 significant digits for all answers.

# See the structure of this dataset:
str(heights)
# Determine the average height:
mean(heights$height)
# Create a logical index for those individuals who are above average:
ind <- heights$height > mean(heights$height)
# How many individuals in the dataset are above average height?
sum(ind) 
# How many individuals in the dataset are above average height and are female?
sum(ind & heights$sex == "Female") 
# What proportion of individuals in the dataset are female?
mean(heights$sex == "Female")
# Determine the minimum height in the heights dataset.
min(heights$height)

# Use the match() function to determine the index of the first individual with the minimum height.
match(50,heights$height)
# Subset the sex column of the dataset to determine the individual’s sex.
heights$sex[match(50,heights$height)]

# Determine the maximum height.
max(heights$height)
# Which integer values are between the maximum and minimum heights?
x <- 50:82
x
# How many of the integers in x are NOT heights in the dataset?
sum(!(x %in% heights$height))

# Create a new column of heights in centimeters named ht_cm:
heights2 <- mutate(heights, ht_cm = height * 2.54)
# What is the height in centimeters of the 18th individual?
heights2$ht_cm[18]
# What is the mean height in centimeters?
mean(heights2$ht_cm)

# Create a data frame females by filtering the heights2 data to contain only female individuals.
females <- filter(heights2, sex == "Female")
# To determine the number of individuals in the new dataset, we count the rows:
nrow(females)
# What is the mean height of the females in centimeters?
mean(females$ht_cm)

# Another method for aggregating is using the  dplyr package: 
library(dplyr)
# Group the dataset into two sexes and summarize:
heights %>% group_by(sex) %>%
  summarize(average = mean(height), 
            standard_deviation = st(height))
# Or filter the data for the group of female only:
heights %>% filter(sex == "Female") %>%
  summarize(average = mean(height), 
            standard_deviation = sd(height))

# 5.2 The "olive" dataset ####
# Load the "olive" dataset and examine:
data(olive)
head(olive)

# Plot the percent palmitic acid versus palmitoleic acid in a scatter plot:
plot(olive$palmitic, olive$palmitoleic) # positive relationship.
# Create a histogram of the percentage of eicosenoic acid in olive:
hist(olive$eicosenoic) # the most common value of eicosenoic acid is below 0.05%.
# Make a boxplot of palmitic acid percentage in olive with separate distributions for each region.
boxplot(palmitic ~ region, data = olive)

# 5.3 The NHANES dataset ####
# Install and load the NHANES package:
install.packages("NHANES")
library(NHANES)
data(NHANES)
# Explore the NHANES data:
str(NHANES)
# The NHANES data has many missing values. 
sum(is.na(NHANES))
# AgeDecade is a categorical variable with different groups of ages. Select a subset of 20-to-29-year-old females:
NHANES %>% filter(AgeDecade == " 20-29", na.rm = TRUE) # note that there is a space in front of 20-29.
# BPSysAve contains information of the blood pressure. Compute the average and standard deviation of systolic blood pressure, using the na.rm = TRUE to ignore the NAs:
NHANES %>% filter(AgeDecade == " 20-29", na.rm = TRUE) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE),
            standard_deviation = sd(BPSysAve, na.rm = TRUE))
# Compute the average and standard deviation for females, but for each age group separately:
NHANES %>% filter(Gender == "female") %>%
  group_by(AgeDecade, na.rm = TRUE) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE),
            standard_deviation = sd(BPSysAve, na.rm = TRUE))
# Compare systolic blood pressure across race for males between the ages of 40-49:
NHANES %>% filter(Gender == "male", 
                  AgeDecade == " 40-49") %>%
  group_by(Race1) %>% 
  summarize(average = mean(BPSysAve, na.rm = TRUE)) %>%
  arrange(average)