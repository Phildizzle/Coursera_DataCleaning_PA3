#Set working directory
setwd('C:\\Users\\user1\\Desktop\\Data Science\\3. Cleaning Data\\Fourth Week')

# First part: Merge training and test data sets into one
#Download and unzip data set
fileurl1 = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dst1 = 'C:\\Users\\user1\\Desktop\\Data Science\\3. Cleaning Data\\Fourth Week\\SmartphoneData.zip'
download.file(fileurl1, dst1)
unzip(dst1, files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "", unzip = "internal",
      setTimes = FALSE)

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

#Assign individual column labels of the activity_labels 
#vector to train and test data sets
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_labels) <- c('activityId','activityType')

        #Merge train and test data into one data set
        merge_train <- cbind(y_train, subject_train, x_train)
        merge_test <- cbind(y_test, subject_test, x_test)
        completedata <- rbind(merge_train, merge_test)
        str(completedata)

#Second part: Extract measurements on the mean and standard deviation for each measurement
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

#Fourth part: Use descriptive activity names to name the activities in the data set
# i.e. use the activity_labels vector (third part already in the code above)

setwithactivitynames <- merge(setForMeanAndStd, activity_labels,
                              by='activityId',
                              all.x=TRUE)

#Fifth part: Create a second data set with the average of each variable 
#for each activity and each subject

secTidySet <- aggregate(. ~subjectId + activityId, setwithactivitynames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Export the table:
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)

#End of file
