CodeBook
================

This code book summarizes the resulting data fields in tidydata.txt.

``` r
#this step is to download the data specified in the project

#setwd("/Users/hilmimn/Documents/DataScience/get_n_clean_data/get_n_clean_project")
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download.file( url, destfile = "data.zip" )
#unzip("data.zip")
```

``` r
#set the directory to the location of extracted data.zip file (UCI data)
#setwd("/Users/hilmimn/Documents/DataScience/get_n_clean_data/get_n_clean_project/UCI HAR Dataset")

#load library to be used
library(plyr)
library(data.table)
```

Read the txt files in UCI HAR datasets and placed in defined variables.

``` r
#create data table from txt - transformation
subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain = read.table('./train/x_train.txt',header=FALSE)
yTrain = read.table('./train/y_train.txt',header=FALSE)

subjectTest = read.table('./test/subject_test.txt',header=FALSE)
xTest = read.table('./test/x_test.txt',header=FALSE)
yTest = read.table('./test/y_test.txt',header=FALSE)
```

Bind the separated data into single table

``` r
#merge the data sets into single table
xDataSet <- rbind(xTrain, xTest)
yDataSet <- rbind(yTrain, yTest)
subjectDataSet <- rbind(subjectTrain, subjectTest)
dim(xDataSet)
```

    ## [1] 10299   561

``` r
dim(yDataSet)
```

    ## [1] 10299     1

``` r
dim(subjectDataSet)
```

    ## [1] 10299     1

Extracting the required mean and standard deviation information and
insert header into it.

``` r
#Extract only the measurements on the mean and standard deviation for each measurement.

xDataSet_mean_std <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(xDataSet_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 
#head(xDataSet_mean_std)

#Extract and append the activity labels to name the activities in the data set.

yDataSet[, 1] <- read.table("activity_labels.txt")[yDataSet[, 1], 2]
names(yDataSet) <- "Activity"
#head(yDataSet)

#label the subject data with descriptive activity names
names(subjectDataSet) <- "Subject"
#head(subjectDataSet)
```

The data labelled data are then combined into one maindata sets.

``` r
# Organizing and combining all data sets into single one.

MainDataSet <- cbind(xDataSet_mean_std, yDataSet, subjectDataSet)
```

The the variables(Column) is being given descriptive names for easier
identifications later..

``` r
# Defining descriptive names for all variables. This is to make it easier for data analysis later.

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

names(MainDataSet)
```

    ##  [1] "Time.BodyAcceleration.Mean...X"                   
    ##  [2] "Time.BodyAcceleration.Mean...Y"                   
    ##  [3] "Time.BodyAcceleration.Mean...Z"                   
    ##  [4] "Time.BodyAcceleration.std...X"                    
    ##  [5] "Time.BodyAcceleration.std...Y"                    
    ##  [6] "Time.BodyAcceleration.std...Z"                    
    ##  [7] "Time.GravityAcceleration.Mean...X"                
    ##  [8] "Time.GravityAcceleration.Mean...Y"                
    ##  [9] "Time.GravityAcceleration.Mean...Z"                
    ## [10] "Time.GravityAcceleration.std...X"                 
    ## [11] "Time.GravityAcceleration.std...Y"                 
    ## [12] "Time.GravityAcceleration.std...Z"                 
    ## [13] "Time.BodyAccelerationJerk.Mean...X"               
    ## [14] "Time.BodyAccelerationJerk.Mean...Y"               
    ## [15] "Time.BodyAccelerationJerk.Mean...Z"               
    ## [16] "Time.BodyAccelerationJerk.std...X"                
    ## [17] "Time.BodyAccelerationJerk.std...Y"                
    ## [18] "Time.BodyAccelerationJerk.std...Z"                
    ## [19] "Time.BodyAngularSpeed.Mean...X"                   
    ## [20] "Time.BodyAngularSpeed.Mean...Y"                   
    ## [21] "Time.BodyAngularSpeed.Mean...Z"                   
    ## [22] "Time.BodyAngularSpeed.std...X"                    
    ## [23] "Time.BodyAngularSpeed.std...Y"                    
    ## [24] "Time.BodyAngularSpeed.std...Z"                    
    ## [25] "Time.BodyAngularAcceleration.Mean...X"            
    ## [26] "Time.BodyAngularAcceleration.Mean...Y"            
    ## [27] "Time.BodyAngularAcceleration.Mean...Z"            
    ## [28] "Time.BodyAngularAcceleration.std...X"             
    ## [29] "Time.BodyAngularAcceleration.std...Y"             
    ## [30] "Time.BodyAngularAcceleration.std...Z"             
    ## [31] "Time.BodyAccelerationMagnitude.Mean.."            
    ## [32] "Time.BodyAccelerationMagnitude.std.."             
    ## [33] "Time.GravityAccelerationMagnitude.Mean.."         
    ## [34] "Time.GravityAccelerationMagnitude.std.."          
    ## [35] "Time.BodyAccelerationJerkMagnitude.Mean.."        
    ## [36] "Time.BodyAccelerationJerkMagnitude.std.."         
    ## [37] "Time.BodyAngularSpeedMagnitude.Mean.."            
    ## [38] "Time.BodyAngularSpeedMagnitude.std.."             
    ## [39] "Time.BodyAngularAccelerationMagnitude.Mean.."     
    ## [40] "Time.BodyAngularAccelerationMagnitude.std.."      
    ## [41] "Frequency.BodyAcceleration.Mean...X"              
    ## [42] "Frequency.BodyAcceleration.Mean...Y"              
    ## [43] "Frequency.BodyAcceleration.Mean...Z"              
    ## [44] "Frequency.BodyAcceleration.std...X"               
    ## [45] "Frequency.BodyAcceleration.std...Y"               
    ## [46] "Frequency.BodyAcceleration.std...Z"               
    ## [47] "Frequency.BodyAccelerationJerk.Mean...X"          
    ## [48] "Frequency.BodyAccelerationJerk.Mean...Y"          
    ## [49] "Frequency.BodyAccelerationJerk.Mean...Z"          
    ## [50] "Frequency.BodyAccelerationJerk.std...X"           
    ## [51] "Frequency.BodyAccelerationJerk.std...Y"           
    ## [52] "Frequency.BodyAccelerationJerk.std...Z"           
    ## [53] "Frequency.BodyAngularSpeed.Mean...X"              
    ## [54] "Frequency.BodyAngularSpeed.Mean...Y"              
    ## [55] "Frequency.BodyAngularSpeed.Mean...Z"              
    ## [56] "Frequency.BodyAngularSpeed.std...X"               
    ## [57] "Frequency.BodyAngularSpeed.std...Y"               
    ## [58] "Frequency.BodyAngularSpeed.std...Z"               
    ## [59] "Frequency.BodyAccelerationMagnitude.Mean.."       
    ## [60] "Frequency.BodyAccelerationMagnitude.std.."        
    ## [61] "Frequency.BodyAccelerationJerkMagnitude.Mean.."   
    ## [62] "Frequency.BodyAccelerationJerkMagnitude.std.."    
    ## [63] "Frequency.BodyAngularSpeedMagnitude.Mean.."       
    ## [64] "Frequency.BodyAngularSpeedMagnitude.std.."        
    ## [65] "Frequency.BodyAngularAccelerationMagnitude.Mean.."
    ## [66] "Frequency.BodyAngularAccelerationMagnitude.std.." 
    ## [67] "Activity"                                         
    ## [68] "Subject"

``` r
dim(MainDataSet)
```

    ## [1] 10299    68

``` r
#creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanData<-aggregate(. ~Subject + Activity, MainDataSet, mean)
CleanData<-CleanData[order(CleanData$Subject,CleanData$Activity),]
write.table(CleanData, file = "tidydata.txt",row.name=FALSE)
```
