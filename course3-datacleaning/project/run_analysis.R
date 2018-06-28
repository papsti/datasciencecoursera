## run_analysis.R
## Coursera Data Science Specialization
## Course 3: Getting and Cleaning Data
## Final project
## Author: Irena Papst
##########################################

## Load tidyverse packages
library(tidyverse)

######################
## AGGREGATING DATA ##
######################

## SUBJECT ID

## Load the subject ID number column for each observation
subject_id <- read_table("data/train/subject_train.txt",
                         col_names = FALSE)

## ACTIVITIES

## Load the activity label lookup table (matches numeric activity label
## with descriptive character string -- e.g. 1 = "WALKING")
activity_labels <- read_table("data/activity_labels.txt",
                              col_names = c("id", "name"))

## Load the activity column for each observation
activity <- read_table("data/train/y_train.txt",
                       col_names = FALSE)

## Replace activity numbers with easy to read labels from the
## activity_labels lookup table
activity[] <- activity_labels$name[match(unlist(activity),
                                    activity_labels$id)]

## FEATURES

## Load the column names for the features data
features_labels <- read_table2("data/features.txt",
                               col_names = c("colnum", "feature"))

## Load the features data
features <- read_table("data/train/X_train.txt",
                       col_names = features_labels$feature)

## NEXT: extract only mean and sd features using regex on feature colnames

#############
## SANDBOX ##
#############

## Save R objects for faster loading next time
# save(list=c("subject_id", "activity_labels", "activity",
#             "features_labels", "features"),
#      file = "run_analysis.Rdata")

## Re-load R objects from last session
load("run_analysis.Rdata")
