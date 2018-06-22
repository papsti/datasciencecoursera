## rankall.R
## Author: Irena Papst
##
## Given a health outcome and a desired rank, n, this function
## returns the nth ranked hospital in each state where rank is based
## on the 30-day mortality rate for the specified outcome.
## Rate ties are handled just as in rankhospital.R

## Source rankhospital()
source("rankhospital.R")

rankall <- function(outcome, num = "best"){
  ## outcome: (str) health outcome for which to return best hospital
  ## in state (one of: "heart attack", "heart failure", "pneumonia")
  
  ## num (str or num): ranking of a hospital in that state for that
  ## outcome (based on same ranking rules as in best.R)
  ## Values: "best", "worst", or an integer indicating the ranking
  ## (smaller numbers indicate better hospital)

  ## Returns a data frame in the format
  ## hospital state
  ## "ITHACA"   NY
  ## ...
  ## which means that "ITHACA" is the nth ranked hospital in NY state
  ## If rank > number of hospitals in a particular state, return <NA>
  ## for the hospital name
  
  ## Read data
  outcomedata <- read.csv("outcome-of-care-measures.csv",
                          colClasses = "character")
  
  ## Get list of all states and sort by alphabetical order
  all_states <- unique(outcomedata$State)
  all_states <- all_states[order(all_states)]
  
  ## sapply rankhospital() over list of states and simplify to vector
  rank_hospitals <- sapply(all_states, rankhospital,
                           outcome = outcome,
                           rank = num,
                           simplify = "vector")
  
  ## Make data.frame(hospital, state)
  data.frame(hospital = rank_hospitals,
             state = names(rank_hospitals))
}