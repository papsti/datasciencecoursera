read_sort_data <- function(state, outcome){
  ## state: (str) 2-character abbreviated name of a state
  
  ## outcome: (str) health outcome for which to return best hospital
  ## in state (one of: "heart attack", "heart failure", "pneumonia")
  
  ## Returns a data frame in the format
  ## hospital rate
  ## "ITHACA"     2.3
  ## ...
  ## for the given state and given outcome's 30-day death rate
  ## sorted first by rate (ascending) and then by alphabetical order
  ## on the hospital name.
  
  ## Read data
  outcomedata <- read.csv("outcome-of-care-measures.csv",
                          colClasses = "character")
  
  ## Check validity of variables before proceeding
  if (!(state %in% outcomedata$State)){
    ## if state provided is not found in list of states, stop
    stop("invalid state")
  }
  if (!(outcome %in%
        c("heart attack", "heart failure", "pneumonia"))){
    ## if outcome provided is not one of the three above strings
    stop("invalid outcome")
    
  }
  
  ## Get column index for the specific outcome we're looking for
  if (outcome=="heart attack"){
    outcomeindx <- 11
  } else if (outcome=="heart failure"){
    outcomeindx <- 17
  } else { # outcome = "pneumonia"
    outcomeindx <- 23
  }
  
  ## Subset data to only include what's needed & rename cols to
  ## be easier to handle
  ## Convert outcome column to numeric to identify all missing data
  ## as NAs so that we can use complete.cases() to filter those out
  ## Supress warnings about coercing NAs in outcome column (this is
  ## what we want to happen)
  outcomedata <- suppressWarnings(
    data.frame(hospital = outcomedata[,2],
               state = outcomedata[,7],
               rate = as.numeric(
                 outcomedata[, outcomeindx])))
  
  ## Only keep observations corresponding to selected state
  outcomedata <- outcomedata[outcomedata$state %in% state,]
  
  ## Get rid of state column (no longer needed)
  outcomedata <- outcomedata[,c("hospital", "rate")]
  
  ## Keep only complete cases
  outcomedata <- outcomedata[complete.cases(outcomedata),]
  
  ## Sort by lowest outcome,
  ## then by alphabetical order on hospital name
  outcomedata <- outcomedata[with(outcomedata,
                                  order(rate, hospital)),]
}