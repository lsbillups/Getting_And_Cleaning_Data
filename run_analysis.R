# Set working directory
setwd("D:/R/Coursera GCD/")

# Step 1
# Merge the training and testing datasets

library(plyr)
library(dplyr)

# Load the training data
x_train<-read.table("./Project/UCI HAR Dataset/train/X_train.txt")

y_train<-read.table("./Project/UCI HAR Dataset/train/y_train.txt")
y_train<-rename(y_train,activity_labels = V1)

sub_train<-read.table("./Project/UCI HAR Dataset/train/subject_train.txt")
sub_train<-rename(sub_train, Subject = V1)

# Combine subject and activity with the training data
train_total<-cbind(sub_train,y_train,x_train)

# Load the testing data
x_test<-read.table("./Project/UCI HAR Dataset/test/X_test.txt")

y_test<-read.table("./Project/UCI HAR Dataset/test/y_test.txt")
y_test<-rename(y_test,activity_labels = V1)

sub_test<-read.table("./Project/UCI HAR Dataset/test/subject_test.txt")
sub_test<-rename(sub_test, Subject = V1)

# Combine subject and activity with the testing data
test_total<-cbind(sub_test,y_test,x_test)

# Merge training and testing data
total<-rbind(train_total,test_total)

# Step 2
# Extracts the measurements on the mean and standard deviation

# Extract the feature variables and we will use them later as the variable names for the datasets
features<-read.table("./Project/UCI HAR Dataset/features.txt",
                     as.is = TRUE)

# We will extract the features containing "mean()" and "std()" only
meancol<-grep("mean()",features[,2],ignore.case = TRUE)
stdcol<-grep("std()",features[,2],ignore.case = TRUE)
Mean_Std<-total[,c(1,2,meancol+2,stdcol+2)]
print(names(Mean_Std))

# Step 3
# Use descriptive activity names to name the activities

class(Mean_Std$activity_labels)
Mean_Std$activity_labels<-as.factor(Mean_Std$activity_labels)

# Relevel the activity factor
levels(Mean_Std$activity_labels)<-c("Walking","Walking_Upstairs",
                                    "Walking_Downstairs","Sitting",
                                    "Standing","Laying")
# Step 4
# Labels the data set with descriptive variable names
colnames(Mean_Std)[3:88]<-features[,2][c(meancol,stdcol)]

# Step 5
# Create another independent tidy dataset with
# the average of each variable for each activity and each subject
library(reshape2)
Mean_Std_Melt<-melt(Mean_Std,id = c("Subject","activity_labels"),
                    measure.vars = names(Mean_Std)[3:88])
tidydata1<-dcast(Mean_Std_Melt,Subject+activity_labels~variable,mean)
write.table(tidydata1,file = "ResultTidyData.txt",row.names = FALSE)

# # Another way
# tidydata2<-ddply(Mean_Std, .(Subject,activity_labels),
#                  .fun = function(df){colMeans(df[,3:88])})
# write.table(tidydata2,file = "ResultTidyData2.txt",row.names = FALSE)
