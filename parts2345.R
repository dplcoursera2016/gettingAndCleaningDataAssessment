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