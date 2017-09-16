## 1 - Merge the training and the test sets to create one data set.

## go to your working directory, then download the zip file amd note the date/time
setwd("C:/Data Science/Course 3 - Getting and Cleaning Data/WorkingDirectory")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "./har.zip"
download.file(url, destFile)

fileConn <- file("dateDownloaded.txt")
writeLines(date(), fileConn)
close(fileConn)

## unzip the destFile, the new directory will be "UCI HAR Dataset"
unzip(zipfile="./har.zip")

## change working directory to ./UCI HAR Dataset
setwd("C:/Data Science/Course 3 - Getting and Cleaning Data/WorkingDirectory/UCI HAR Dataset/")

## create data frames from the training files
subjectTrain <- read.table("./train/subject_train.txt") ## 7352 obs. of 1 variable
xTrain <- read.table("./train/x_train.txt") ## 7352 obs. of 561 variables
yTrain <- read.table("./train/y_train.txt") ## 7352 obs. of 1 variable

## do the same for the test data
subjectTest <- read.table("./test/subject_test.txt") ## 2947 obs. of 1 variable
xTest <- read.table("./test/x_test.txt") ## 2947 obs. of 561 variables
yTest <- read.table("./test/y_test.txt") ## 2947 obs. of 1 variable

## merge the x, y and subject data frames
xDF <- rbind(xTrain, xTest) ## 10299 obs. of 561 variables 
yDF <- rbind(yTrain, yTest) ## 10299 obs. of 1 variable
subjectDF <- rbind(subjectTrain, subjectTest) ## 10299 obs. of 1 variable

## 2 - Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt") ## 561 obs. of 2 variables

targetFeatures <- grep("-(mean|std)\\(\\)", features[, 2]) ## int [1:66] 1 2 3 4 5 6 41 42 43 44 ...

## create a subset of xDF containing only mean and std measurements
xMeanStdDF <- xDF[, targetFeatures] ## 10299 obs. of 66 variables

## 3 - Use descriptive activity names to name the activities in the data set

## use the actual activity names on yDF
activityLabels <- read.table("./activity_labels.txt") ## 6 obs. of 2 variables
yDF[, 1] <- activityLabels[yDF[, 1], 2]
names(yDF) <- "Activity"

## 4 - Appropriately label the data frames with descriptive variable names

## change the subjectDF's column name to Subject
names(subjectDF) <- "Subject"

## combine the xMeanStdDF, yDF and subjectDF data frames into one
combinedDF <- cbind(xMeanStdDF, yDF, subjectDF) ## 10299 obs. of 68 variables

## rename the columns into something meaningful
names(combinedDF) <- features[targetFeatures, 2]

## make syntactically valid names out of character vectors
## setting unique to TRUE since we want unique column names
names(combinedDF) <- make.names(names(combinedDF), unique = TRUE)

colNames = colnames(combinedDF)

## normalize column names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","frequency",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

## assign normalized column names to combinedDF
colnames(combinedDF) = colNames

## OOPS! we lost our Subject and Activity column names, so put those back
names(combinedDF)[67] <- "Activity"
names(combinedDF)[68] <- "Subject"

## 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## using aggregate to generate summary statistics
tidyData <- aggregate(. ~Subject + Activity, combinedDF, mean) ## 180 obs. of 68 variables

## write tidyData to the filesystem
write.table(tidyData, file = "tidydata.txt", row.name=FALSE)
