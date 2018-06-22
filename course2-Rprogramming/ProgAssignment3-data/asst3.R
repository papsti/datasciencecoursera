## Programming Assignment 3
## Author: Irena Papst
##
## Script to test functions written for asst 3

############
## PART 0 ##
############

# ## Read and inspect data
# outcomedata <- read.csv("outcome-of-care-measures.csv",
#                         colClasses = "character")
# head(outcomedata)
# 
# ## Make a histogram of the 30-day death rates from 
# ## heart attack (col 11)
# outcomedata[, 11] <- as.numeric(outcomedata[, 11])
# hist(outcomedata[, 11])

############
## PART 1 ##
############

## Testing best()
source("best.R")
state <- "TX"
outcome <- "heart attack"
print(best(state, outcome))
