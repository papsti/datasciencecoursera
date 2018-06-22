## Programming Assignment 3
## Author: Irena Papst
##
## Script to test functions written for asst 3

## Clear environment
rm(list=ls())

## Set number of test
## 1: best()
## 2: rankhospital()
## 3: rankall()
## NOTE: each test for rankall() is slow, so only run one at a time;
## specify which (1, 2, or 3) using test_num
fun_to_test <- 3
test_num <- 3

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
if (fun_to_test==1){
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
if (fun_to_test==2){
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
## at a time, hence the second if condition
if (fun_to_test==3){
  source("rankall.R")
  
  if (test_num==1){
    outcome <- "heart attack"
    rank <- 20
    num_disp <- 10
    print(head(rankall(outcome, rank), num_disp))    
  } else if (test_num==2){
    outcome <- "pneumonia"
    rank <- "worst"
    num_disp <- 3
    print(tail(rankall(outcome, rank), num_disp))
  } else if (test_num==3){
    outcome <- "heart failure"
    num_disp <- 10
    print(tail(rankall(outcome), num_disp))
  }
}
