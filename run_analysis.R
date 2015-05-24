## Coursera Getting and Cleaning Data Course Project

## Download and unzip the UCI HAR Dataset from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## set working directory to the unzip UCI HAR dataset

## Step 1: Merge the training and the test sets to create one data set

## Read the activity files
activitytest  <- read.table(file.path(UCI_HAR_dataset, "test" , "Y_test.txt" ),header = FALSE)
activitytrain <- read.table(file.path(UCI_HAR_dataset, "train", "Y_train.txt"),header = FALSE)

## Read the subject files
SubjectTrain <- read.table(file.path(UCI_HAR_dataset, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(UCI_HAR_dataset, "test" , "subject_test.txt"),header = FALSE)

## Read the features files

FeaturesTest  <- read.table(file.path(UCI_HAR_dataset, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(UCI_HAR_dataset, "train", "X_train.txt"),header = FALSE)

## Concatenate the data tables by rows

Activity<- rbind(activitytrain, activitytest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

## set names to variables

names(Activity)<- c("activity")
names(Subject)<-c("subject")
FeaturesNames <- read.table(file.path(UCI_HAR_dataset, "features.txt"), header=FALSE)
names(Features)<- FeaturesNames$V2

## Merge columns to get the data frame for all data

Combine <- cbind(Subject, Activity)
CombineData <- cbind(Features, Combine)

## Step 2:  Extract only the measurements on the mean and standard deviation for each measurement. 

## Subset Name of Features by measurements on the mean and standard deviation
## i.e taken Names of Features with "mean()" or "std()"

subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

## Subset the data frame by seleted names of Features

selectedNames <- c(as.character(subsetFeaturesNames), "subject", "activity" )
DataFrame <- subset(CombineData, select=selectedNames)

## Check the structures of the data frame 

str(DataFrame)

## Step 3: Use descriptive activity names to name the activities in the data set

## Read descriptive activity names from "activity_labels.txt"

activitylabels <- read.table(file.path(UCI_HAR_dataset, "activity_labels.txt"))

## Assign the colnames for the activitylabels
colnames(activitylabels) <- c("Activityid", "Activitytype")


## facorize Variable in the data frame using descriptive activity names

DataFrameactivity <- merge(DataFrame, activitylabels)

## check

head(DataFrameactivity,30)

## Updating the colNames vector to include the new column names after merge
Data <- DataFrameactivity

## Step 4: Appropriately label the data set with descriptive activity names

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## Check
names(Data)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

