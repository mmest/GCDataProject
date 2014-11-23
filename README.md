#README

Author: Marco Mesturino, November 2014. 

This is the repository for my _Getting and Cleaning Data_ course project by Coursera. 

##Files in the repository 

* __.gitignore__  git's list of items NOT under configuration management. (Just ignore it.)
* __CodeBook.md__ the codebook as uploaded to Coursera. 
* __README.md__  this very file. 
* __run_Analysis.R__  the analysis script for this project. (Please, read this.)
* __tidy_data.txt__ the same _"tidy"_ data set uploaded to Coursera. It contains the results of the analysis script. 

## Original data set

The [original data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) comes from the [UCI project](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) on Human Activity Recognition using smartphones. 

## Project data set (the _tidy data_ )

Available in file [tidy_data.txt](./tidy_data.txt) in this repository. Please, see the code book for details. 

If you have the RStudio application, you can view the file like this: 

    View(read.table("tidy_data.txt", header = TRUE, quote = "\"", sep = "\t"))
 
## Code book

Please see file [CodeBook.md](./CodeBook.md) in this repository. It describes the project data set and variables transformation.  

## Analysis script and method

In file [run_analysis.R](./run_analysis.R) in this repository. Run it to re-build the _tidy_ data set. 

If you source the script, it will just show you how a list of R functions to run. (I never provide scripts that manipulate data when sourced, as they may mess-up the user's environment. )

     > source("run_analysis.R")
     Run 'runAnalysis()' to restructure the course project raw data set. (It will download raw data, if not already available.)
     Run 'getData()' to download the data ONLY. (It does not replace an existing data set.)
     Run 'cleanUpData()' to remove the raw data set. (NOT run at end of 'runAnalyis()'. Manual clean-up only.)
     > 

### Script Overview: 

The goal, intent and the data manipulation overview are in the [CodeBook](./CodeBook.md), i suggest to read that first. The fine details of processing are in the code comments in the script. Here I give the general overview fo the script. 

The project requires of the script  5 manipulations of the original data, more or less in this order: 
 
1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set. 

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 








##Appendix: UCI HAR Dataset Files overview

The following is _not_ part of the run_analysis.R procedure. I have run a few operating system commands and an R script to look at important characteristics of the input files. 

###Summary: 

    activity_labels.txt		2 columns: id and activity name; 6 rows. 
    features.txt			2 columns: id and feature name; 561 rows.

Files in test/ have 2497 rows, those in train/ have 7352 (30/70 split): 

    subject_test.txt,		 
    subject_train.txt		1 column: subject id.
    X_test.txt, X_train		561 cols: one for each feature; 
    						the rows are observation for each row in subject_test.txt
    y_test.txt, y_train.txt	1 col: activity id (1:6) as in activity_labels.txt

The above fits with the discussion and the [diagram at the Coursera forums](https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369). 

###Method: 

Though not used, the function 'countFileFields()' is available in my script. It checks the number of fields in files with '.txt' extension in the given directory paths:  

    > countFileFields(path = "UCI HAR Dataset", pattern = "\\.txt$")
    No. of fields in UCI HAR Dataset for files: 
    activity_labels.txt   features_info.txt        features.txt          README.txt 
                      2                  91                   2                  98 
    > countFileFields(path = "UCI HAR Dataset/test", pattern = "\\.txt$")
    No. of fields in UCI HAR Dataset/test for files: 
    subject_test.txt       X_test.txt       y_test.txt 
                   1              561                1 
    > countFileFields(path = "UCI HAR Dataset/train", pattern = "\\.txt$")
    No. of fields in UCI HAR Dataset/train for files: 
    subject_train.txt       X_train.txt       y_train.txt 
                    1               561                 1 

The following commands run OK in a bash shell, which is native in Linux, Unix, Mac OS X, and, with the Cygwin tools, even MS Windows. Similar commands should be available in native MS Windows: 

    $ (cd UCI\ HAR\ Dataset/ ; echo "   LINES   WORDS     CHARACTERS"; wc *.txt test/*.txt train/*.txt| sort)
       LINES   WORDS     CHARACTERS
           6      12      80 activity_labels.txt
          59     366    2809 features_info.txt
          70     576    4453 README.txt
         561    1122   15785 features.txt
        2947    2947    5894 test/y_test.txt
        2947    2947    7934 test/subject_test.txt
        2947 1653267 26458166 test/X_test.txt
        7352    7352   14704 train/y_train.txt
        7352    7352   20152 train/subject_train.txt
        7352 4124472 66006256 train/X_train.txt
       31593 5800413 92536233 total

Total above tells me I have enough memory to load all at once, if needed. 

###Files not used: 

I have not used the files in the 'Inertial Signals' sub-directories of the train and test data sets. They contain 128 variables for the same amount of observations as the other files. From the 'README.txt' and 'features_ info.txt' of the UCI data I gather that these 'Signals' are the original collected data used to generate the 'X _*.txt' files. In any case, they do not have any 'mean' or 'std' in their filenames, so they are not the kind of data required for this project. 

__END of README__ 

