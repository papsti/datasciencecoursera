## get_files.R
## Coursera Data Science Specialization
## Course 3: Getting and Cleaning Data
## Get necessary files for final project
## Author: Irena Papst
###########################################

## Download and unzip data
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "data.zip"
download.file(the_url, filename,
              method="curl")
system(paste0("unzip ", filename))

## Reorganize files
system("mv UCI\\ HAR\\ Dataset data")
system(paste("rm", filename))