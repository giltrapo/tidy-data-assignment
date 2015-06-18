# Introduction

This repository contains the material and information needed to replicate the course project "Getting and Cleaning Data" from Coursera.

You can find the following files:

* *README.md*: The file you are reading right now. It contains information about the project dataset, and shows the process followed using R to clean the data set and build a new tidy data set.
* *Run_analysis.R*: It is a script that run in R all the steps to clean up the data and build the data set required from the project.
* *Tidydataset.txt*: Data set created with the script *run_analysis.R*.
* *CodeBook.md*: List and description of the variables in the data set *tidydataset.txt*.



# Data collection

The script contained in the file *run_analysis.R* take for granted that you have the UCI data set in your working directory, and does not include the code for downloading it. However, you can use the following code if you have not already done so:

	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

	## Download the .zip file for Mac users
	download.file (fileURL, destfile = "./ dataset.zip" method = "curl")

	## Download the .zip file for Windows users. This method works correctly
	## With R version 3.2.0 (16/04/2015) - "Full of Ingredients", and RStudio Version 0.99.442
	download.file (fileURL, destfile = "./ dataset.zip" method = "libcurl")

When you have the UCI data set in your working directory, you have to unzip the file with the following code:

	unzip ("dataset.zip")

You will find a folder called *UCI HAR Dataset* that have all the necessary files that you need to work with. **Important: this folder has to be in your working directory in order to run the script *Run_analysis.R*.**

# About the data set

The *UCI HAR Dataset* folder contains data of an experiment with 30 participants, between 19 and 48 years old, who performed activities (walking straight, walking upstairs and downstairs, sit down, stand and lie down) while carrying a Samsung Galaxy S II mobile attached to the waist, that collected data about the acceleration and angular velocity of the participants while performing such activities. The objective of this experiment focused on trying to predict the activity that each participant was performing from the data collected by the smartphone. For this reason they divided the data into two groups, one with 70% of the participants, which was used to train predictive models, and another one with the remaining 30%, which was used to test the accuracy of the models.

# Cleaning and tidying data

The project has five points to resolve:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

I have divided the whole process to reach point 5 in a set of consecutive steps. Here you can read the explication of steps and *Run_analysis.R* script give you the code to run each one of them.


### 1. Merging the training and the test sets to create one data set.
##### Step 1
File *README.txt* shows that training and test data sets are placed into the *train* and *test* folders, and they are named *X_train.txt* and *X_test.txt*. Open them and create `data.frame` objects called *trainset* and *testset*. The object *trainset* has 7,352 rows and 561 columns. The object *testset* has 2,947 rows and 561 columns. The columns of both data frames do not have descriptive names in the header, only the letter V followed by the column number.

##### Step 2
Open the file *features.txt*, which contains the variable's names of *trainset* and *testset* data frames, and create a `data.frame` object called *varnames*, which has 561 rows and 2 columns. The rows correspond to the number of columns that have *trainset* and *testset* objects. The first column contains a sequence of numbers from 1 to 561, and the second the descriptive texts of all 561 variables.

##### Step 3
Use data in the second column of the object *varnames* to name the columns of objects *trainset* and *testset*. To make this operation assume that the order of the rows of *varnames* match with the order of the columns of *trainset* and *testset* so that the text in row 1 is the name that goes in column 1, the text of row 2 is the name that goes in column 2, etc.

Now let's add a column that identifies the subject and another to identify the activities that they performed.

##### Step 4
Into *train* and *test* folders you’ll find *subject_train.txt* and *subject_test.txt* files. Open them and create `data.frame` objects called *subject_train* and *subject_test*, with 7,352 rows and 2,947 rows respectively. Both have a single column, with not descriptive name, that show the id of the participant. We then label the column of both objects as *subject*.

##### Step 5
Open *y_train.txt* and *y_test.txt* files and create `data.frame` objects called *activity_train* and *activity_test*, which also have 7,352 rows and 2,947 rows respectively, and a single column without descriptive name that indicates the id of the activity. We then label the column of both objects as *activity*.

##### Step 6
The object *trainset* has 7,352 rows with data about 561 variables, but we do not know to whom they belong. To identify these rows we have to add *subject_train*'s *subject* column and *activity_train*'s *activity* column. As we have not an id to link rows of these three data frames, let's assume that they are sorted so that the rows of data frames match each other. We perform the operation with `cbind` function, and get a data frame with 7,352 rows and 563 columns called *traindb*.

Do the same with the data frames *subject_test*, *activity_test* and *testset*, and obtain the `data.frame` object *testdb*.

##### Step 7
Now we have two data frames with different number of rows, but the same number of columns, and we want to join them so the columns match each other. The goal is to obtain a data frame with the sum of the rows of both objects. We use `rbind` function to do this, and finally we obtain a `data.frame` object, with 10,299 rows and 563 columns, called *totaldb*.


### 2. Extracting only the measurements on the mean and standard deviation for each measurement.
In the *features_info.txt* file we can read the following text:

> The set of variables That Were Estimated from these signals are:

> Mean (): Mean value  
std (): Standard deviation  
mad (): Median absolute deviation  
max (): Largest value in array  
min (): Smallest value in array  
sma (): Signal magnitude area  
energy (): Energy measure. Sum of the squares divided by the number of values.  
iqr (): interquartile range  
entropy (): Signal entropy  
arCoeff (): With Burg order autoregression coefficients equal to 4  
correlation (): Between two signals correlation coefficient  
maxInds (): index of the largest magnitude frequency component With  
meanFreq (): Weighted average of the frequency components to Obtain a mean frequency  
skewness (): skewness of the frequency domain signal  
kurtosis (): kurtosis of the frequency domain signal  
bandsEnergy (): Energy of a frequency interval Within the 64 bins of the FFT of each window.  
angle (): Angle Between to vectors.  

##### Step 8
Count variable labels with text string *mean()* or *std()*. There are 33 of each of them. For each variable with text string *mean()* there is another identical but with text string *std()*. This makes sense, because when you are analysing a variable, you frequently need a measure of central tendency, like the mean, and other measures of dispersion, such as the standard deviation.

We also see that for certain columns is calculated something called *meanFreq()*. This is a kind of weighted average. These estimates are not accompanied by a measure of dispersion, such a standard deviation. These do not seem to be some kind of measurement of central tendency like variables with text string *mean()*, so we are not going to select them.

Therefore, we only keep 66 variables with texts *mean()* and *std()*, and get a `data.frame` object, with 10,299 rows and 68 columns, which we call *selectdb*.


### 3. Using activity descriptive names to name the activities in the data set
##### Step 9
Open the file *activity_labels.txt*, using the `stringsAsFactors = false` to ensure that texts are not interpreted as a factor, and create a ` data.frame` object called *activity_labels* which has 6 rows and 2 columns, with no labels. The first column, V1, contains a sequence of numbers from 1 to 6, which correspond to each of the six activities that the participants performed. The second column contains the text description of each one of them.

##### Step 10
We use this data frame as a template to replace the levels of *activity* in the data frame *selectdb* by the text description of the activity.


### 4. Appropriately labeling the data set with descriptive variable names.
##### Step 11
Clean the labels of variables, removing the parentheses and replacing hyphens and commas by dots.


### 5. From the data set in step 4 creating a second, independent tidy data set with the average of each variable for each activity and each subject.
##### Step 12
Before starting this task, we will get a two way table with *activity* and *subject* variables, from the *selectdb* data frame. The resulting table shows how many lines of data were collected for each participant in each of the activities performed. Thus, for participant 1 and activity "LAYING", 50 rows of data were collected, for participant 2 48 rows were collected, for participant 3 62 rows were collected, etc. This meaning that the participant 1 has, for the "LAYING" activity, 50 values in each of the 66 *mean()* or *std()* variables.

Our goal is that the participant 1, on "LAYING" activity, has the average value of those 50 values in each of the 66 variables. And the same for the other participants and activities.

##### Step 13
As 30 people participated in the experiment, and each carried out six activities, we should get a data frame with 180 rows, one for each person and activity combination. To do this we use the `aggregate` function and create a new `data.frame` object called *tidydb*.

##### Step 14
Finally, given that the data contained in the new data frame are averages calculated from the original data, we will rename all variable names by adding *Avg* at the end of each label.

---

### Appendix: Understanding the relationship between Inertial Signals and 561-feature vector

In this project it was not necessary to use the data contained in the *Inertial Signals* folder, but you should understand its relationship with data files *X_test.txt* and *X_train.txt*.

Take, for example, how we calculated the values of the first variable of 561-feature vector, *tBodyAcc-mean-X()*, from the files contained in *Inertial Signals* folder.

*tBodyAcc-mean-X()* variable from the *totaldb* data frame has 10,299 rows, that is, 10,299 values. Each of them is the average of all readings of the body acceleration of the participants in the X axis along a sliding windows of 2.56 seconds and 50% overlap (128 readings/windows).

Data of the body acceleration on the X axis are *body_acc_x_train.txt* and *body_acc_x_test.txt* files. We read them and create two `data.frames` objects called *body_acc_x_train* and *body_acc_x_test", which have 7,352 rows and 2,947 rows, respectively. The number of columns of both objects is 128, which correspond to the number of readings that were made in that sliding window of 2.56 seconds. We join both objects, by matching columns, and obtain a `data.frame` object called *body_acc_x*, which have 10,299 rows and 128 columns. Here is the code to run this:

	body_acc_x_test = read.table ("UCI ./ HAR Dataset / test / Inertial Signals / body_acc_x_train.txt")
	body_acc_x_train = read.table ("UCI ./ HAR Dataset / train / Inertial Signals / body_acc_x_test.txt")
	body_acc_x = rbind (body_acc_x_train, body_acc_x_test)
	dim (body_acc_x)

Now we calculate the mean of the rows and create a data frame with these averaged values. Then label the column as *body_acc_x_mean*.

	body_acc_x_mean <- as.data.frame (x = apply (body_acc_x 1, mean))
	names (body_acc_x_mean) <- "body_acc_x_mean"

Then we normalize these values in the range -1 and 1, and create a column called *body_acc_x_mean_norm* with this values.

	body_acc_x_mean$body_acc_x_mean_norm = 2 * (body_acc_x_mean [1] - min (body_acc_x_mean [1])) / (max (body_acc_x_mean[1]) - min(body_acc_x_mean [1])) - 1

The data of *body_acc_x_mean_norm* should match with the data in *tBodyAcc-mean-X()* from the the data frame *totaldb*. We add that column to *body_acc_x* and compare them:

	body_acc_x_mean$body_acc_x_mean_norm2 = totaldb[3]

The values match each one, although there is some rounding issues.

As seen above, the variable *tBodyAcc-mean-X()* is obtained by calculating the mean of the 128 body acceleration values in the X axis and then standardizing them. The same is done with the data of Y and Z axes, and so with data related to gravity and the angular velocity. In addition to the averages, another estimations like standard deviations, medians, maximum values, minimum values, etc, are calculated. In some cases, instead of calculating these statistics directly on the variables *body_acc*, *body_gyro* and *total_acc*, some transformation on them are performed, such as calculating their derivatives over time, the Fast Fourier Transform (FFT) or the Euclidean Norm.



















