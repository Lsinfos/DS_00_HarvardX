# SECTION 1: R BASICS, FUNCTIONS, AND DATA TYPES

# 1.1 Getting started ####

# R was developed by statisticians and data analysts as an interactive environment for data analysis.
# Some of the advantages of R:
# (1) free and open source
# (2) has the capacity to save scripts that could be run and shared across multiplatforms (Windows, Mac OS, Unix, Linux).
# (3) large and growing active R-user community, numerous resources for learning
# (4) it is easy for developers to share software implementation

# Interactive data analysis usually occurs on the R console that executes typed-in commands. E.g, calculate a 15% tip on a meal that costs $19.71
19.71 * 0.15 # 2.96

# RStudio: an interactive, integrated development environment (IDE) is highly recommended to be used as a launching pad for most data science projects (see Cheatsheet RStudio in 03_resources). 

# "Base R" is what comes with the R installation. Additional components are available via packages. R makes it very easy to install packages, e.g, installing the dslabs package:
install.packages("dslabs")
# Once the package is installed, load it using liabry() function
library(dslabs)
# Install packages from RStudio interface: Tools>Install Packages (allows autocomplete)
# Install more than one package by feeding a character vector
install.packages("tidyverse", "dslabs") 
# The tidyverse package is actually several packages (dependencies). Dependencies can be controlled by adding the option "dependencies = TRUE".
# See all the installed packages
installed.packages()
# It is helpful to keep a list of all the needed packages in a script because a newer version of R doesn't re-install them automatically.

# 1.2 The very basics ####

# Object: stuffs that are stored in R. Variables could be defined and used to write expressions similar to maths.
# E.g, solve the quadratic equation: x² + x - 1 = 0. Define variables to calculate the quadratic formular:
a <- 1
b <- 1
c <- -1
# To see the value stored in a variable, simply ask R to evaluate "a" and shows the stored value
a
# A more explicit way to ask R to show the valued store is using print
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

# 1.3 Case Study: US Gun Murders ####
