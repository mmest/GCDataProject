#CODE BOOK

Author: Marco Mesturino, November 2014. 

This is the code book file for the my _Getting and Cleaning Data_ course project by Coursera. 

## Original data set

The [original data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) comes from the [UCI project](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) on Human Activity Recognition using smartphones. 

## Project data set (the _tidy data_ )

Available in file [tidy_data.txt](./tidy_data.txt) in this repository. 

It is a table of 180 observations of 81 variables: 30 subjects x 6 activities with 79 averaged measurements selected from the original data set.

## Description of variables (column names)

* subjectID: integer, range 1:6, the ID of the human subject performing the observed activities. 
* activity: character string, 6 values: 

         1 WALKING
         2 WALKING_UPSTAIRS
         3 WALKING_DOWNSTAIRS
         4 SITTING
         5 STANDING
         6 LAYING

*  79 variables: numerical, with names starting with'Averaged.'. See section _List of variables: tidy vs. original_ below for how the averaged column names were generated. 

         "Averaged.tBodyAcc.mean.X"
         "Averaged.tBodyAcc.mean.Y"
         "Averaged.tBodyAcc.mean.Z"
         "Averaged.tBodyAcc.std.X"
         "Averaged.tBodyAcc.std.Y"
         "Averaged.tBodyAcc.std.Z"
         "Averaged.tGravityAcc.mean.X"
         "Averaged.tGravityAcc.mean.Y"
         "Averaged.tGravityAcc.mean.Z"
         "Averaged.tGravityAcc.std.X"
         "Averaged.tGravityAcc.std.Y"
         "Averaged.tGravityAcc.std.Z"
         "Averaged.tBodyAccJerk.mean.X"
         "Averaged.tBodyAccJerk.mean.Y"
         "Averaged.tBodyAccJerk.mean.Z"
         "Averaged.tBodyAccJerk.std.X"
         "Averaged.tBodyAccJerk.std.Y"
         "Averaged.tBodyAccJerk.std.Z"
         "Averaged.tBodyGyro.mean.X"
         "Averaged.tBodyGyro.mean.Y"
         "Averaged.tBodyGyro.mean.Z"
         "Averaged.tBodyGyro.std.X"
         "Averaged.tBodyGyro.std.Y"
         "Averaged.tBodyGyro.std.Z"
         "Averaged.tBodyGyroJerk.mean.X"
         "Averaged.tBodyGyroJerk.mean.Y"
         "Averaged.tBodyGyroJerk.mean.Z"
         "Averaged.tBodyGyroJerk.std.X"
         "Averaged.tBodyGyroJerk.std.Y"
         "Averaged.tBodyGyroJerk.std.Z"
         "Averaged.tBodyAccMag.mean"
         "Averaged.tBodyAccMag.std"
         "Averaged.tGravityAccMag.mean"
         "Averaged.tGravityAccMag.std"
         "Averaged.tBodyAccJerkMag.mean"
         "Averaged.tBodyAccJerkMag.std"
         "Averaged.tBodyGyroMag.mean"
         "Averaged.tBodyGyroMag.std"
         "Averaged.tBodyGyroJerkMag.mean"
         "Averaged.tBodyGyroJerkMag.std"
         "Averaged.fBodyAcc.mean.X"
         "Averaged.fBodyAcc.mean.Y"
         "Averaged.fBodyAcc.mean.Z"
         "Averaged.fBodyAcc.std.X"
         "Averaged.fBodyAcc.std.Y"
         "Averaged.fBodyAcc.std.Z"
         "Averaged.fBodyAcc.meanFreq.X"
         "Averaged.fBodyAcc.meanFreq.Y"
         "Averaged.fBodyAcc.meanFreq.Z"
         "Averaged.fBodyAccJerk.mean.X"
         "Averaged.fBodyAccJerk.mean.Y"
         "Averaged.fBodyAccJerk.mean.Z"
         "Averaged.fBodyAccJerk.std.X"
         "Averaged.fBodyAccJerk.std.Y"
         "Averaged.fBodyAccJerk.std.Z"
         "Averaged.fBodyAccJerk.meanFreq.X"
         "Averaged.fBodyAccJerk.meanFreq.Y"
         "Averaged.fBodyAccJerk.meanFreq.Z"
         "Averaged.fBodyGyro.mean.X"
         "Averaged.fBodyGyro.mean.Y"
         "Averaged.fBodyGyro.mean.Z"
         "Averaged.fBodyGyro.std.X"
         "Averaged.fBodyGyro.std.Y"
         "Averaged.fBodyGyro.std.Z"
         "Averaged.fBodyGyro.meanFreq.X"
         "Averaged.fBodyGyro.meanFreq.Y"
         "Averaged.fBodyGyro.meanFreq.Z"
         "Averaged.fBodyAccMag.mean"
         "Averaged.fBodyAccMag.std"
         "Averaged.fBodyAccMag.meanFreq"
         "Averaged.fBodyBodyAccJerkMag.mean"
         "Averaged.fBodyBodyAccJerkMag.std"
         "Averaged.fBodyBodyAccJerkMag.meanFreq"
         "Averaged.fBodyBodyGyroMag.mean"
         "Averaged.fBodyBodyGyroMag.std"
         "Averaged.fBodyBodyGyroMag.meanFreq"
         "Averaged.fBodyBodyGyroJerkMag.mean"
         "Averaged.fBodyBodyGyroJerkMag.std"
         "Averaged.fBodyBodyGyroJerkMag.meanFreq"


## Data manipulation

## List of variables: tidy vs. original

For the tidy data set I have selected all the variables which have 'mean' or 'std' in their name from the original data set. As the original names are not valid column names for R, I have removed the characters '(),' from the names and changed '-' to '.'. Also, I have applied 'make.names()' with the 'unique' flag, just to be sure. 

The names under "tidy" below are the variable names of the tidy data set _before_ splitting and averaging on 'subjectID' and 'activity'. The 79 averaged columns have all the names changed by pasting 'Averaged.' in front. E.g. "Averaged.tBodyAcc.mean.X", etc. 

     "original"						"tidy"
     _______________________________________________________
     "tBodyAcc-mean()-X"			"tBodyAcc.mean.X"
     "tBodyAcc-mean()-Y"			"tBodyAcc.mean.Y"
     "tBodyAcc-mean()-Z"			"tBodyAcc.mean.Z"
     "tBodyAcc-std()-X"				"tBodyAcc.std.X"
     "tBodyAcc-std()-Y"				"tBodyAcc.std.Y"
     "tBodyAcc-std()-Z"				"tBodyAcc.std.Z"
     "tGravityAcc-mean()-X"			"tGravityAcc.mean.X"
     "tGravityAcc-mean()-Y"			"tGravityAcc.mean.Y"
     "tGravityAcc-mean()-Z"			"tGravityAcc.mean.Z"
     "tGravityAcc-std()-X"			"tGravityAcc.std.X"
     "tGravityAcc-std()-Y"			"tGravityAcc.std.Y"
     "tGravityAcc-std()-Z"			"tGravityAcc.std.Z"
     "tBodyAccJerk-mean()-X"		"tBodyAccJerk.mean.X"
     "tBodyAccJerk-mean()-Y"		"tBodyAccJerk.mean.Y"
     "tBodyAccJerk-mean()-Z"		"tBodyAccJerk.mean.Z"
     "tBodyAccJerk-std()-X"			"tBodyAccJerk.std.X"
     "tBodyAccJerk-std()-Y"			"tBodyAccJerk.std.Y"
     "tBodyAccJerk-std()-Z"			"tBodyAccJerk.std.Z"
     "tBodyGyro-mean()-X"			"tBodyGyro.mean.X"
     "tBodyGyro-mean()-Y"			"tBodyGyro.mean.Y"
     "tBodyGyro-mean()-Z"			"tBodyGyro.mean.Z"
     "tBodyGyro-std()-X"			"tBodyGyro.std.X"
     "tBodyGyro-std()-Y"			"tBodyGyro.std.Y"
     "tBodyGyro-std()-Z"			"tBodyGyro.std.Z"
     "tBodyGyroJerk-mean()-X"		"tBodyGyroJerk.mean.X"
     "tBodyGyroJerk-mean()-Y"		"tBodyGyroJerk.mean.Y"
     "tBodyGyroJerk-mean()-Z"		"tBodyGyroJerk.mean.Z"
     "tBodyGyroJerk-std()-X"		"tBodyGyroJerk.std.X"
     "tBodyGyroJerk-std()-Y"		"tBodyGyroJerk.std.Y"
     "tBodyGyroJerk-std()-Z"		"tBodyGyroJerk.std.Z"
     "tBodyAccMag-mean()"			"tBodyAccMag.mean"
     "tBodyAccMag-std()"			"tBodyAccMag.std"
     "tGravityAccMag-mean()"		"tGravityAccMag.mean"
     "tGravityAccMag-std()"			"tGravityAccMag.std"
     "tBodyAccJerkMag-mean()"		"tBodyAccJerkMag.mean"
     "tBodyAccJerkMag-std()"		"tBodyAccJerkMag.std"
     "tBodyGyroMag-mean()"			"tBodyGyroMag.mean"
     "tBodyGyroMag-std()"			"tBodyGyroMag.std"
     "tBodyGyroJerkMag-mean()"		"tBodyGyroJerkMag.mean"
     "tBodyGyroJerkMag-std()"		"tBodyGyroJerkMag.std"
     "fBodyAcc-mean()-X"			"fBodyAcc.mean.X"
     "fBodyAcc-mean()-Y"			"fBodyAcc.mean.Y"
     "fBodyAcc-mean()-Z"			"fBodyAcc.mean.Z"
     "fBodyAcc-std()-X"				"fBodyAcc.std.X"
     "fBodyAcc-std()-Y"				"fBodyAcc.std.Y"
     "fBodyAcc-std()-Z"				"fBodyAcc.std.Z"
     "fBodyAcc-meanFreq()-X"		"fBodyAcc.meanFreq.X"
     "fBodyAcc-meanFreq()-Y"		"fBodyAcc.meanFreq.Y"
     "fBodyAcc-meanFreq()-Z"		"fBodyAcc.meanFreq.Z"
     "fBodyAccJerk-mean()-X"		"fBodyAccJerk.mean.X"
     "fBodyAccJerk-mean()-Y"		"fBodyAccJerk.mean.Y"
     "fBodyAccJerk-mean()-Z"		"fBodyAccJerk.mean.Z"
     "fBodyAccJerk-std()-X"			"fBodyAccJerk.std.X"
     "fBodyAccJerk-std()-Y"			"fBodyAccJerk.std.Y"
     "fBodyAccJerk-std()-Z"			"fBodyAccJerk.std.Z"
     "fBodyAccJerk-meanFreq()-X"	"fBodyAccJerk.meanFreq.X"
     "fBodyAccJerk-meanFreq()-Y"	"fBodyAccJerk.meanFreq.Y"
     "fBodyAccJerk-meanFreq()-Z"	"fBodyAccJerk.meanFreq.Z"
     "fBodyGyro-mean()-X"			"fBodyGyro.mean.X"
     "fBodyGyro-mean()-Y"			"fBodyGyro.mean.Y"
     "fBodyGyro-mean()-Z"			"fBodyGyro.mean.Z"
     "fBodyGyro-std()-X"			"fBodyGyro.std.X"
     "fBodyGyro-std()-Y"			"fBodyGyro.std.Y"
     "fBodyGyro-std()-Z"			"fBodyGyro.std.Z"
     "fBodyGyro-meanFreq()-X"		"fBodyGyro.meanFreq.X"
     "fBodyGyro-meanFreq()-Y"		"fBodyGyro.meanFreq.Y"
     "fBodyGyro-meanFreq()-Z"		"fBodyGyro.meanFreq.Z"
     "fBodyAccMag-mean()"			"fBodyAccMag.mean"
     "fBodyAccMag-std()"			"fBodyAccMag.std"
     "fBodyAccMag-meanFreq()"		"fBodyAccMag.meanFreq"
     "fBodyBodyAccJerkMag-mean()"	"fBodyBodyAccJerkMag.mean"
     "fBodyBodyAccJerkMag-std()"	"fBodyBodyAccJerkMag.std"
     "fBodyBodyAccJerkMag-meanFreq()""fBodyBodyAccJerkMag.meanFreq"
     "fBodyBodyGyroMag-mean()"		"fBodyBodyGyroMag.mean"
     "fBodyBodyGyroMag-std()"		"fBodyBodyGyroMag.std"
     "fBodyBodyGyroMag-meanFreq()"	"fBodyBodyGyroMag.meanFreq"
     "fBodyBodyGyroJerkMag-mean()"	"fBodyBodyGyroJerkMag.mean"
     "fBodyBodyGyroJerkMag-std()"	"fBodyBodyGyroJerkMag.std"
     "fBodyBodyGyroJerkMag-meanFreq()""fBodyBodyGyroJerkMag.meanFreq"


__END of code book__