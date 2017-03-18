## Coursera_DataCleaning_PA3 Tidy Mean and Standard Deviation Data from the UCI HAR Data Set
This repository contains all documents necessary to complete the programming assignment for Coursera's Data Cleaning course by the phenomenal Roger Peng! 

## The Data

This script uses the data from UC Irvine's Human Activity Recognition Using Smartphones Data Set.  The data used is here:
  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

More information about the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## The Script
This repository contains a script called `run_analysis.R`.
### Requirements
The data files should be in the working directory when you run the script.

## Assignment instructions, i.e. changes applied to the original data set above.

Read files.
``` R
#Read  trainings files
x_train <- read.table('.\\UCI HAR Dataset\\train\\X_train.txt')
y_train <- read.table('.\\UCI HAR Dataset\\train\\y_train.txt')
subject_train <- read.table('.\\UCI HAR Dataset\\train\\subject_train.txt')

#Read  trainings files
x_test <- read.table('.\\UCI HAR Dataset\\test\\X_test.txt')
y_test <- read.table('.\\UCI HAR Dataset\\test\\y_test.txt')
subject_test <- read.table('.\\UCI HAR Dataset\\test\\subject_test.txt')

#Read the features vector
features <- read.table('.\\UCI HAR Dataset\\features.txt')

#Read activity labels
activity_labels <- read.table('.\\UCI HAR Dataset\\activity_labels.txt')
```
Use descriptive activity names to name the activities in the data set.
The activity names from the `activity_labels` file are applied to the variables from test and train files.

``` R
#Assign individual column labels of the activity_labels vector to train and test data sets
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_labels) <- c('activityId','activityType')
```

Merge train and test data into one data set
``` R
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
completedata <- rbind(merge_train, merge_test)
str(completedata)
```

Extract only the measurements on the mean and standard deviation for each measurement. 
``` R
#Extract the column names into a vector
col_names <- colnames(completedata)

#Create a vector for defining ID, mean and sd
mean_and_std <- (grepl("activityId" , col_names) | 
                         grepl("subjectId" , col_names) | 
                         grepl("mean.." , col_names) | 
                         grepl("std.." ,col_names) 
)
#Make necessary subset from the complete data set
setForMeanAndStd <- completedata[ , mean_and_std == TRUE]
```
Use descriptive activity names to name the activities in the data set
``` R
setwithactivitynames <- merge(setForMeanAndStd, activity_labels,
                              by='activityId',
                              all.x=TRUE)
```

Create a second data set with the average of each variable for each activity and each subject
```R
secTidySet <- aggregate(. ~subjectId + activityId, setwithactivitynames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Export the table:
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
```

End of this README.MD file.
