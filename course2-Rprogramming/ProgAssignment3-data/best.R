## best.R
## Author: Irena Papst
##
## Given a state and a health outcome, this function returns the
## hospital in the state with the best (i.e. lowest) 30-day mortality
## for the specified outcome

## Load read_sort_data()
source("read_sort_data.R")

best <- function(state, outcome){
  ## state: (str) 2-character abbreviated name of a state
  
  ## outcome: (str) health outcome for which to return best hospital
  ## in state (one of: "heart attack", "heart failure", "pneumonia")
  
  ## Returns the name of the best hospital in the given state for
  ## that particular outcome based on having the lowest 30-day death
  ## rate. In the case of a tie, return the first hospital by
  ## alphabetical order.
  
  ## Read and sort data as needed
  outcomedata <- read_sort_data(state, outcome)
  
  ## Return top entry of sorted data and convert to string to avoid
  ## printout of all factors in that column
  as.character(outcomedata$hospital[1])
}