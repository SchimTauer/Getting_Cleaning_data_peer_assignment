CONTENTS:
1. README file from original data set
2. README file for downstream process within the course "Getting and Cleaning Data" on Coursera (week 4 assignment)


1. README file from original data set
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.



2. README file for downstream process within the course "Getting and Cleaning Data" on Coursera (week 4 assignment)
==================================================================
Peer_assignment_Week4_Getting_and_cleaning_data_Tim_Schauer
Version 1.0
==================================================================
Tim Schauer
==================================================================

The orginal data (see above) was used to finish the peer assignment of week4 in "getting and cleaning" data on Coursera
In summary, the data was used to accomplish the following goals:

You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The original data set was downstream processed via the following code
======================================
#download the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Peer_assignment_week4.zip")

#unzip downloaded file
zipF <- paste(getwd(),"Peer_assignment_week4.zip",sep="/")
unzip(zipF)

##load data files from unzipped file
#test data
file_path <- paste(getwd(),"UCI HAR Dataset/test/X_test.txt",sep="/")
file_path2 <- paste(getwd(),"UCI HAR Dataset/test/y_test.txt",sep="/")
file_path3 <- paste(getwd(),"UCI HAR Dataset/test/subject_test.txt",sep="/")

X_test <- read.table(file_path, header = FALSE)
y_test <- read.table(file_path2, header = FALSE)
subject_test <- read.table(file_path3, header = FALSE)

#train data
file_path <- paste(getwd(),"UCI HAR Dataset/train/X_train.txt",sep="/")
file_path2 <- paste(getwd(),"UCI HAR Dataset/train/y_train.txt",sep="/")
file_path3 <- paste(getwd(),"UCI HAR Dataset/train/subject_train.txt",sep="/")

X_train <- read.table(file_path, header = FALSE)
y_train <- read.table(file_path2, header = FALSE)
subject_train <- read.table(file_path3, header = FALSE)

#Column names (features) for X_test and X_train
file_path <- paste(getwd(),"UCI HAR Dataset/features.txt",sep="/")
features <- read.table(file_path, header = FALSE)

#rename column headers
  #subject_test and train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
  #y_test and train: Each row identifies the label within a given subject
names(subject_test) <- "subject"
names(y_test) <- "activity"
names(subject_train) <- "subject"
names(y_train) <- "activity"

  #features provides the names for each column of the data set
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


The GitHub repo contains the following data:
=========================================

- 'README.txt'

- 'codebook.txt': Shows information about the variables used in the  data set

- 'peer_assignment_week4_Tim_Schauer.txt': contains the tidy data set created in step 5


Notes: 
======
