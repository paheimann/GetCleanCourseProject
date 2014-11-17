## Getting and Cleaning Data Course Project

## Github id: paheimann

## Script for data transformation


## Prepare:set directory and load libraries
install.packages("data.table")
library(data.table)

## If needed, set directory where files are located
## setwd("/Users/Owner/Documents/Consulting/Data Science/Coursera Getting Cleaning Data/Project")

## 1. Merge the training and the test sets to create one data set.

## Read data files
ColNames <- read.table("UCI HAR Dataset/features.txt",colClasses="character")
ColNames <- ColNames[,2]
DT <- rbind(
        read.table("UCI HAR Dataset/train/X_train.txt",colClasses="numeric",col.names=ColNames),
        read.table("UCI HAR Dataset/test/X_test.txt",colClasses="numeric",col.names=ColNames) )
        
## Read and add activity array, convert activity indices to labels
activities <- rbind(
        read.table("UCI HAR Dataset/train/y_train.txt",colClasses="numeric",
                col.names="activities_index"),
        read.table("UCI HAR Dataset/test/y_test.txt",colClasses="numeric",
                col.names="activities_index") )
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activities$activity <- activity_labels[activities$activities_index,2]  ## add activity labels

## Read subject arrays
subjects <- rbind(
        read.table("UCI HAR Dataset/train/subject_train.txt",colClasses="numeric",
                col.names="subjects_index"),
        read.table("UCI HAR Dataset/test/subject_test.txt",colClasses="numeric",
                col.names="subjects_index") )
DT <- data.table(DT,activity=activities$activity,subject=subjects$subjects_index)


## 2. Extract only the measurements on the mean and standard deviation for each measurement.

## Include only those columns with mean() or std(), plus last 2 columns for indexing
include <- grepl(".*mean\\.\\..*",colnames(DT)) | grepl(".*std\\.\\..*",colnames(DT))
include[562] <- TRUE
include[563] <- TRUE
## Generate a subset of the data table that contains only the included columns
## We are using the subset() function because we cannot figure the correct syntax using DT[]
selected <- subset(DT,,include)
## This is the deliverable for steps 1-4

## 3. Use descriptive activity names to name the activities in the data set

## We used activity_lables.txt to translate from activity index to a descriptive label
## (see item 1 above)


## 4.Appropriately label the data set with descriptive variable names

## We assume that the existing column names in features.txt are sufficiently descriptive.
## We used those labels as arguments to col.names when we read the data into a table
## (see item 1 above)


## 5. From the data set in step 4, create a second, independent tidy data set
##  with the average of each variable for each activity and each subject

## Set key for grouping
setkey(selected,activity,subject)
## Compute average of all measurements for each combination of activity and subject
avgs <- selected[,lapply(.SD,mean),by=c("subject","activity")]

## Produce the output
write.table(avgs,"tidy_data_set.txt",row.name=FALSE)
## This is the deliverable for step 5
