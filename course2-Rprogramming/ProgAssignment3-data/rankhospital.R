## rankhospital.R
## Author: Irena Papst
##
## Given a state, a health outcome, and a desired rank, this function
## returns the hospital in the state with the 30-day mortality
## for the specified outcome at the given rank

## Load read_sort_data()
source("read_sort_data.R")

rankhospital <- function(state, outcome, rank){
  ## state: (str) 2-character abbreviated name of a state
  
  ## outcome: (str) health outcome for which to return best hospital
  ## in state (one of: "heart attack", "heart failure", "pneumonia")
  
  ## rank (str or num): ranking of a hostpiral in that state for that
  ## outcome (based on same ranking rules as in best.R)
  ## Values: "best", "worst", or an integer indicating the ranking
  ## (smaller numbers are better)
  ## If num > number of hospitals in state (with data for given
  ## outcome), return NA
  
  ## Read and sort data as needed
  outcomedata <- read_sort_data(state, outcome)
  
  ## Get number of observations
  n <- nrow(outcomedata)
  
  ## Convert string arguments to corresponding numeric
  if (rank=="best"){
    rank <- 1
  } else if(rank=="worst"){
    rank <- n
  }
  
  ## If desired rank exceeds number of observations in outcome data,
  ## return NA
  if (rank>nrow(outcomedata)){
    ## If rank exceeds number of observations in outcome data,
    ## return NA
    return(NA)
  }
  
  ## Check validity of arguments
  if (!(rank %in% 1:n)){
    stop("invalid rank")
  }

  ## Return hospital name of that rank
  as.character(outcomedata$hospital[rank])
}