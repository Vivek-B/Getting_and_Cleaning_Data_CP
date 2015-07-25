## Please unzip the data file and place the 'UCI HAR Dataset' folder in the working directory
## Load the 'dplyr' package, it is used of chaining functions.
library(dplyr)

## Reading the data from files
## Extract features.txt
features <- read.table("UCI HAR Dataset/features.txt");
activity_type <- read.table("UCI HAR Dataset/activity_labels.txt"); 
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt"); 
x_train <- read.table("UCI HAR Dataset/train/x_train.txt"); 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt"); 

# Assigning column names to the data extracted above
colnames(activity_type)  <- c("activityId","activityType");
colnames(subject_train)  <- "subjectId";
colnames(x_train) <- features[,2]; 
colnames(y_train) <- "activityId";

## Generating training data set by merging y_train, subject_train, and x_train by column
training_data <- cbind(y_train,subject_train,x_train);

# Extracting in the test data
## Imports subject_test.txt
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt"); 
x_test <- read.table("UCI HAR Dataset/test/x_test.txt"); 
y_test <- read.table("UCI HAR Dataset/test/y_test.txt"); 

# Naming the columns of the test data
colnames(subject_test) <- "subjectId";
colnames(x_test) <- features[,2]; 
colnames(y_test) <- "activityId";


# Creating test data by merging y_test, subject_test data & x_test
test_data <- cbind(y_test,subject_test,x_test);


# Merge training and test data by rows to create a final data set
final_data <- rbind(training_data,test_data);

# Create a vector for the column names from the final_data, which will be used
# to select the desired mean() & stddev() columns
colNames  <- colnames(final_data); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE for the ID, mean() & stddev() columns & FALSE for others
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & 
                !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                !grepl("-std()..-",colNames));

# Subset final_data table based on the logicalVector to keep only desired columns
final_data <- final_data[logicalVector==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the final_Data set with the acitivityType table to include descriptive activity names
final_data <- merge(final_data,activity_type,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  <- colnames(final_data); 

# 4. Appropriately label the data set with descriptive activity names. 

# Labelling with appropriate names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the final_data set
colnames(final_data) <- colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, final_data_2 without the activity_type column
final_data_2 <- final_data[,names(final_data) != 'activityType'];

# Summarizing the final_data_2 table to include just the mean of each variable for each activity and each subject
Tidy_Data <- aggregate(final_data_2[,names(final_data_2) 
              != c('activityId','subjectId')],
              by=list(activityId=final_data_2$activityId,
                      subjectId = final_data_2$subjectId),mean) 

# Merging & arranging the Tidy_Data with activity_type to include descriptive acitvity names
Tidy_Data <- Tidy_Data %>% merge(activity_type,by='activityId',all.x=TRUE) %>% arrange(activityId, subjectId)

# Export the Tidy_Data set 
write.table(Tidy_Data, 'Tidy_Data.txt',row.names=TRUE,sep='\t');

View(Tidy_Data)