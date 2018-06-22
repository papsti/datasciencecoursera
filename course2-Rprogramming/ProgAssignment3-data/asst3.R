## Programming Assignment 3
## Author: Irena Papst
##
## Script to test functions written for asst 3

## Set number of test
## 1: best()
## 2: rankhospital()
## 3: rankall()
test <- 3

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
if (test==1){
  source("best.R")
  state <- "TX"
  outcome <- "heart attack"
  print(best(state, outcome))
  state <- "TX"
  outcome <- "heart failure"
  print(best(state, outcome))
  state <- "MD"
  outcome <- "heart attack"
  print(best(state, outcome))
  state <- "MD"
  outcome <- "pneumonia"
  print(best(state, outcome))
  state <- "BB"
  outcome <- "heart attack"
  try(print(best(state, outcome)))
  state <- "NY"
  outcome <- "hert attack"
  try(print(best(state, outcome)))
}

############
## PART 2 ##
############

## Testing rankhospital()
if (test==2){
  source("rankhospital.R")
  state <- "TX"
  outcome <- "heart failure"
  rank <- 4
  print(rankhospital(state, outcome, rank))
  state <- "MD"
  outcome <- "heart attack"
  rank <- "worst"
  print(rankhospital(state, outcome, rank))
  state <- "MN"
  outcome <- "heart attack"
  rank <- 5000
  print(rankhospital(state, outcome, rank))
}

############
## PART 3 ##
############

## Testing rankall()
## NOTE: each test of rankall() takes a while so better off doing one
## at a time (comment all other lines out)
if (test==3){
  source("rankall.R")
  
  # outcome <- "heart attack"
  # rank <- 20
  # num_disp <- 10
  # print(head(rankall(outcome, rank), num_disp))
  
  # outcome <- "pneumonia"
  # rank <- "worst"
  # num_disp <- 3
  # print(tail(rankall(outcome, rank), num_disp))
  
  outcome <- "heart failure"
  num_disp <- 10
  print(tail(rankall(outcome), num_disp))
}
