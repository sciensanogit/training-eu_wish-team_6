############################################################################### #
# Aim ----
#| generating wastewater reports
# Requires: 
# NOTES:
#| git cheat: git status, git add -A, git commit -m "", git push, git pull, git restore
#|
############################################################################### #

# Load packages ----
# select packages
pkgs <- c("dplyr", "ggplot2")
# install packages
install.packages(setdiff(pkgs, rownames(installed.packages())))
invisible(lapply(pkgs, FUN = library, character.only = TRUE))


# Mission 1.1 ----
## Source member 1 script ----
source("mission1-JK.R")

## Source member 2 script ----
source("mission1-PL.R")

## Source member 3 script ----
source("mission1-purkrtos.R")

## Source member 4 script ----
source("mission1-CO.R")

## Source member 5 script ----
#source("mission1-member1.R") #placeholder for Martine's file