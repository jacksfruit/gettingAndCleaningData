# Course project for the "Getting and Cleaning Data" course (Coursera)

setwd("E:/Coursera_2014/Data_Science_Specialization/03_Getting_and_Cleaning_Data/Project")
if(!require(data.table)){install.packages("data.table")}


# 0. Read the data.

df_activities <- read.table("data/activity_labels.txt", colClasses = "character", header=FALSE)
df_features <- read.table("data/features.txt", colClasses = "character", header=FALSE)
df_trainingSubjects <- read.table("data/train/subject_train.txt", colClasses = "integer", header=FALSE)
  colnames(df_trainingSubjects) <- "subject"
df_trainingActivities <- read.table("data/train/y_train.txt", colClasses = "integer", header=FALSE)
  colnames(df_trainingActivities) <- "activityNum"
df_trainingData <- read.table("data/train/X_train.txt", colClasses = "numeric", header=FALSE)
df_testSubjects <- read.table("data/test/subject_test.txt", colClasses = "integer", header=FALSE)
  colnames(df_testSubjects) <- "subject"
df_testActivities <- read.table("data/test/y_test.txt", colClasses = "integer", header=FALSE)
  colnames(df_testActivities) <- "activityNum"
df_testData <- read.table("data/test/X_test.txt", colClasses = "numeric", header=FALSE)


# 1. Merge the training and the test sets to create one data set.

df_training <- cbind(df_trainingSubjects, 
                     df_trainingActivities,
                     df_trainingData)        ## combine training subject, activitiy and data to one data frame
df_test <- cbind(df_testSubjects, 
                 df_testActivities,
                 df_testData)                ## combine test subject, activity and data to one data frame
df_data <- rbind(df_training, df_test)       ## merge both sets to one data frame
rm(df_trainingSubjects, df_testSubjects, 
   df_trainingActivities, df_testActivities, 
   df_trainingData, df_testData, 
   df_training, df_test)                     ## cleanup unused variables after merge


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

filter_meanOrStd <- grep("mean|std", df_features[,2], value=FALSE)  ## get variable indices containing "mean" or "std" in their description
df_data.meanOrStd <- df_data[, c(1:2, 2+filter_meanOrStd)]   ## get subset of data frame (use "2+" as we added 2 columns earlier!)


# 3. Uses descriptive activity names to name the activities in the data set
 
df_data.meanOrStd[, "activityNum"] <- sapply(df_data.meanOrStd$activityNum, function(s) {df_activities[s, 2]}) ## translate activity
colnames(df_data.meanOrStd)[3] <- "activityStr"


# 4. Label the data set with descriptive variable names. 

colnames(df_data.meanOrStd) <- c("Subject", "Activity", df_features[filter_meanOrStd,2])
rm(df_data, df_activities, filter_meanOrStd) ## cleanup unused variables


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

dt_data <- data.table(df_data.meanOrStd) ## create a data table from the data frame in order to use expressions for column subsetting
dt_dataAverages <- dt_data[, lapply(.SD, mean), by=eval(colnames(dt_data)[1:2])]  ## group by columns 1 and 2, i.e. subject and activity
write.table(dt_dataAverages, file="tidy-data.txt", row.names=FALSE, col.names=TRUE, quote=FALSE)


