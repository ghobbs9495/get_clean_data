# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#   Step 1
#   Merges data sets [training,data] to create one data set named 'One','Two','Three' respectively
    One1 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/train/X_train.txt")
    One2 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/test/X_test.txt")
    One <- rbind(One1, One2)

    Two1 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/train/subject_train.txt")
    Two2 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/test/subject_test.txt")
    Two <- rbind(Two1, Two2)

    Three1 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/train/y_train.txt")
    Three2 <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/test/y_test.txt")
    Three <- rbind(Three1, Three2)

#   Step 2   
#   Extracts only the measurements on the mean and standard deviation for each measurement.
read <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/features.txt")
read_good <- grep("-mean\\(\\)|-std\\(\\)", read[, 2])
One <- One[, read_good]
names(One) <- read[read_good, 2]
names(One) <- gsub("\\(|\\)", "", names(One))
names(One) <- tolower(names(One))

#   Step 3
#   Uses descriptive activity names to name the activities in the data set.
activities <- read.table("C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Three[,1] = activities[Three[,1], 2]
names(Three) <- "activity"

#   Step 4
#   Appropriately labels the data set with descriptive activity names.
names(Two) <- "subject"
cleaned <- cbind(Two, Three, One)
write.table(cleaned, "C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/merged_clean_dataset.txt")

#   Step 5
#   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
uniquesub = unique(Two)[,1]
numsub = length(unique(Two)[,1])
numactivities = length(activities[,1])
numcols = dim(cleaned)[2]
result = cleaned[1:(numsub*numactivities), ]

row = 1
for (i in 1:numsub) {
    for (j in 1:numactivities) {
        result[row, 1] = uniquesub[i]
        result[row, 2] = activities[j, 2]
        tmp <- cleaned[cleaned$subject==i & cleaned$activity==activities[j, 2], ]
        result[row, 3:numcols] <- colMeans(tmp[, 3:numcols])
        row = row+1
    }
}
write.table(result, "C:/Users/ghobbs/Desktop/All My Stuff/RClass/Project3/UCI HAR Dataset/tidydata_with_averages.txt",row.name=FALSE)