# *tidydb.txt*'s CodeBook

This codebook list and explain the variables shown in the data set *tidydb.txt*, which has been created as part of *Getting and Cleaning Data* Course Project, that offers Coursera.

*tidydb.txt* data set has been created from data collected from an experiment in which 30 participants, between 19 and 48 years old, performed activities (walking straight, walking upstairs and downstairs, sit down, stand and lie down) while carrying a Samsung Galaxy S II mobile attached to the waist, that collected data about the acceleration and angular velocity of the participants while performing such activities.

*tidydb.txt* data set has 68 variables, of which the first two are used to identify participant and activity. The others 66 variables are part of a 561-feature vector with time and frequency domain variables from the original data set.

All of these 66 variable originate from three processed 3-axial signals captured from the smartphone's accelerometer and gyroscope. Two of them comes from the accelerometer and the last one from the gyroscope.

Variable names are formed by text strings with its own meaning:

* All 66 variables have the string "Avg" for average, at the end of the label, because all of them are averages resulting from original values for a participant and an activity combination.
* The first letter of the variables is always "t", for time domain, or "f", for frequency domain.
* There are three main signals: "BodyAcc" for body acceleration signal, "GravityAcc" for gravity acceleration signal and "BodyGyro" for angular velocity.
* For "BodyAcc" and "BodyGyro" you can find the string "Jerk", meaning that the signal was derived in time to obtain jerk signal.
* Also, you can find "Mag", meaning that magnitude was calculated using the Euclidean Norm.
* The letters "X", "Y" and "Z" stand for the three dimensional axes. All variables are repeated three times, one for each letter, except those with "Mag" suffix.
* Finally, "mean" or "std" indicate whether the original variable was a mean value or standard deviation value, although all values were normalized in the range -1 to 1. Each variable has two values: mean and standard deviation.

List of variables:

| Variable name | Descriptions |Unit of measurement |
| ----------| ---------- | ---------- |
| subject | Participant ID |Integers from 1 to 30 identifiying participants |
| activity | Activity description |Factor with 6 levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS and WALKING_UPSTAIRS |
| tBodyAcc.mean.X.Avg | Average of body acceleration in X axe means |Normalized values bounded within -1 and 1 |
| tBodyAcc.mean.Y.Avg | Average of body acceleration in Y axe means |Normalized values bounded within -1 and 1 |
| tBodyAcc.mean.Z.Avg | Average of body acceleration in Z axe means |Normalized values bounded within -1 and 1 |
| tBodyAcc.std.X.Avg | Average of body acceleration in X axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAcc.std.Y.Avg | Average of body acceleration in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAcc.std.Z.Avg | Average of body acceleration in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| tGravityAcc.mean.X.Avg | Average of gravity acceleration in X axe means |Normalized values bounded within -1 and 1 |
| tGravityAcc.mean.Y.Avg | Average of gravity acceleration in Y axe means |Normalized values bounded within -1 and 1 |
| tGravityAcc.mean.Z.Avg | Average of gravity acceleration in Z axe means |Normalized values bounded within -1 and 1 |
| tGravityAcc.std.X.Avg | Average of gravity acceleration in X axe standard deviations |Normalized values bounded within -1 and 1 |
| tGravityAcc.std.Y.Avg | Average of gravity acceleration in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| tGravityAcc.std.Z.Avg | Average of gravity acceleration in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.mean.X.Avg | Average of time derivative of body acceleration in X axe means |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.mean.Y.Avg | Average of time derivative of body acceleration in Y axe means |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.mean.Z.Avg | Average of time derivative of body acceleration in Z axe means |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.std.X.Avg | Average of time derivative of body acceleration in X axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.std.Y.Avg | Average of time derivative of body acceleration in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAccJerk.std.Z.Avg | Average of time derivative of body acceleration in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyro.mean.X.Avg | Average of body angular velocity in X axe means |Normalized values bounded within -1 and 1 |
| tBodyGyro.mean.Y.Avg | Average of body angular velocity in Y axe means |Normalized values bounded within -1 and 1 |
| tBodyGyro.mean.Z.Avg | Average of body angular velocity in Z axe means |Normalized values bounded within -1 and 1 |
| tBodyGyro.std.X.Avg | Average of body angular velocity in X axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyro.std.Y.Avg | Average of body angular velocity in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyro.std.Z.Avg | Average of body angular velocity in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.mean.X.Avg | Average of time derivative of body angular velocity in X axe means |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.mean.Y.Avg | Average of time derivative of body angular velocity in Y axe means |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.mean.Z.Avg | Average of time derivative of body angular velocity in Z axe means |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.std.X.Avg | Average of time derivative of body angular velocity in X axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.std.Y.Avg | Average of time derivative of body angular velocity in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyroJerk.std.Z.Avg | Average of time derivative of body angular velocity in Z axe standard deviation |Normalized values bounded within -1 and 1 |
| tBodyAccMag.mean.Avg | Average of magnitude of body acceleration means |Normalized values bounded within -1 and 1 |
| tBodyAccMag.std.Avg | Average of magnitude of body acceleration standard deviations |Normalized values bounded within -1 and 1 |
| tGravityAccMag.mean.Avg | Average of magnitude of gravity acceleration means |Normalized values bounded within -1 and 1 |
| tGravityAccMag.std.Avg | Average of magnitude of gravity acceleration standard deviations |Normalized values bounded within -1 and 1 |
| tBodyAccJerkMag.mean.Avg | Average of magnitude of time derivative body acceleration means |Normalized values bounded within -1 and 1 |
| tBodyAccJerkMag.std.Avg | Average of magnitude of time derivative body acceleration standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyroMag.mean.Avg | Average of magnitude of body angular velocity means |Normalized values bounded within -1 and 1 |
| tBodyGyroMag.std.Avg | Average of magnitude of body angular velocity standard deviations |Normalized values bounded within -1 and 1 |
| tBodyGyroJerkMag.mean.Avg | Average of magnitude of time derivative body angular velocity means |Normalized values bounded within -1 and 1 |
| tBodyGyroJerkMag.std.Avg | Average of magnitude of time derivative body angular velocity standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAcc.mean.X.Avg | Average of body acceleration in frecuency domain in X axe means |Normalized values bounded within -1 and 1 |
| fBodyAcc.mean.Y.Avg | Average of body acceleration in frecuency domain in Y axe means |Normalized values bounded within -1 and 1 |
| fBodyAcc.mean.Z.Avg | Average of body acceleration in frecuency domain in Z axe means |Normalized values bounded within -1 and 1 |
| fBodyAcc.std.X.Avg | Average of body acceleration in frecuency domain in X axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAcc.std.Y.Avg | Average of body acceleration in frecuency domain in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAcc.std.Z.Avg | Average of body acceleration in frecuency domain in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.mean.X.Avg | Average of frecuency derivative of body acceleration in X axe means |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.mean.Y.Avg | Average of frecuency derivative of body acceleration in Y axe means |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.mean.Z.Avg | Average of frecuency derivative of body acceleration in Z axe means |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.std.X.Avg | Average of frecuency derivative of body acceleration in X axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.std.Y.Avg | Average of frecuency derivative of body acceleration in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAccJerk.std.Z.Avg | Average of frecuency derivative of body acceleration in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyGyro.mean.X.Avg | Average of body angular velocity in frecuency domain in X axe means |Normalized values bounded within -1 and 1 |
| fBodyGyro.mean.Y.Avg | Average of body angular velocity in frecuency domain in Y axe means |Normalized values bounded within -1 and 1 |
| fBodyGyro.mean.Z.Avg | Average of body angular velocity in frecuency domain in Z axe means |Normalized values bounded within -1 and 1 |
| fBodyGyro.std.X.Avg | Average of body angular velocity in frecuency domain in X axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyGyro.std.Y.Avg | Average of body angular velocity in frecuency domain in Y axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyGyro.std.Z.Avg | Average of body angular velocity in frecuency domain in Z axe standard deviations |Normalized values bounded within -1 and 1 |
| fBodyAccMag.mean.Avg | Average of magnitude of body acceleration in frecuency domain means |Normalized values bounded within -1 and 1 |
| fBodyAccMag.std.Avg | Average of magnitude of body acceleration in frecuency domain standard deviations |Normalized values bounded within -1 and 1 |
| fBodyBodyAccJerkMag.mean.Avg | Average of magnitude of frecuency derivative body acceleration means |Normalized values bounded within -1 and 1 |
| fBodyBodyAccJerkMag.std.Avg | Average of magnitude of frecuency derivative body acceleration standard deviations |Normalized values bounded within -1 and 1 |
| fBodyBodyGyroMag.mean.Avg | Average of magnitude of body angular velocity in frecuency domain means |Normalized values bounded within -1 and 1 |
| fBodyBodyGyroMag.std.Avg | Average of magnitude of body angular velocity in frecuency domain standard deviations |Normalized values bounded within -1 and 1 |
| fBodyBodyGyroJerkMag.mean.Av | Average of magnitude of frecuency derivative body angular velocity means |Normalized values bounded within -1 and 1 |
| fBodyBodyGyroJerkMag.std.Avg | Average of magnitude of frecuency derivative body angular velocity standard deviations |Normalized values bounded within -1 and 1 |

