## This script combines the test and training accelerometer data
## and creates a tidy data set with the mean and standard
## deviation variables for each subject and each activity.

## PART 1: Load the input data and metadata into data tables
featureNames <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

## Combine the test data observations with the training
## data observations by using rbind
subject <- rbind(trainSubject, testSubject)
activity <- rbind(trainActivity, testActivity)
features <- rbind(trainFeatures, testFeatures)

## Name the feature columns using the featureNames table
colnames(features) <- t(featureNames[2])

## Merge the activity, subject, and features data
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
data <- cbind(features, activity, subject)

## PART 2: Extract only the mean and standard deviation
## measurements for each observation
dataMeanStd <- grep(".*Mean.*|.*Std.*", names(data), 
                    ignore.case=TRUE)
columns <- c(dataMeanStd, 562, 563)
selectData <- data[,columns]

## PART 3: Use descriptive activity names for the activites
## Change the Activity field from numeric to character
selectData$Activity <- as.character(selectData$Activity)
for (i in 1:6){
        selectData$Activity[selectData$Activity == i] 
        <- as.character(activities[i,2])
}
selectData$Activity <- as.factor(selectData$Activity)

## Part 4: Label the data set with descriptive variable naems
names(selectData) <- gsub("-mean()", "Mean", names(selectData), ignore.case = TRUE)
names(selectData) <- gsub("-std()", "StdDeviation", names(selectData), ignore.case = TRUE)
names(selectData) <- gsub("Acc", "Accelerometer", names(selectData))
names(selectData) <- gsub("Gyro", "Gyroscope", names(selectData))
names(selectData) <- gsub("BodyBody", "Body", names(selectData))
names(selectData) <- gsub("Mag", "Magnitude", names(selectData))
names(selectData) <- gsub("^t", "Time", names(selectData))
names(selectData) <- gsub("^f", "Frequency", names(selectData))
names(selectData) <- gsub("tBody", "TimeBody", names(selectData))
names(selectData) <- gsub("-freq()", "Frequency", names(selectData), ignore.case = TRUE)
names(selectData) <- gsub("angle", "Angle", names(selectData))
names(selectData) <- gsub("gravity", "Gravity", names(selectData))

## PART 5: Create an independent, tidy data set with the
## average for each variable for each activity and each subject
selectData$Subject <- as.factor(selectData$Subject)
selectData <- data.table(selectData)
tidyData <- aggregate(. ~Subject + Activity, selectData, mean)
tidyData <- arrange(tidyData, Subject, Activity)
write.table(tidyData, file = "TidyData.txt", row.names = FALSE)

