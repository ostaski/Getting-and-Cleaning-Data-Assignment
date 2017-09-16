# Getting-and-Cleaning-Data-Assignment

The dataset used in this project can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The five steps to this project are:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R only assumes you are in your working directory. You will need to change the two setwd commands to suit your environment.

run_analysis.R contains all the code necessary to download, unzip and perform the tasks described in the five steps. They can be launched in RStudio by using source(run_analysis.R), assuming you have placed run_analysis.R in your working directory.

CodeBook.md describes the data and transformations that were performed to complete the five steps.

tidyData.txt is the resulting file created in step 5.
