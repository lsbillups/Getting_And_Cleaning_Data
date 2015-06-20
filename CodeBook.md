# Overview of the data cleaning process

The data cleaning process performed in 'run_analysis.R' contains 5 steps in total.

* First, we load both training and testing dataset into R. And for both training and testing dataset,
we associate them with the corresponding subjects and activities. Finally, we merge training and testing
datasets together using the 'rbind()' function.

* Second, we extract the features contains only "mean()" and "std()" meaning that we only
care about the measurements on the mean and standard deviation. 'Mean_Std' is the data.frame
contains only those columns.

* Third, we coerce the activities back to their descriptive names by releveling the factor variable.

* Fourth, similar to step 3, we use more descriptive names for the variable names so that they are more humanly readable.

* Fifth, for each variable included in 'Mean_Std', we find the average value for each subject on each activity.
And then, we create an independent data set named 'ResultTidydata.txt'. The newly-created tidy dataset meets all the tidy data principles, 
namely each variable measured should be in one column, each different observation of that variable should be in a different row.

# Variables description

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

For each variable list above, the tidy dataset contains the corresponding mean for the mean and standard deviation. 
If the variable contains xyz three directions, then the mean is for each direction.

Besides, we also include the mean for angle which contains mean vectors. They are as follows.

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean