## Step 1 - Read all the data files in and assign names
ActLbls<-read.table("./UCI HAR Dataset/activity_labels.txt")
Features<-read.table("./UCI HAR Dataset/features.txt")
SubsTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(SubsTest)<-c("Subno")
XTest<-read.table("./UCI HAR Dataset/test/X_test.txt")
YTest<-read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(YTest)<-c("Activity")
SubsTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(SubsTrain)<-c("Subno")
XTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
YTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(YTrain)<-c("Activity")

## Step 1 continued - merge the data sets
## Make sure dplyr is loaded
tidyData1<-cbind(SubsTest, XTest)
tidyData2<-cbind(tidyData1, YTest)
tidyData3<-cbind(SubsTrain,XTrain)
tidyData4<-cbind(tidyData3,YTrain)
library(dplyr)

## Step 2 - subset mean and standard deviation variables.
largeData<-rbind(tidyData2,tidyData4)
tidyData<-select(largeData, c(Subno, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, 
                              V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, 
                              V345:V350, V424:V429, V503:V504, V516:V517, V529:V530, 
                              V542:V543, Activity))

## Step 3 - Use descriptive activity names to name the activities in the data set.
tidyFrame<-data.frame(tidyData)
colnames(ActLbls)<-c("Activity","Activity_Name")
activFrame<-data.frame(ActLbls)
tidyData2<-arrange(join(tidyFrame,activFrame),Activity)

## Step 4 - Create and assign vector of activity names for variables
## retained in the data set in order to label them.
colnames(tidyData2)<-c("SubNo", "tBodyAccmeanX", "tBodyAccmeanY", "tBodyAccmeanZ",
  "tBodyAccstdX", "tBodyAccstdY", "tBodyAccstdZ", "tGravityAccmeanX", 
  "tGravityAccmeanY", "tGravityAccmeanZ", "tGravityAccstdX", "tGravityAccstdY",
  "tGravityAccstdZ", "tBodyAccJerkmeanX", "tBodyAccJerkmeanY", 
  "tBodyAccJerkmeanZ", "tBodyAccJerkstdX", "tBodyAccJerkstdY", "tBodyAccJerkstdZ",
  "tBodyGyromean", "tBodyGyromeanY", "tBodyGyromeanZ", "tBodyGyrostdX", 
  "tBodyGyrostdY", "tBodyGyrostdZ", "tBodyGyroJerkmeanX", "tBodyGyroJerkmeanY",
  "tBodyGyroJerkmeanZ", "tBodyGyroJerkstdX", "tBodyGyroJerkstdY", "tBodyGyroJerkstdZ",
  "tBodyAccMagmean","tBodyAccMagstd", "tGravityAccMagmean", "tGravityAccMagstd", 
  "tBodyAccJerkMagmean", "tBodyAccJerkMagstd", "tBodyGyroMagmean", "tBodyGyroMagstd", 
  "tBodyGyroJerkMagmean", "tBodyGyroJerkMagstd", "fBodyAccmeanX", "fBodyAccmean", 
  "fBodyAccmeanZ", "fBodyAccstdX", "fBodyAccstdY", "fBodyAccstdZ", "fBodyAccJerkmeanX", 
  "fBodyAccJerkmeanY", "fBodyAccJerkmeanZ", "fBodyAccJerkstdX", "fBodyAccJerkstdY", 
  "fBodyAccJerkstdZ", "fBodyGyromeanX", "fBodyGyromeanY", "fBodyGyromeanZ", 
  "fBodyGyrostdX", "fBodyGyrostdY", "fBodyGyrostdZ", "fBodyAccMagmean", 
  "fBodyAccMagstd", "fBodyBodyAccJerkMagmean", "fBodyBodyAccJerkMagstd", 
  "fBodyBodyGyroMagmean", "fBodyBodyGyroMagstd", "fBodyBodyGyroJerkMagmean", 
  "fBodyBodyGyroJerkMagstd", "Activity", "Activity_Name")

## Step 5 - Extract mean for each variable, for each activity and for each subject.
library(reshape2)
library(plyr)
## Melt data to get groupings
meltedData=melt(tidyData2,id.var=c("SubNo","Activity"))
## Compute means for each subject for each activity
gpMeans=dcast(meltedData,SubNo+Activity~variable, mean)
## So that it lists activity
tidyMeans<-arrange(join(gpMeans,activFrame),Activity)

#  Write the file for submission
write.table(tidyMeans,file="~/tidy_data.txt",row.names=FALSE)

