### File:  run_analysis.R 
### Copyright (c) 2014 Marco Mesturino - Italy. 

message("Run 'runAnalysis()' to restructure the course project raw data set. (It will download raw data, if not already available.)")
message("Run 'getData()' to download the data ONLY. (It does not replace an existing data set.)")
message("Run 'cleanUpData()' to remove the raw data set. (NOT run at end of 'runAnalyis()'. Manual clean-up only.)")

## Function 'getData()' downloads the raw data if not already available in the current directory.
## 
## Returns the raw data directory name. 
## 
getData <- function(rawDataDirName = "UCI HAR Dataset",  
                    rawDataURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") {
  message("Checking for raw data...")
  
  if (!file.exists(rawDataDirName)) {
    
    message("Downloading file from: ", rawDataURL)
    tmpZippedFile = tempfile(pattern = "GCDataTemp_", tmpdir = ".")
    download.file(rawDataURL, destfile = tmpZippedFile, method = "curl")
    
    message("Unzipping file: ", tmpZippedFile)
    unzip(tmpZippedFile)
    
    message("Removing file: ", tmpZippedFile)
    file.remove(tmpZippedFile)
    
  } else {
    message("Raw data directory already exists: ", rawDataDirName)
  }
  return(rawDataDirName) 
} # getData()


## Function'cleanUpData()' removes the raw data directory. 
##
cleanUpData <- function(rawDataDirName = "UCI HAR Dataset") {
  if (file.exists(rawDataDirName)) {
    message("Removing directory: ", rawDataDirName)
    unlink(rawDataDirName, recursive = TRUE, force = TRUE)
  }
}


## Function 'runAnalysis()' combines train and test sets into one and generates the tidy data sets. 
##
## Returns the name of the final tidy data set with the average of each variable for each activity and each subject.
## 
runAnalysis <- function() {
  
  # Make sure we have the raw data: 
  message("Start of analysis run...")
  rawDataDirName <- getData()   
  message("... raw data is in: ", rawDataDirName)
  
  # 1. Merge the training and data set into one. Assign meaningful column names and classes. 
  message("... merge of datasets ...")
  dt <- data.frame()
  # Merge of all columns from the test files: 
  dt <- mergeRawData(dt, rawDataDirName, "test")
  # Merge all cols from the train files, add rows to combined data frame: 
  dt <- rbind(dt, mergeRawData(dt, rawDataDirName, "train"))
  
  # 2. Extracts the measurements on the mean and standard deviation for each measurement:
  
  
  # 3. Load activity ID numbers and descriptive labels from file:  
  actDT <- read.table(file.path(rawDataDirName, "activity_labels.txt"), 
                      col.names = c("ID", "label"), comment.char = "")
  # Convert numeric IDs of the 'activity' column of combined data to a factor whose
  # levels match the descriptive labels from the file: 
  dt$activity <- factor(dt$activity, actDT$ID, actDT$label, ordered = FALSE)
  
  # Make the tidy data file: 
  message("... generating tidy data set ...")
  
  message("... witing tidy data file ...")
  tidyFileName <- writeTidyFile(dt)
  
  message("... END RUN. Tidy data is in: ", tidyFileName)
  return(tidyFileName)
  
} # runAnalysis()


mergeRawData <- function(dt, dirName, setName)  {
  
  dt <- read.table(file.path(dirName, setName, paste0("subject_", setName, ".txt")), 
                   col.names = "subjectID", comment.char = "")
  dt <- cbind(dt, 
              read.table(file.path(dirName, setName, paste0("y_", setName, ".txt")), 
                         col.names = "activity", comment.char = "") )

  
  return(dt)
}


writeTidyFile <- function(dt, tidyFileName = "tidy_data.txt") {
  
  return(tidyFileName)
}


## Function 'countFileFields()' prints a table of filenames / fields counts.
## 
## Parameter 'pattern': pattern of filenames to examine, passed to 'dir()';
## parameter 'path': path to directory to examine, passed to 'dir()'; 
## parameter 'sep': field separator(s), passed to 'count.fields()'. 
## No significant return value. 
##
countFileFields <- function(path = ".", pattern = "\\.txt$",  sep = "" ) {
  message("No. of fields in ", path, " for files: ")
  sapply(dir(path = path, pattern = pattern), 
         function(fn) max(count.fields(file.path(path, fn), sep = sep, quote = "", comment.char = "")))
}

