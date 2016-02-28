## Code assumes zipped data files were saved in working directory, and unzipped in folder UCI HAR Dataset
## if not then un-comment following two lines
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata_projectfiles_UCI HAR Dataset.zip")
#unzip("getdata_projectfiles_UCI HAR Dataset.zip")

## Read in all necessary data
testData = read.table("UCI HAR Dataset/test/X_test.txt")
trainData = read.table("UCI HAR Dataset/train/X_train.txt")
trainSubject = read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject = read.table("UCI HAR Dataset/test/subject_test.txt")
trainAct = read.table("UCI HAR Dataset/train/y_train.txt")
testAct = read.table("UCI HAR Dataset/test/y_test.txt")
activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")
features = read.table("UCI HAR Dataset/features.txt")

## function used to give activity name from input activity code
activity = function (x){ activityLabels[x,2] }
## add columns containing activity description to Activity data 
testAct=cbind(testAct,sapply(testAct,activity))
trainAct=cbind(trainAct,sapply(trainAct,activity))


## create vector of column titles using data from features.txt
featureNames=as.character(features[,2])
## add column names to data frames 
names(testData) = featureNames
names(trainData) = featureNames
names(testSubject)=c("subject")
names(trainSubject)=c("subject")
names(trainAct)=c("activity.code","activity")
names(testAct)=c("activity.code","activity")

## merge (subject,activity,data) for test batch and train batch
test = cbind(testSubject,testAct,testData)
train = cbind(trainSubject,trainAct,trainData)

## merge test and train data into one data frame
## allData is solution to Part 1 of exercise
allData = rbind(test,train)



## logical vector to pick out subject, activity and all columns with mean() and std() in them
pickCols = grepl("subject|activity|mean[()]|std[()]", names(allData))
## extract subset with subject, activity and all columns with mean() and std() in them
## thedata is solution to Parts 2,3,4 of exercise
thedata=allData[,pickCols]

##library(dplyr)
##library(plyr)
## create a new variable in the form subject.activity, and add to the data
sa=as.factor(paste0(as.character(thedata$subject),".",as.character(thedata$activity)))
thedata2=cbind(thedata,subject.activity=sa)

## split data into groups according to distict subject.activity
f=split(thedata2,thedata2$subject.activity)

## create a data frame to hold answer for part 5
part5=data.frame()
## add three columns with subject, activity code and activity description
for(i in 1:length(f)){ part5[i,1]=as.data.frame(f[i])[1,1] }
for(i in 1:length(f)){ part5[i,2]=as.data.frame(f[i])[1,2] }
for(i in 1:length(f)){ part5[i,3]=as.data.frame(f[i])[1,3] }

## add columns where averages of all variables are calculated for each subject and activity
for (x in 4:69){
    q=vector()
    for(i in 1:length(f)){
        q[i]=mean(as.data.frame(f[i])[,x])    
    }
    part5=cbind(part5,q)
}
## add variable names to final data frame
names(part5) = names(thedata)
## part5 is solution to Part 5 of exercise
write.table(part5,"part5.txt", sep = " ", row.name = FALSE)