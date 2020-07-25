# SECTION 1: R BASICS, FUNCTIONS, AND DATA TYPES

# 1.1 Getting started

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