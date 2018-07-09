## run_analysis.R
## Coursera Data Science Specialization
## Course 3: Getting and Cleaning Data
## Final project
## Author: Irena Papst
##########################################

## Load tidyverse packages
library(tidyverse)

################################
## 1. GENERATE FULL TIDY DATA ##
################################

######################

## Define helper functions for aggregate_data() (defined below)
## which get and tidy column names for features data

get_feature_colnames <- function(){
  ## Read feature column names and keep only those with means and
  ## standard deviation of each measurement
  ## Return character vector of column names of interest
  
  ## Get all column names for features data
  features_labels <- read_table2("data/features.txt",
                                 col_names = c("colnum", "feature"))
  all_cols = features_labels$feature
  
  ## Extract only mean and sd features using regex on feature colnames
  mean_cols <- all_cols[grep("mean\\(\\)", all_cols)]
  sd_cols <- all_cols[grep("std\\(\\)", all_cols)]
  
  ## Merge desired colnames in an alternating way 
  ## (so that mean and standard deviation of the same measurement
  ## appear beside each other)
  c(rbind(mean_cols, sd_cols))
}

tidy_feature_colnames <- function(feature_cols){
  ## feature_cols: (string) vector of original column names for
  ## features data
  
  ## Return a tidied vector of column names
  
  ## Remove parentheses from feature column names
  feature_cols <- sub("\\(\\)", "", feature_cols)
  
  ## Change hyphens to underscores in feature column names
  gsub("-", "_", feature_cols)
}

######################

## Define function to aggregate data from the different files
## (works for both the training and test data separately)
aggregate_data <- function(data_type){
  ## data_type: (string) keyword denoting whether data to aggregate
  ## is from the training ("train") or testing ("test") set.

  ## Return a data frame in the following form
  ## subject_id activity  measurement1-mean()-X measurement1-std()-X ...
  ##          1 STANDING              0.2885845           -0.9952786
  ##          1 STANDING              0.2784188           -0.9982453
  ## ...
  ## i.e. a tidy data frame that includes:
  ## * the subject's ID number;
  ## * the activity being performed;
  ## * the mean and standard deviation of each measurement
  
  ## 1. SUBJECT ID
  
  ## Load the subject ID number column for each observation
  subject_id <- read_table(paste0("data/", data_type, "/subject_",
                                  data_type, ".txt"),
                           col_names = "subject_id")
  
  ## 2. ACTIVITIES
  
  ## Load the activity label lookup table (matches numeric activity label
  ## with descriptive character string -- e.g. 1 = "WALKING")
  activity_labels <- read_table("data/activity_labels.txt",
                                col_names = c("id", "name"))
  
  ## Load the activity column for each observation
  activity <- read_table(paste0("data/", data_type,
                                "/y_", data_type, ".txt"),
                         col_names = "activity")
  
  ## Replace activity numbers with easy to read labels from the
  ## activity_labels lookup table (formatted to lowercase and with
  ## quotation marks removed and as factors)
  tidy_labels <- tolower(activity_labels$name[match(unlist(activity),
                                              activity_labels$id)])
  tidy_labels <- sub('\"', '', tidy_labels)
  activity[] <- as.factor(tidy_labels)
  
  ## 3. FEATURES (MEASUREMENTS)
  
  ## Load all column names for features data
  features_labels <- read_table2("data/features.txt",
                                 col_names = c("colnum", "feature"))
  
  ## Load features data
  features <- read_table(paste0("data/", data_type,
                                "/X_", data_type,".txt"),
                         col_names = features_labels$feature)
  
  ## Load the column names of interest for the features data
  ## (means and standard deviations of measurements)
  feature_cols <- get_feature_colnames()
  
  ## Keep only desired feature columns (means and standard dev cols)
  features <- features[,feature_cols]
  
  ## Tidy features colnames
  names(features) <- tidy_feature_colnames(feature_cols)
  
  ## 4. MERGE ALL
  
  ## Join together subject id, activity, and feature measurements and
  ## return this tidy data frame
  cbind(subject_id, activity, features)
}

######################

## Get training and testing data as tidy data frames
training_data <- suppressWarnings(aggregate_data("train"))
testing_data <- suppressWarnings(aggregate_data("test"))

## Merge training and testing data into one tidy data frame
full_tidy_data <- rbind(training_data,testing_data)

####################################
## 2. GENERATE AVERAGED TIDY DATA ##
####################################

## Generate tidy data with the average of each variable
## for each activity and each subject

## Automatically generate arguments for summarize() data
## as a string to parse() and eval() later

## Get tidy feature column names
feature_cols <- tidy_feature_colnames(get_feature_colnames())

## Generate list of mean commands from list of feature cols
mean_commands <- lapply(feature_cols, function(feat){
  paste0("MEAN_", feat, "=mean(", feat,", na.rm=TRUE)")
})

## Collapse mean_commands list into one list of comma separated
## arguments for the summarize function
mean_command <- paste0(mean_commands, collapse = ", ")

## Wrap above list of arguments in the summarize function and add
## commands to preceed which take full_tidy_data, group it by
## activity and subject_id, then summarize to take the mean
## of every other variable in full_tidy_data
summarize_command <- paste0("mean_tidy_data <- full_tidy_data %>% ",
                            "group_by(activity, subject_id) %>% ",
                            "summarise(", mean_command, ")")

## Group data by activity and subject_id
eval(parse(text=summarize_command))

###########################
## 3. CLEAN UP WORKSPACE ##
###########################

## List everyhting in workspace
rm_names <- ls()

## Remove all objects except full tidy data and mean tidy data
rm_names <- rm_names[-which(rm_names=="full_tidy_data"|
                              rm_names=="mean_tidy_data")]
rm(list=c(rm_names))
