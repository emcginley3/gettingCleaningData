# gettingCleaningData
Getting &amp; Cleaning Data Project
---------------------------------------------------------------------------------------------------------------------------
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The run_analysis.R script uses data collected from the accelerometers from the Samsung Galaxy S smartphone and does the following:
1. Merges training and test data sets into a single data set
2. Extracts only the mean and standard deviation variables for each observation
3. Adds descriptive activity names to each observation
4. Labels the data set with descriptive variable names
5. Creates a new, tidy data set with the average of each variable from step 4 for each activity and each subject

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data is available at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

---------------------------------------------------------------------------------------------------------------------------
This project contains:
-- run_analysis.R : the R script run on the data set
-- TidyData.txt : tidy data produced as the output of running run_analysis.R on the raw data
-- CodeBook.md : the CodeBook reference to the variables in Tidy.txt
-- README.md : analysis of the code in run_analysis.R

---------------------------------------------------------------------------------------------------------------------------
run_analysis.R does the following:

1. Loads the input data and metadata into data tables
-- featureNames <- read.table("UCI HAR Dataset/features.txt")
-- activities <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
-- trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
-- trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
-- trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
-- testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
-- testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
-- testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

2. Combines the test data observations with the training data observations by using rbind
-- subject <- rbind(trainSubject, testSubject)
-- activity <- rbind(trainActivity, testActivity)
-- features <- rbind(trainFeatures, testFeatures)

3. Names the feature columns using the featureNames table
-- colnames(features) <- t(featureNames[2])

4. Merges the activity, subject, and features data using cbind
-- colnames(activity) <- "Activity"
-- colnames(subject) <- "Subject"
-- data <- cbind(features, activity, subject)

5. Extracts only the mean and standard deviation measurements for each observation
-- dataMeanStd <- grep(".*Mean.*|.*Std.*", names(data), 
                    ignore.case=TRUE)
-- columns <- c(dataMeanStd, 562, 563)
-- selectData <- data[,columns]

6. Adds descriptive activity names for the activites, after changing the Activity field from numeric to character
-- selectData$Activity <- as.character(selectData$Activity)
-- for (i in 1:6){
        selectData$Activity[selectData$Activity == i] 
        <- as.character(activities[i,2])
}
-- selectData$Activity <- as.factor(selectData$Activity)

7. Labels the data set with descriptive variable naems
-- names(selectData) <- gsub("-mean()", "Mean", names(selectData), ignore.case = TRUE)
-- names(selectData) <- gsub("-std()", "StdDeviation", names(selectData), ignore.case = TRUE)
-- names(selectData) <- gsub("Acc", "Accelerometer", names(selectData))
-- names(selectData) <- gsub("Gyro", "Gyroscope", names(selectData))
-- names(selectData) <- gsub("BodyBody", "Body", names(selectData))
-- names(selectData) <- gsub("Mag", "Magnitude", names(selectData))
-- names(selectData) <- gsub("^t", "Time", names(selectData))
-- names(selectData) <- gsub("^f", "Frequency", names(selectData))
-- names(selectData) <- gsub("tBody", "TimeBody", names(selectData))
-- names(selectData) <- gsub("-freq()", "Frequency", names(selectData), ignore.case = TRUE)
-- dir(names(selectData) <- gsub("angle", "Angle", names(selectData))
-- names(selectData) <- gsub("gravity", "Gravity", names(selectData))

8. Creates an independent, tidy data set with the average for each variable for each activity and each subject
-- selectData$Subject <- as.factor(selectData$Subject)
-- selectData <- data.table(selectData)
-- tidyData <- aggregate(. ~Subject + Activity, selectData, mean)
-- tidyData <- arrange(tidyData, Subject, Activity)

9. Writes the output table to a text file called "TidyData.txt"
-- write.table(tidyData, file = "TidyData.txt", row.names = FALSE)


