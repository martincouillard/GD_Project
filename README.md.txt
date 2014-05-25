The R script "run_analysis.R" perform the following analysis on the UCI HAR Dataset.
The output is a dataset with the average for the mean and std measurements for each activity and each subject.

The script 
1. reads the datasets, and then merges the training and the test sets to create one data set.
2. extracts only the measurements on the mean and standard deviation for each measurement. 
3. uses descriptive activity names to name the activities in the data set
4. appropriately labels the data set with descriptive activity names. 
5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output is written as a text file: “AverageData.txt”.  
The name of the rows are the measurements (3 means and 3 stds), 
and the name of the column are the 6 activities, followed by the subject number.  
The value in each case is the mean for each measurements.
