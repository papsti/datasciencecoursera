## R-programming (Coursera)
## Week 2 Programming Assignment
## Author: Irena Papst

## Define function to read one csv for a specified id
read_one_csv <- function(id, directory){
  # Convert list of ids to filenames
  if(id<10){
    filename <- paste0(directory, "/00", id, ".csv")
  } else if(id>=10 & id<100){
    filename <- paste0(directory, "/0", id, ".csv")
  } else {
    filename <- paste0(directory, "/", id, ".csv")
  }
  
  # Read each csv with cols in the correct format
  read.csv(filename, header = TRUE,
           colClasses = c("Date", "numeric",
                          "numeric", "integer"))
}