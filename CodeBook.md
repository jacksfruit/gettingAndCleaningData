
Important notes:
- The original data consists of separate sets for training and test data. The information if the data was used as training or test data is discarded as both sets are merged and the data for the new data set is grouped by subject and activity.
- All data - except the activity descriptions which are strings - is imported as numerical data. No transformations are performed on the numerical data.
- Missing values are not treated separately. The data is not cleaned of any possible missing values.
- The original column names of the measured time and frequency domain variables from the original data are used for the derived variables of the new data set. This is done because of simplicity and the with the knowledge that all data transformations (i.e. the calculation of the mean values) occur within one variable and not across multiple variables.

Variables in the new data set:
- Subject: An identifier of the subject who carried out the experiment. Its range is from 1 to 30. 
- Activity: activity performed when measuring the data (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
The remaining variables contain the average (mean) of the measured time and frequency domain variables for each activity and each subject.
The acceleration signal from the smartphone accelerometer is in standard gravity units 'g'.
The units for the angular velocity vector measured by the gyroscope is radians/second. 
The following abbreviations are used in these variable names:
* The prefix 't' denotes time
* The prefix 'f' indicate frequency domain signals.
* 'Acc' stands for accelerometer 
* 'Gyro' stands for gyroscope
* 'mean()': Mean value
* 'std()': Standard deviation
* 'meanFreq()': Weighted average of the frequency components to obtain a mean frequency
* 'X', 'Y', 'Z': the 'X'-axis, the 'Y'-axis, and the 'Z'-axis

Processing the data. The following steps are carried out in order to get the tidy data set: 
0. Read the data.
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names provided in a separate file to name the activities in the data set
4. Label the data set with descriptive variable names. The original names are used.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. This data set contains one row for each combination of subject and activity.