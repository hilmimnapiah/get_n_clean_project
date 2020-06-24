README
================

“Getting and Cleaning Data” Course Project

Initial data for research

The script is invented to analyze the data from UCI HAR Dataset. It’s
supposed that archive is extracted to the working directory.

The following files from the initial dataset is used:

features.txt - includes the descriptions for features measured
train/X\_train.txt - includes the measurements of the features in train
set (one row - 1 measurement of 561 features) test/X\_test.txt -
includes the measurements of the features in test set
train/subject\_train.txt - subject for each measurement from the train
set test/subject\_test.txt - subject for each measurement from the test
set train/y\_train.txt - activity (from 1 to 6) for each measurement
from the train set test/y\_test.txt - activity (from 1 to 6) for each
measurement from the test set

How script works

Script involves the following stages:

Step 1 : Creating data tables by reading for the text files available in
the UCI HAR Datasets.

Step 2 : Combined the individual datasets into single datasets :
xDataSet, yDataSet and subjectDataSet

Step 3 : Extract the mean and standard deviation from xDataSet and
append the header from features.txt file.

Step 4 : Mapped the yDataSet with Activity Labels.txt and change the
header names to Activity and Changes the subjectDataSet header to
Subject.

Step 5 : Combined all datasets (xDataSet\_mean\_std, yDataSet,
subjectDataSet) into mainDataSet and then change the variables names to
more descriptive.

Step 6 : Create independent TidyData.txt with the average of each
variable for each activity and each subject.
