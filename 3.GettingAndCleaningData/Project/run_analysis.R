
library(dplyr)
## 1. Merges the training and the test sets to create one data set

# **Reading data**

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile = './PA4Data.zip', method = 'curl')
unzip(zipfile = 'PA4Data.zip')

XTest <- read.table('./UCI HAR Dataset/test/X_test.txt')    
# Test set. Dimensions: subjects x features
yTest <- read.table('./UCI HAR Dataset/test/y_test.txt')    
# Test labels. Dimensions: subjects x 1   Data: Activity labels
XTrain <- read.table('./UCI HAR Dataset/train/X_train.txt') 
# Training set. Dimensions: subjects x features
yTrain <- read.table('./UCI HAR Dataset/train/y_train.txt') 
# Training labels. Dimensions: subjects x 1   Data: Activity labels


# **Reading labels and ID's**

activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt', 
                             col.names = c('ActivityLabel', 'ActivityName'), quote = "")
# Links the class labels with their activity name

features <- read.table('./UCI HAR Dataset/features.txt', 
                       col.names = c('FeatureID', 'FeatureName'), quote = "")
# List of all features (Acceleration, Gyro, mean, std, etc)

subjectIdTest <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names = c('subjectId'))
subjectIdTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names = c('subjectId'))
#Each row identifies the subject who performed the activity for each window sample. 
#Its range is from 1 to 30.


# **Giving column names**
colnames(XTest) <- features$FeatureName
colnames(yTest) <- c('ActivityLabels')
colnames(XTrain) <- features$FeatureName
colnames(yTrain) <- c('ActivityLabels')

# **Merging data**
testData <- cbind(subjectIdTest, XTest, yTest)
trainData <- cbind(subjectIdTrain, XTrain, yTrain)
oneDataSet <- rbind(trainData, testData)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement

oneDataSetMS <- oneDataSet[, c('subjectId', 'ActivityLabels', grep(pattern = 'mean\\(\\)|std\\(\\)',
                                               x = names(oneDataSet),value = TRUE))]
# Searching with grep for mean() and std() using RegEx
# reordering columns

## 3. Uses descriptive activity names for the activities in the data set

oneDataSetMS$ActivityLabels <- factor(meanSdData$ActivityLabels, 
                              levels = activityLabels$ActivityLabel, 
                              labels = activityLabels$ActivityName)
oneDataSetMS <- rename(oneDataSetMS, Activity = ActivityLabels)
# Using factor to change ActivityLabel to ActivityName then rename this column to Activity


## 4. Labels the data set with descriptive variable names

# Already done when column names were named with the features labels
colnames(oneDataSetMS) <- gsub(pattern = '\\(\\)', replacement = "", x = names(oneDataSetMS))
#remove the () for the mean and std


## 5. Creates a second independent tidy data set with the average of each variable for each activity and each subject
oneDataSetMS$subjectId <- as.factor(oneDataSetMS$subjectId)

oneDataSetAverage <- group_by(oneDataSetMS, subjectId, Activity) %>% summarise(across(.fns= mean))
# Using Plyr group by SubjectId, then by Activity and take the mean of variables

write.table(oneDataSetAverage, file = 'tidyDataSet.txt', row.names = F, sep = "\t", quote = F)


