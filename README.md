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
run_analysis.R : the R script run on the data set
TidyData.txt : tidy data produced as the output of running run_analysis.R on the raw data
CodeBook.md : the CodeBook reference to the variables in Tidy.txt
README.md : analysis of the code in run_analysis.R
