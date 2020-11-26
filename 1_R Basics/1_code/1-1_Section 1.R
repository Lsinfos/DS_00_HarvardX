# SECTION 1: R BASICS, FUNCTIONS, AND DATA TYPES

# 1.1 Getting started ####

# R was developed by statisticians and data analysts as an interactive environment for data analysis.
# Some of the advantages of R:
# (1) free and open source
# (2) has the capacity to save scripts that could be run and shared across multi-platforms (Windows, Mac OS, Unix, Linux).
# (3) large and growing active R-user community, numerous resources for learning
# (4) it is easy for developers to share software implementation.

# Interactive data analysis usually occurs on the R console that executes typed-in commands. E.g, calculate a 15% tip on a meal that costs $19.71
19.71 * 0.15

# RStudio: an interactive, integrated development environment (IDE) is highly recommended to be used as a launching pad for most data science projects. 

# "Base R" is what comes with the R installation. Additional components are available via packages. R makes it very easy to install packages, e.g, installing the dslabs package:
install.packages("dslabs")
# Once the package is installed, load it using liabry() function.
library(dslabs)
# Install packages from RStudio interface: Tools>Install Packages (allows auto-complete)
# Install more than one package by feeding a character vector:
install.packages("tidyverse", "dslabs") 
# The tidyverse package is actually several packages (dependencies). Dependencies can be controlled by adding the option "dependencies = TRUE".
# See all the installed packages:
installed.packages()
# It is helpful to keep a list of all the needed packages in a script because a newer version of R doesn't re-install them automatically.

# 1.2 Case Study: US Gun Murders ####

# The US has a significantly higher number of gun murder cases compared to Europe (see also https://everytownresearch.org/). However, the US is a large and diverse country with 50 very different states. Throughout the exercies we will gain some insights by examining data related to gun homicides in the US in 2010.

# 1.3 The very basics ####

# Object: stuffs that are stored in R. Variables could be defined and used to write expressions similar to maths.
# E.g, solve the quadratic equation: x² + x - 1 = 0. Define variables to calculate the quadratic formular:
a <- 1
b <- 1
c <- -1
# To see the value stored in a variable, simply ask R to evaluate "a" and shows the stored value
a
# A more explicit way to ask R to show the valued store is using print.
print(a)

# Workspace: as we define objects in the console, we are actually change the workspace. See all variables that are saved in the workspace:
ls() # in Rstudio, the Environment tab shows the value.

# Now since the values are saved in variables, obtain the solution to the equation by using the quadratic formula:
(-b + sqrt(b^2 - 4*a*c))/(2*a)
(-b - sqrt(b^2 - 4*a*c))/(2*a)

# Functions: once variables are defined, the data analysis process can usually be described as a series of functions applied to the data.
log(8)
log(a) 
# Argument: unlike ls(), most functions require one ore more inputs that called arguments. 
# Find out what the function expects and what it does by reviewing R manuals
help("log")
?("log") # shortcut for most functions.
# Have a quick look at the arguments without opening the manual
args(log)
# Change the default value by simply assigning another object:
log(8, base = 2)
log(8, 2) # if no argument name is used, R assumes entered arguments in the order shown in the help file.
# Nested function: evaluate a function inside another function
sqrt(log2(16)) # calculate the log to the base 2 of 16 then compute the square root of that value.

# prebuilt datasets: datasets that are included in Base R to practice and test out functions. View all the datasets:
data() 
# These datasets are objects that can be used by simply typing the name. E.g:
co2 # Mauna Loa Atmospheric CO2 Concentration
# Other prebuilt objects are mathematical quantities, such as the constant π and ∞:
pi
Inf + 1

# Variable names: have to start with a letter, can’t contain spaces, and should not be variables that are predefined in R
solution_1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
solution_2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)
# Values remain in the workspace until the session is ended or being erase with rm()
rm(solution_1)

# Formular for computing the sum of the first 20 integers
20*(20+1)/2
# However, we can define a variable to use the formular for other values of n
n <- 20
n*(n+1)/2
# Compute the sum of the first 100 integers using the formular
n <- 100
n*(n+1)/2

# 1.4 Data Types ####

# Variables in R can be of different types. Determine what type of object by using class() function
class(a) # numeric

# Data frame: a table with rows representing observations and the different variables reported for each observation defining the columns. Data frames are the most common way of storing a dataset in R. Data frames are particularly useful for datasets because different types of data could be combined into one object.
# A large portion of data analysis challenges start with data stored in a data frame. E.g, the data for the study case of US Gun Murders is stored in a data frame. Access this by loading dslabs library and the murders dataset.
library(dslabs)
data("murders")
# See if this is in fact a data frame
class(murders)

# Examine an object: finding more about the structure of an object
str(murders)
# Show the first lines using head() function
head(murders)
# The str() function reveals the names for each variables stored in this table. Quickly access these names using the name() function
names(murders)

# The accessor $: access variables represented by columns in the data frame
murders$population
# There are multiple ways to access variables in a data frame, using accessor or double square brackets []
pop <- murders$population
pop2 <- murders[["population"]]
# Confirm these two variables are the same
identical(pop, pop2)

# Vectors: the object murders$population is not one but several. These types of objects are called vectors. A single number is technically a vector of length 1. Use length() function to tell how many entries in the vector:
length(pop) # 51
class(pop) # This particular vector is numeric, since population sizes are numbers.
# To store character strings, vectors can also be of class "characters"
class(murders$state)
# Another important type of vectors are logical vectors. These must be either TRUE or FALSE
z <- 3 == 2 # evaluate if number 3 is equal to number 2.
z # FALSE
class(z) # "logical"

# Factors: factors are useful for storing categorical data. We might expect the "region" in the dataset is also a character vector. However, it is a factor 
class(murders$region)
# There are only 4 categories. Obtain these categories by levels()
levels(murders$region)
# Determine the number of regions included
length(levels(murders$region))
# The default order of the levels is the alphabeitical order. Use reorder() function to change the order of the levels of a factor variable based on a summary computed on a numeric vector
region <- murders$region
value <- murders$total
region <- reorder(region, value, FUN = sum)
levels(region) # the new order is in agreement with the fact that the Northeast has the least murders and the South has the most.
# Use levels() and length() function to determine the number of regions defined by this dataset
length(levels(murders$region)) # length 4
# table() function takes a vector and returns the frequency of each element
table(murders$region)

# Lists: data frames are a special case of list. Lists are useful because you can combine any combination of different types
record <- list(name = "John Doe", 
               student_id = 1234, 
               grades = c(95, 82, 91, 97, 93),
               final_grade = "A")
class(record)
# As with data frames, components of a list could be extracted with the accessor $ (data frame is a type of list)
record$student_id
# or using double square brackets [[]]
record[["name"]] 

# Matrices: two-dimensional like data frames, but entries to matrices have to be the same type.
mat <- matrix(1:12, 4, 3)
# Access a specific entries using square bracket []
mat[2, 3]
mat[2, ] # select the entire second row.
mat[ ,3] # select the entire third column.
mat[ ,2:3] # access more than one row or column.
# Convert matrices into data frames
as.data.frame(mat)
# You can also use the square bracket to access rows and columns of a data frame
murders[25,1]
murders[2:3,]

# table(): takes a vector as an input and returns the frequency of each unique element in the vector
table(murders$region)