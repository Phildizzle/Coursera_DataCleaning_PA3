## Source data:
As main source for the data functions the "Human Activity Recognition Using Smartphones Data Set". A full description is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data can be downloaded at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .


## About the R script:
1. Merge "training" and "test" data sets into one data set "completedata"
2. Extract measurements on the mean and standard deviation for each measurement
3. Make sure that all data have descriptive activity names
4. Use descriptive activity labels "activity_labels" to name the activities in the data set
5. Create a second data set with the average of each variable "secTidySet"


# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the Human Activity Recognition Using Smartphones Data Set.
* `x_data`, `y_data` and `subject_data` merge the previous datasets for further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in "setForMeanAndStd" a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the "activity_labels" variable.
* "completedata" merges `x_data`, `y_data` and `subject_data` in a big dataset.
* Eventually, ""secTidySet" contains the tidy data set with averages of each variable