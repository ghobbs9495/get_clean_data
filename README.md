# Getting and Cleaning Data

John Hopkins Getting and Cleaning Data course


## Course Project
### This is a document describing how the script works

*Step 1

Merges data sets [training,data] to create one data set named 'One','Two','Three' respectively
Three different merges of the same data are used in order to keep different functions thereafter distinct from each other

All files are located in: "C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/train/X_train.txt"


*Step 2

Extracts only the measurements on the mean and standard deviation for each measurement

Uses the grep function to search for matches to an argument pattern within each element of the character vector

Uses the first set of merged data

Uses gsub function to perform the replacement of the first and all matches of the character vector


*Step 3

Uses descriptive activity names to name the activities in the data set
Reads the activity_labels data set and picks out distinct pieces of information using the gsub function


*Step 4


Appropriately labels the data set with descriptive activity names

Column binds the three data sets into a cleaned data set and writes the data to a text file "merged_clean_dataset"


*Step 5

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Pulls the unique values for each subject and organizes them so that each variable forms a column, each observations forms a row, and each type of observational unit forms a table

Writes a data table called tidydata_with_averages