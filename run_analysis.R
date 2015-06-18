## 1. Merging the training and the test sets to create one data set

## Step 1
## Read X_test.txt and X_train.txt files
testset = read.table("./UCI HAR Dataset/test/X_test.txt")
trainset = read.table("./UCI HAR Dataset/train/X_train.txt")
## Check dimensions
dim(testset)
dim(trainset)
## Check data frame visually
View(testset)
View(trainset)


## Step 2
## Read features.txt file
varnames = read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
## Check dimensions
dim(varnames)
## Check data frame visually
View(varnames)


## Step 3
## Assign names in the second column of varnames data frame
## to columns of testset and trainset data frames
names(testset) <- varnames[,2]
names(trainset) <- varnames[,2]
## Check names of testset and trainset data frames
names(testset)
names(trainset)


## Step 4
## Read subject_test.txt and subject_train.txt files
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")
## Check dimensions
dim(subject_test)
dim(subject_train)
## Add variable labels
names(subject_test) <- "subject"
names(subject_train) <- "subject"


## Step 5
## Read activity_test.txt and activity_train.txt files
activity_test = read.table("./UCI HAR Dataset/test/y_test.txt")
activity_train = read.table("./UCI HAR Dataset/train/y_train.txt")
## Check dimensions
dim(activity_test)
dim(activity_train)
## Add variable labels
names(activity_test) <- "activity"
names(activity_train) <- "activity"


## Step 6
## Merge, by matching rows, subject_test, activity_test and testset data frames
testdb = cbind(subject_test, activity_test, testset)
## Merge, by matching rows, subject_train, activity_train and trainset data frames
traindb = cbind(subject_train, activity_train, trainset)


## Step 7
## Merge, by matching columns, testdb and traindb data frames
totaldb = rbind(testdb, traindb)



## 2. Extracting only the measurements on the mean and standard deviation
## for each measurement.

## Step 8
## Add up variable names with "mean()" and "std()" strings 
sum(grepl("\\<mean\\>", names(totaldb)))
sum(grepl("\\<std\\>", names(totaldb)))
## Select columns with labels containing "mean()" or "std()" strings 
selectdb <- totaldb[, c("subject", "activity", 
                    names(totaldb)[grepl("\\<mean\\>|\\<std\\>",
                                         names(totaldb))])]


## 3. Using descriptive activity names to name the activities in the
## data set

## Step 9
## Read activity_labels.txt file
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", 
                             stringsAsFactors = FALSE)


## Step 10
## Replace activity levels in selectdb data frame with text
## description of activity
selectdb$activity[selectdb[,2] == activity_labels[1,1]] <- activity_labels[1,2]
selectdb$activity[selectdb[,2] == activity_labels[2,1]] <- activity_labels[2,2]
selectdb$activity[selectdb[,2] == activity_labels[3,1]] <- activity_labels[3,2]
selectdb$activity[selectdb[,2] == activity_labels[4,1]] <- activity_labels[4,2]
selectdb$activity[selectdb[,2] == activity_labels[5,1]] <- activity_labels[5,2]
selectdb$activity[selectdb[,2] == activity_labels[6,1]] <- activity_labels[6,2]



## 4. Appropriately labeling the data set with descriptive variable names. 

## Step 11
## Remove or replace some characters in selectdb variable names
names(selectdb) <- gsub( "\\(|\\)" , "" , names(selectdb))
names(selectdb) <- gsub( "\\-|\\," , "." , names(selectdb))



## 5. From the data set in step 4, creating a second, independent tidy
## data set with the average of each variable for each activity and
## each subject.

## Step 12
## create a two way table with activity and subject variables
table(selectdb$activity, selectdb$subject)


## Step 13
## Create a new data frame with the average of each variable for each
## activity and each subject
tidydb <- aggregate(.~subject + activity, selectdb, mean)


## Step 14
## Add ".Avg" termination to features variable names
names(tidydb)[3:68] <- paste(names(tidydb)[3:68], ".Avg", sep = "")


## Step 15
## Save tidydb in a txt file
write.table(tidydb, "tidydb.txt", row.names=FALSE)
