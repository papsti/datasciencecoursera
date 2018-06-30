# `run_analysis.R`

The `run_analysis.R` script generates two tidy data sets:
* `full_tidy_data`: accelerometer and gyroscope measurements for participants doing a variety of activities
* `mean_tidy_data`: means of each measurement grouped by activity and subject

All variables of these data sets are described in detail in `CodeBook.md`.

## Helper functions

The script starts by defining two helper functions:

* `get_feature_colnames()` to get original variable (column) names for the measurement (feature) data;
* `tidy_feature_colnames()` to reformat the original feature column names in a way that makes subsequent data analysis easier

## `aggregate_data()`

These helper functions are then called the function `aggregate_data()`, which takes a data "type" (either `"train"` or `"test"`, representing training data or testing data) and returns a tidy data frame.

The function first loads the experimental subject ID data. It then loads both the activity data and an activity lookup table since the activity data is coded using integers. The function replaces the activity codes in the activity data with descriptive names like `"WALKING"` and `"STANDING"` using the lookup table.

Next, the function loads the features (measurements) data, as well as the variable labels. The features data is subset to only include variables that are means and standard deviations of raw measurements. The features data column names are then tidied to be easier to use in subsequent data analysis.

Lastly, the function returns a data frame with the subject ID, activity, and features all together.

## Generate `full_tidy_data`

The script uses the `aggregate_data()` function with the arguments `"train"` and `"test"` to aggregate data for the training and testing data, respectively. It then merges both sets of observations into one tidy data set named `full_tidy_data`.

## Generate `mean_tidy_data`

To generate a second tidy data set with the average of each variable for each activity and each subject, we want to use the `dplyr` library's function `group_by()` to group `full_tidy_data` by `activity` and `subject_id`, and then the function `summarise()` to calculate the mean of each feature variable column.

In order to calculate the mean of each of the 66 feature columns using `summarise()`, we must pass it 66 arguments of the form `MEAN_VARIABLE = mean(VARIABLE)` where `VARIABLE` is the name of a feature column in `full_tidy_data`. Instead of hard-coding these arguments, we can cleverly generate them automatically from the list of feature column names from `full_tidy_data`.

We start by retrieving the tidy feature column names used in `full_tidy_data`. Then we use a paste function to generate a list of statements of the form `MEAN_VARIABLE = mean(VARIABLE)` by looping over the `VARIABLE`s in the list of tidy feature column names. After collapsing this list into one long string of arguments to pass to `summarize`, we paste this string into a string representing a full data pipeline that takes `full_tidy_data`, groups it by `activity` and `subject_id`, then calculates the mean over each feature variable and stores it in its own column. Lastly the script parses this long command string and evaluates it to create `mean_tidy_data`.

## Clean up workspace

Lastly, the script cleans up all objects created, except for `full_tidy_data` and `mean_tidy_data`.
