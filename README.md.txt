## Course Project - Getting and Cleaning Data

The code aims to incorporate two principles of tudy data set i.e
1. Each variable you measure should be in one column 
2. Each different observation of that variable should be in a different row

Code Summary:
As directed in the assignment, the code should be an R script called run_analysis.R that does the following: 


1. MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET. 

## Please unzip the source data file and place the 'UCI HAR Dataset' folder in the working directory
## Load the 'dplyr' package, it is used of chaining function.

## Reading the data from train data and other files:
   features.txt, activity_labels.txt, subject_train.txt, x_train.txt, y_train.txt
## Assigning column names to the data extracted above

## Generating training data set by merging data extracted from: 
   y_train, subject_train, and x_train by column

## Read in the test data;
   subject_test.txt, x_test.txt, y_test.txt
## Assign column names to the test data imported above

## Creating test data by merging y_test, subject_test data & x_test

## Merge training and test data by rows to create a final data set

## Create a vector for the column names from the final_data, which will be used 
   to select the desired mean() & stddev() columns


2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASURMENT. 

## Create a logicalVector that contains TRUE for the ID, mean() & stddev() columns & FALSE for others
## Subset final_data table based on the logicalVector to keep only desired columns


3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

## Merge the final_Data set with the acitivityType table to include descriptive activity names
## Updating the colNames vector to include the new column names after merge


4. APPROPRIATELY LABLES THE DATA SET WITH DESCRIPTIEV VARIABLE NAMES. 

## Labelling with appropriate names
   Using a for loop (to avoid redundancy) to rename the labels.
## Reassigning the new descriptive column names to the final_data set



5. CREATING A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE Of EACH VARIABLE FOR EACH 
   ACTIVITY AND EACH SUBJECT

## Create a new table, final_data_2 without the activity_type column
## Creating Tidy_data by summarizing as directed in the 5th objective  
## Merging & arranging the Tidy_Data with activity_type to include descriptive acitvity names
## Exporting the Tidy_Data set
## Viewing the Tidy_data set