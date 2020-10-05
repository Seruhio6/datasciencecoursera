### Code Book


This book describes the data for the final project of the Coursera Data Science 
Specialization: Getting and Cleaning Data.


### Source data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, it's been captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

[Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Variables

- 561 features
- 6 types of activity
- 30 subjects

This variables were included in the following files from the source data:

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

### Tidy data
Source data has been processed with run_analysis.R script that does the following:

1. Merges the training and the test sets to create one data set called oneDataSet

2. Gives oneDataSet the descriptive name of features and activity labels

3. Extracts only the measurements on the mean and standard deviation for each measurement.

4. Calculate average of each variable for each activity and each subject.

### Final variables

 [1] "subjectId"                 "Activity"                  "tBodyAcc-mean-X"          
 [4] "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"           "tBodyAcc-std-X"           
 [7] "tBodyAcc-std-Y"            "tBodyAcc-std-Z"            "tGravityAcc-mean-X"       
[10] "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"        "tGravityAcc-std-X"        
[13] "tGravityAcc-std-Y"         "tGravityAcc-std-Z"         "tBodyAccJerk-mean-X"      
[16] "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"       "tBodyAccJerk-std-X"       
[19] "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"        "tBodyGyro-mean-X"         
[22] "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"          "tBodyGyro-std-X"          
[25] "tBodyGyro-std-Y"           "tBodyGyro-std-Z"           "tBodyGyroJerk-mean-X"     
[28] "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"      "tBodyGyroJerk-std-X"      
[31] "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"       "tBodyAccMag-mean"         
[34] "tBodyAccMag-std"           "tGravityAccMag-mean"       "tGravityAccMag-std"       
[37] "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"       "tBodyGyroMag-mean"        
[40] "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"     "tBodyGyroJerkMag-std"     
[43] "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"           "fBodyAcc-mean-Z"          
[46] "fBodyAcc-std-X"            "fBodyAcc-std-Y"            "fBodyAcc-std-Z"           
[49] "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"       "fBodyAccJerk-mean-Z"      
[52] "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"        "fBodyAccJerk-std-Z"       
[55] "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"          "fBodyGyro-mean-Z"         
[58] "fBodyGyro-std-X"           "fBodyGyro-std-Y"           "fBodyGyro-std-Z"          
[61] "fBodyAccMag-mean"          "fBodyAccMag-std"           "fBodyBodyAccJerkMag-mean" 
[64] "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"     "fBodyBodyGyroMag-std"     
[67] "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std" 

Units:

From acceleration variables: Standard gravity units 'g'

From Gyro variables: radians/second







