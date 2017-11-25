library(dplyr)
# library(sqldf)
library(data.table)
options(tz="Europe/Oslo")
Sys.setenv(TZ="Europe/Oslo")
# This script will load, merge and clean training data in the dataset that can be downloaded here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Description of the dataset can be found here:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# The goal of this script is to output a Tidy file.
# Tidy: Each variable is in its own column
# Each observation, or case, is in its own row

# Setting my working directory, Change  to where you downloaded files.
setwd("~/Dropbox/Prosjekter/ds_projects/course_3/data/UCI HAR Dataset")
# Loading data into R, convert to dplyr and free memory

activity_in <-fread('activity_labels.txt')              # Load data
activity <- tbl_df(activity_in)                         # Create dplyr frame
rm(activity_in)                                         # Free up memory used
# Repeate the above steps.

features_in <- fread('features.txt')                    # Load data
features <- tbl_df(features_in)                         # Create dplyr frame
rm(features_in)                                         # Free up memory used

# Read training data and create dataframes
X_train_in <- fread("./train/X_train.txt") 
X_train <-tbl_df(X_train_in)
rm(X_train_in)

Y_train_in <- fread('./train/Y_train.txt')
Y_train <- tbl_df(Y_train_in)
rm(Y_train_in)

sub_in <-fread('./train/subject_train.txt')
subjects_train <- tbl_df(sub_in)
rm(sub_in)

# Read testing data and create dataframes
X_test_in <- fread('./test/X_test.txt')
X_test <- tbl_df(X_test_in)
rm(X_test_in)
Y_test_in <- fread('./test/Y_test.txt')
Y_test <- tbl_df(Y_test_in)
rm(Y_test_in)

sub_in <-fread('./test/subject_test.txt')
subjects_test <- tbl_df(sub_in)
rm(sub_in)
# Data load into R completed

# Merge datasets
subjects <- rbind(subjects_train, subjects_test)
df  <- rbind(Y_train, Y_test)                           #Temporary names while creating proper tables
df2 <- rbind(X_train, X_test)                           # "

                # Creating table headers
                colnames(df2) <- t(features[2])
                colnames(df) <- "Activity"
                colnames(subjects) <- "Subject"
                # Creating main table
                completeTable <- cbind(df2,df,subjects)
# End Merge datasets

# Get the columns wiht mean or STD
columns <- grep(".*Mean.*|.*Std.*", names(completeTable), ignore.case=TRUE)
# Add activity and Subject
requiredColumns <- c(columns, 562, 563)
FilteredTable <- completeTable[,requiredColumns]

# Getting Activity values
FilteredTable$Activity <- as.character(FilteredTable$Activity)
for (i in 1:6){
        FilteredTable$Activity[FilteredTable$Activity == i] <- as.character(activity[i,2])
}


# Tidying table columns 
colClean <- function(x){ colnames(x) <- gsub("\\(\\)+", "", colnames(x)); x }  # Removing the ()-from columns
FilteredTable <- colClean(FilteredTable)
# Getting the mean valiues
tidyData <- aggregate(. ~Subject + Activity, FilteredTable, mean)
# Ordering the output for readiness
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

# Saving the finish result to file.
write.table(tidyData, "tidydata.txt", row.names = FALSE, quote = FALSE)
