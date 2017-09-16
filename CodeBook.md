#Introduction

The script, run_analysis.R, performs the five steps described in this project's instructions and shown in the README.md.

The script first downloads the zipped dataset into your working directory and then unzips it into a new UCI HAR Dataset directory.

After changing the working directory to the new UCI HAR Dataset directory, the script creates data frames from the relevant tables 
(see Data below).

Then the script merges matching data frames together (x, y and subject) extracts only the measurements on the mean and standard 
deviation based on data found in the features.txt file.

The script then uses descriptive activity names to name the activities based on the data found in the activity_labels.txt file.

The script also uses the make.names() function to make syntactically valid names using the "unique = TRUE" argument to ensure the 
column names are all unique to satisfy the tidy data requirement. It then normalizes the column names to further tidy up the data.

Finally, the script uses the aggregate() function to generate the summary statistics for step five and then uses the write.table() 
function to write that data to the filesystem as tidydata.txt.


#Data

We use the x_train, y_train, x_test, y_test, subject_train and subject_test files to create the initial data frames.

The xTrain and xTest data frames are merged into a single xDF data frame, the yTrain and yTest data frames are merged into a 
single yDF data frame and the subject_train and subject_test data frames are merged into a single subjectDF data frame.

The features data frame is created from the features.txt file and a targetFeatures data frame is created to extract only the mean 
and standard deviation variables. The targetFeatures data frame is then applied to xDF to generate the xMeanStdDF data frame.

The activityLabels data frame is created from the activity_labels.txt file and is then applied to the yDF data frame.

After changing some column names, the script then combines the xMeanStdDF, yDF and subjectDF data frames into a single combinedDF 
data frame.

The script then ensures the column names are unique and normalized in combinedDF.

combinedDF is then used to create a second, independent tidy data set (tidyData.txt) with the average of each variable for each 
activity and each subject.
