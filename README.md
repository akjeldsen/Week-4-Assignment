# Week 4 Assignment: Getting and Cleaning data


This script will load, merge and clean training data in the dataset that can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description of the dataset can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


 
The goal of this script is to take multiple datasets, clean and output to a Tidy file.
Tidy: 
* Each variable is in its own column.
* Each observation, or case, is in its own row.

Task: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run this script. Make sure you have downloaded the zip file first, either in R or via wget or other means.
Example: source('./run_analysis.R')

This should produce a Tidy version of the data for 30 individuals with 6 oberservations pr individual.
The dataset is filtered to only include mean and standard deviation columns.
