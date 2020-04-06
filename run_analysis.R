url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Peer_assignment_week4.zip")

#unzip downloaded file
zipF <- paste(getwd(),"Peer_assignment_week4.zip",sep="/")
unzip(zipF)

##load data files
#test
file_path <- paste(getwd(),"UCI HAR Dataset/test/X_test.txt",sep="/")
file_path2 <- paste(getwd(),"UCI HAR Dataset/test/y_test.txt",sep="/")
file_path3 <- paste(getwd(),"UCI HAR Dataset/test/subject_test.txt",sep="/")

X_test <- read.table(file_path, header = FALSE)
y_test <- read.table(file_path2, header = FALSE)
subject_test <- read.table(file_path3, header = FALSE)

#train
file_path <- paste(getwd(),"UCI HAR Dataset/train/X_train.txt",sep="/")
file_path2 <- paste(getwd(),"UCI HAR Dataset/train/y_train.txt",sep="/")
file_path3 <- paste(getwd(),"UCI HAR Dataset/train/subject_train.txt",sep="/")

X_train <- read.table(file_path, header = FALSE)
y_train <- read.table(file_path2, header = FALSE)
subject_train <- read.table(file_path3, header = FALSE)

#header for X_test and X_train
file_path <- paste(getwd(),"UCI HAR Dataset/features.txt",sep="/")
features <- read.table(file_path, header = FALSE)

#rename column headers
  #subject_test and train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
  #y_test and train: Each row identifies the label within a given subject
names(subject_test) <- "subject"
names(y_test) <- "activity"
names(subject_train) <- "subject"
names(y_train) <- "activity"

  #features provides the names for eahc column of the data set
names(X_test) <- features$V2
names(X_train) <- features$V2


### Task 1: Merges the training and the test sets to create one data set.

Train <- cbind(subject_train, y_train, X_train)
Test <- cbind(subject_test, y_test, X_test)

# df combines the data from Test and Train datasets
df <- rbind(Test, Train)


### Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#select only column names which include meausrements for mean or std 
  #\\ escape character in order to include brakets for excluding measurements of i.e. meanFreq()
  #inlcude label and subject column as well
df_mean_std <- df[grep("mean\\()|std\\()|subject|activity", names(df))]


### Task 3: Uses descriptive activity names to name the activities in the data set
file_path <- paste(getwd(),"UCI HAR Dataset/activity_labels.txt",sep="/")
activity_labels <- read.table(file_path, header =  FALSE)

#replace numbers 1:6 with labels 1:6 from activity_labels
df_mean_std$activity <- sub("1", activity_labels[1,2], df_mean_std$activity)
df_mean_std$activity <- sub("2", activity_labels[2,2], df_mean_std$activity)
df_mean_std$activity <- sub("3", activity_labels[3,2], df_mean_std$activity)
df_mean_std$activity <- sub("4", activity_labels[4,2], df_mean_std$activity)
df_mean_std$activity <- sub("5", activity_labels[5,2], df_mean_std$activity)
df_mean_std$activity <- sub("6", activity_labels[6,2], df_mean_std$activity)

###Task 4: Appropriately labels the data set with descriptive variable names.
#done while loading the data

###Task 5: From the data set in step 4, creates a second, independent tidy data set with the average 
#           of each variable for each activity and each subject.

library(dplyr)
#chaining with dplyr
#group data first by subject and then by activity and then calculate the mean over all clumns
df_grouped_mean <- df_mean_std %>% group_by(subject) %>% group_by(activity, add=TRUE) %>% summarise_all(funs(mean))

write.table(df_grouped_mean, "Peer_assignment_Week4_Tim_Schauer.txt", row.names = FALSE)

names(df_grouped_mean)
