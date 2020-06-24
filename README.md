Getting and Cleaning Data Course project

Initial data for research

This is a course project for the Getting and Cleaning Data, as part of
the coursera Data Science specialization course by John Hopkins
University.

The purpose of this course project is to test the ability of
participants to to collect, work with, and clean a data set.

The data sets used are collected from the accelerometers from the
Samsung Galaxy S smartphone. A full description of the data is available
at the site where the data was obtained.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

the raw datasets used for this project can be download
here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The following files from the initial dataset is used:

1) features.txt - includes the descriptions for features measured
2) train/X_train.txt - includes the measurements of the features in train set (one row - 1 measurement of 561 features) 
3) test/X_test.txt - includes the measurements of the features in test set
4) train/subject_train.txt - subject for each measurement from the train set 
5) test/subject_test.txt - subject for each measurement from the test set 
6) train/y_train.txt - activity (from 1 to 6) for each measurement from the train set 
7) test/y_test.txt - activity (from 1 to 6) for each measurement from the test set
8) acitivty_labels.txt - labels of activity

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

How the script works.

1. The script first extracted raw data in the list below and create a new data table.
        a) Subject Train.txt
        b) x_train.txt
        c) y_train.txt
        d) subject test.txt
        e) x_test.txt
        f) y_test.tx
        
2. The data table created the was merge together to create 3 main data sets which is subjectdataset, xDataset and yDataset.

3. Based on the xDataset, the mean and standard deviation information was extracted and header was append to it from feature.txt.

4. yDataset is given label by combining it with activity_labels.txt

5. All data sets is combined to create MainDataSet

6. Then, a new tidydata.txt is created by aggregating the tables.





