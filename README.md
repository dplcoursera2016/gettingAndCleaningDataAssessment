This is a repository for Assignment for the Getting and Cleaning module on 
the John Hopkins University Data Science 
specialisation. Github username is dplcoursera2016

Created a single R script called run_analysis.R that does the following. 

1.Merged the training and the test sets to create one data set.

Read in all necessary data from folder called "UCI HAR Dataset" in the working directory
8 files read using read.table
test/X_test.txt    and   train/X_train.txt
train/subject_train.txt    and   test/subject_test.txt
train/y_train.txt    and   test/y_test.txt
activity_labels.txt
features.txt

Using data frame holding activity_labels.txt data, created a function to convert activity code to activity name
and add columns containing activity description to Activity data 

Created a vector of column titles using data from features.txt
and added column names to 6 individual data frames holding the test and train data  

merged (subject,activity,data) for test batch and train batch using cbind
merged test and train data into one data frame using rbind
Result was a data frame called "allData" representing solution to part 1 of assessment



Parts 2-5 are explained below:

2.Extracted only the measurements on the mean and standard deviation for each measurement. 
3.Used descriptive activity names to name the activities in the data set
4.Appropriately labelled the data set with descriptive variable names. 

created a logical vector to pick out subject, activity and all columns with mean() and std() in them

extracted subset of data frame with columns holding subject, activity and all columns with mean() and std() in them
data frame called "thedata" was result of this, and is solution to Parts 2,3,4 of exercise

5.From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.
created a new variable in the form subject.activity, and add to the data
used subject.activity to split data into list (called f) of data frames according to distict subject.activity

created a data frame to hold answer for part 5

Started by adding three columns with subject, activity code and activity description, 
used three for-loops that extracted first row of 1st, 2nd, 3rd columns respectively from each data frame 
in the the "by subject/by activity" list

Then used two nested for-loops:
outer loop iterated through all (mean/std) data columns, 
{ inner loop iterated through all data frames in the "by subject/by activity" list
calculating avarage of mean/std data column in that sub-frame (col numbers 4 to 69),
Result was a column of averages (by subject and activity) for that measurement, which was 
(one column per variable) to the final data frame using cbind} 

lastly, add variable names to final data frame, and output using write.table to part5.txt
