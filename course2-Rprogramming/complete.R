## R-programming (Coursera)
## Week 2 Programming Assignment
## Author: Irena Papst

############
## PART 2 ##
############

## Set parameters
# directory <- "specdata"

## Test 1
# id <- 1

# ## Test 2
# id <- c(2, 4, 8, 10, 12)

# ## Test 3
# id <- 30:25

# ## Test 4
# id <- 3

## Source necessary functions
source("read_one_csv.R")

## Define complete()
complete <- function(directory, id = 1:332){
  ## directory: (character, len 1) location of .csv files
  
  ## id: (integer, len>=1) monitor id numbers to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor id and
  ## 'nobs' is the number of complete cases
  
  ## Read data
  data <- lapply(id, read_one_csv,
                 directory = directory)
  
  ## Count complete cases
  nobs_indx <- lapply(data, complete.cases)
  # get indices that correspond to complete cases
  nobs <- sapply(nobs_indx, sum,
                 simplify="vector")
  # sum over logical vector nobs_indx for count
  # of complete cases
  
  data.frame(id=id, nobs=nobs)
}

## Test complete()
# print(complete(directory = directory, id = id))