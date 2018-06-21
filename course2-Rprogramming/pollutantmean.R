## R-programming (Coursera)
## Week 2 Programming Assignment
## Author: Irena Papst

############
## PART 1 ##
############

## Set parameters
directory <- "specdata"

## Test 1
# pollutant <- "sulfate"
# id <- 1:10

# ## Test 2
# pollutant <- "nitrate"
# id <- 70:72
 
# ## Test 3
# pollutant <- "nitrate"
# id <- 23

# pollutant <- "sulfate"
# id <- 34

## Source necessary functions
source("read_one_csv.R")

## Define pollutantmean()
pollutantmean <- function(directory, pollutant,
                          id = 1:332){
  ## directory: (character, len 1) location of .csv files
  
  ## pollutant: (character, len 1) name of pollutant for 
  ## which to calculate the mean ('sulfate' or 'nitrate')
  
  ## id: (integer, len>=1) monitor id numbers to be used  
  
  ## Return the mean of the pollutant across all monitors
  ## listed in the 'id' vector (ignoring NA values)
  
  ## Read data for each station id
  data <- lapply(id, read_one_csv,
                 directory = directory)
  
  ## Simplify above list of data frames into a single dataframe
  data <- do.call(rbind, data)
    
  ## Calculate mean for the specified pollutant
  mean(data[,pollutant], na.rm = TRUE)
}

## Test pollutantmean()
print(pollutantmean(directory = directory,
                    pollutant = pollutant,
                    id = id))