## R-programming (Coursera)
## Week 2 Programming Assignment
## Author: Irena Papst

############
## PART 3 ##
############

## Source necessary functions
source("read_one_csv.R")
source("complete.R")

## Set parameters
# directory <- "specdata"

## Test 1
# threshold <- 150

## Test 2
# threshold <- 5000

## Test 3
# threshold <- 0

## Precompute and save complete cases for al ids
## to increase speed of script
# all_ids <- 1:332
# complete_cases <- complete(directory, all_ids)
# save("complete_cases", file = "complete_cases.Rdata")

## Define corr()
corr <- function(directory, threshold = 0){
  ## directory: (character, len 1) location of .csv files
  
  ## threshold: (numeric, len 1) number of completely observed
  ## observations (on all variables) required to compute the
  ## correlation between nitrate and sulfate
  
  ## Return a numeric vector of correlations
  ## (if none, return numeric vec of length 0)
  
  ## Load precomputed complete cases for speed
  load("complete_cases.Rdata")
  
  ## Define vector of all ids
  all_ids <- 1:332
  
  ## Keep only data for ids where no. complete cases > threshold
  thresh_ids <- all_ids[complete_cases$nobs > threshold]
  
  ## Return early if NO ids have no. complete cases > threshold
  if (length(thresh_ids)==0){
    return(numeric(0))
  } else{
    ## Read data for ids exceeding threshold
    data <- lapply(thresh_ids, read_one_csv,
                   directory = directory)
    
    ## Compute correlation for each monitor ID
    ## and return this as a vector
    correlations <- sapply(seq_along(thresh_ids),
                           function(id){
                             x <- data[[id]]$sulfate
                             y <- data[[id]]$nitrate
                             cor(x, y, use = "complete.obs")
                             # use = "complete.obs" to filter
                             # out NA values
                           },
                           simplify = "vector")
  }
}

## Test corr()
# cr <- corr(directory = directory,
#            threshold = threshold)
# 
# print(head(cr))
# print(summary(cr))
# print(length(cr))
