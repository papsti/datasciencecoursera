# CODE BOOK

# `run_analysis.R`

`run_analysis.R` generates two data frames:
* `full_tidy_data`
* `mean_tidy_data`

## `full_tidy_data`

### Variables

`full_tidy_data` is a `data.frame` object with 10299 observations of 68 variables, including:

* `subject_id`: (integer) the ID number of the experimental subject
* `activity`: (factor) name of the activity being performed (options include: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING\_DOWNSTAIRS", "WALKING\_UPSTAIRS")

* `tBodyAcc_mean_X`: (numeric) mean of the time domain body acceleration signal in the X direction
* `tBodyAcc_std_X`: (numeric) standard deviation of the time domain body acceleration signal in the X direction
* `tBodyAcc_mean_Y`: (numeric) mean of the time domain body acceleration signal in the Y direction
* `tBodyAcc_std_Y`: (numeric) standard deviation of the time domain body acceleration signal in the Y direction
* `tBodyAcc_mean_Z`: (numeric) mean of the time domain body acceleration signal in the Z direction
* `tBodyAcc_std_Z`: (numeric) standard deviation of the time domain body acceleration signal in the Z direction

* `tGravityAcc_mean_X`: (numeric) mean of the time domain gravity acceleration signal in the X direction
* `tGravityAcc_std_X`: (numeric) standard deviation of the time domain gravity acceleration signal in the X direction
* `tGravityAcc_mean_Y`: (numeric) mean of the time domain gravity acceleration signal in the Y direction
* `tGravityAcc_std_Y`: (numeric) standard deviation of the time domain gravity acceleration signal in the Y direction
* `tGravityAcc_mean_Z`: (numeric) mean of the time domain gravity acceleration signal in the Z direction
* `tGravityAcc_std_Z`: (numeric) standard deviation of the time domain gravity acceleration signal in the Z direction

* `tBodyAccJerk_mean_X`: (numeric) mean of the time domain body acceleration jerk signal in the X direction
* `tBodyAccJerk_std_X`: (numeric) standard deviation of the time domain body acceleration jerk signal in the X direction
* `tBodyAccJerk_mean_Y`: (numeric) mean of the time domain body acceleration jerk signal in the Y direction
* `tBodyAccJerk_std_Y`: (numeric) standard deviation of the time domain body acceleration jerk signal in the Y direction
* `tBodyAccJerk_mean_Z`: (numeric) mean of the time domain body acceleration jerk signal in the Z direction
* `tBodyAccJerk_std_Z`: (numeric) standard deviation of the time domain body acceleration jerk signal in the Z direction

* `tBodyGyro_mean_X`: (numeric) mean of the time domain body gyro signal in the X direction
* `tBodyGyro_std_X`: (numeric) standard deviation of the time domain body gyro signal in the X direction
* `tBodyGyro_mean_Y`: (numeric) mean of the time domain body gyro signal in the Y direction
* `tBodyGyro_std_Y`: (numeric) standard deviation of the time domain body gyro signal in the Y direction
* `tBodyGyro_mean_Z`: (numeric) mean of the time domain body gyro signal in the Z direction
* `tBodyGyro_std_Z`: (numeric) standard deviation of the time domain body signal in the Z direction

* `tBodyGyroJerk_mean_X`: (numeric) mean of the time domain body gyro jerk signal in the X direction
* `tBodyGyroJerk_std_X`: (numeric) standard deviation of the time domain body gyro jerk signal in the X direction
* `tBodyGyroJerk_mean_Y`: (numeric) mean of the time domain body gyro jerk signal in the Y direction
* `tBodyGyroJerk_std_Y`: (numeric) standard deviation of the time domain body gyro jerk signal in the Y direction
* `tBodyGyroJerk_mean_Z`: (numeric) mean of the time domain body gyro jerk signal in the Z direction
* `tBodyGyroJerk_std_Z`: (numeric) standard deviation of the time domain body gyro jerk signal in the Z direction

* `tBodyAccMag_mean`: (numeric) mean of the time domain body acceleration magnitude
* `tBodyAccMag_std`: (numeric) standard deviation of the time domain body acceleration magnitude

* `tGravityAccMag_mean`: (numeric) mean of the time domain gravity acceleration magnitude
* `tGravityAccMag_std`: (numeric) standard deviation of the time domain gravity acceleration magnitude

* `tBodyAccJerkMag_mean`: (numeric) mean of the time domain body acceleration jerk magnitude
* `tBodyAccJerkMag_std`: (numeric) standard deviation of the time domain body acceleration jerk magnitude

* `tBodyGyroMag_mean`: (numeric) mean of the time domain body gyro magnitude
* `tBodyGyroMag_std`: (numeric) standard deviation of the time domain body gyro magnitude

* `tBodyGyroJerkMag_mean`: (numeric) mean of the time domain body gyro jerk magnitude
* `tBodyGyroJerkMag_std`: (numeric) standard deviation of the time domain body gyro jerk magnitude

* `fBodyAcc_mean_X`: (numeric) mean of the frequency domain body acceleration signal in the X direction
* `fBodyAcc_std_X`: (numeric) standard deviation of the frequency domain body acceleration signal in the X direction
* `fBodyAcc_mean_Y`: (numeric) mean of the frequency domain body acceleration signal in the Y direction
* `fBodyAcc_std_Y`: (numeric) standard deviation of the frequency domain body acceleration signal in the Y direction
* `fBodyAcc_mean_Z`: (numeric) mean of the frequency domain body acceleration signal in the Z direction
* `fBodyAcc_std_Z`: (numeric) standard deviation of the frequency domain body acceleration signal in the Z direction

* `fBodyAccJerk_mean_X`: (numeric) mean of the frequency domain body acceleration jerk signal in the X direction
* `fBodyAccJerk_std_X`: (numeric) standard deviation of the frequency domain body acceleration jerk signal in the X direction
* `fBodyAccJerk_mean_Y`: (numeric) mean of the frequency domain body acceleration jerk signal in the Y direction
* `fBodyAccJerk_std_Y`: (numeric) standard deviation of the frequency domain body acceleration jerk signal in the Y direction
* `fBodyAccJerk_mean_Z`: (numeric) mean of the frequency domain body acceleration jerk signal in the Z direction
* `fBodyAccJerk_std_Z`: (numeric) standard deviation of the frequency domain body acceleration jerk signal in the Z direction

* `fBodyGyro_mean_X`: (numeric) mean of the frequency domain body gyro signal in the X direction
* `fBodyGyro_std_X`: (numeric) standard deviation of the frequency domain body gyro signal in the X direction
* `fBodyGyro_mean_Y`: (numeric) mean of the frequency domain body gyro signal in the Y direction
* `fBodyGyro_std_Y`: (numeric) standard deviation of the frequency domain body gyro signal in the Y direction
* `fBodyGyro_mean_Z`: (numeric) mean of the frequency domain body gyro signal in the Z direction
* `fBodyGyro_std_Z`: (numeric) standard deviation of the frequency domain body signal in the Z direction

* `fBodyAccMag_mean`: (numeric) mean of the frequency domain body acceleration magnitude
* `fBodyAccMag_std`: (numeric) standard deviation of the frequency domain body acceleration magnitude

* `fBodyBodyAccJerkMag_mean`: (numeric) mean of the frequency domain body acceleration jerk magnitude
* `fBodyBodyAccJerkMag_std`: (numeric) standard deviation of the frequency domain body acceleration jerk magnitude

* `fBodyBodyGyroMag_mean`: (numeric) mean of the frequency domain body gyro magnitude
* `fBodyBodyGyroMag_std`: (numeric) standard deviation of the frequency domain body gyro magnitude

* `fBodyBodyGyroJerkMag_mean`: (numeric) mean of the frequency domain body gyro jerk magnitude
* `fBodyBodyGyroJerkMag_std`: (numeric) standard deviation of the frequency domain body gyro jerk magnitude

### Variable measurement details and units

The measurements of the variables come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk\_XYZ and tBodyGyroJerk\_XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc\_XYZ, fBodyAccJerk\_XYZ, fBodyGyro\_XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

The set of variables that were estimated from these signals are:
* mean: Mean value
* std: Standard deviation

## `mean_tidy_data`

`mean_tidy_data` is a `data.frame` object with 180 observations of 68 variables, including:

* `subject_id`: (integer) the ID number of the experimental subject
* `activity`: (factor) name of the activity being performed (options include: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING\_DOWNSTAIRS", "WALKING\_UPSTAIRS")
* the mean of all the other variables listed in the [`full_tidy_data` variables](#full-tidy-data), for each activity and each participant (66 variables in total)
