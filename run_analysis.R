# Coursera Getting and Cleaning Data Course Project 
library(data.table)

#this step is to download the data specified in the project.

setwd("/Users/hilmimn/Documents/DataScience/get_n_clean_data/get_n_clean_project")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file( url, destfile = "data.zip" )
unzip("data.zip")

#set the directory to the location of extracted data.zip file (UCI data)
setwd("/Users/hilmimn/Documents/DataScience/get_n_clean_data/get_n_clean_project/UCI HAR Dataset")

#load library to be used
library(plyr)
library(data.table)

#create data table from txt - transformation
subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain = read.table('./train/x_train.txt',header=FALSE)
yTrain = read.table('./train/y_train.txt',header=FALSE)

subjectTest = read.table('./test/subject_test.txt',header=FALSE)
xTest = read.table('./test/x_test.txt',header=FALSE)
yTest = read.table('./test/y_test.txt',header=FALSE)

#merge the data sets into single table
xDataSet <- rbind(xTrain, xTest)
yDataSet <- rbind(yTrain, yTest)
subjectDataSet <- rbind(subjectTrain, subjectTest)
dim(xDataSet)
dim(yDataSet)
dim(subjectDataSet)

#Extract only the measurements on the mean and standard deviation for each measurement and change the header names.
xDataSet_mean_std <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(xDataSet_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 
View(xDataSet_mean_std)
dim(xDataSet_mean_std)

#mapped activities from activity labels to yDataSet and check column names to Actvity
yDataSet[, 1] <- read.table("activity_labels.txt")[yDataSet[, 1], 2]
names(yDataSet) <- "Activity"
View(yDataSet)

#label the subject data with descriptive activity names
names(subjectDataSet) <- "Subject"
summary(subjectDataSet)

# Organizing and combining all data sets into single one.

MainDataSet <- cbind(xDataSet_mean_std, yDataSet, subjectDataSet)

# Defining descriptive names for all variables. This is to make it easier for
# data analysis later.

names(MainDataSet) <- make.names(names(MainDataSet))
names(MainDataSet) <- gsub('Acc',"Acceleration",names(MainDataSet))
names(MainDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(MainDataSet))
names(MainDataSet) <- gsub('Gyro',"AngularSpeed",names(MainDataSet))
names(MainDataSet) <- gsub('Mag',"Magnitude",names(MainDataSet))
names(MainDataSet) <- gsub('^t',"Time.",names(MainDataSet))
names(MainDataSet) <- gsub('^f',"Frequency.",names(MainDataSet))
names(MainDataSet) <- gsub('\\.mean',".Mean",names(MainDataSet))
names(MainDataSet) <- gsub('Freq\\.',"Frequency.",names(MainDataSet))
names(MainDataSet) <- gsub('Freq$',"Frequency",names(MainDataSet))
names(MainDataSet) <- gsub('BodyBody',"Body",names(MainDataSet))

View(MainDataSet)
dim(MainDataSet)


#creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanData<-aggregate(. ~Subject + Activity, MainDataSet, mean)
CleanData<-CleanData[order(CleanData$Subject,CleanData$Activity),]
write.table(CleanData, file = "tidydata.txt",row.name=FALSE)


