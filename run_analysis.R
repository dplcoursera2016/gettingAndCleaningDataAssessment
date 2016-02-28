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