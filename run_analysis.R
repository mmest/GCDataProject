### File:  run_analysis.R 
### Copyright (c) 2014 Marco Mesturino - Italy. 

message("Run 'runAnalysis()' to restructure the course project raw data set. (It will download raw data, if not already available.)")
message("Run 'getData()' to download the data ONLY. (It does not replace an existing data set.)")
message("Run 'cleanUpData()' to remove the raw data set. (NOT run at end of 'runAnalyis()'. Manual clean-up only.)")

# From RStudio, run 
#     View(read.table("tidy_data.txt", header = TRUE, quote = "\"", sep = "\t"))
# to see results. 

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


## Function 'runAnalysis()' combines train and test data sets into one and generates the tidy data set
##           which contains the average of each variable for each activity and each subject.
##
## Returns the name of the final tidy data set 
## 
runAnalysis <- function() {
  
  ftDT <- NULL   # Cached data frame of feature names, loaded initially from 'mergeRawData()'. 
  
  ## Function 'mergeRawData()' combines columns from the test and train files. It also
  ##           assigns meaningful names to the columns, and it stores the feature names
  ##           into variable 'ftDT' which is cached into the parent frame for reuse on 
  ##           subsequent calls. 
  ## Parameters: 'dt' combined data frame;
  ##             'dirName' path to the raw data directory;
  ##             'setName' the suffix used for files and subdirectories ("train" or "test"). 
  ## Returns: combined data frame. 
  ## Side effects: 'ftDT'.
  ## 
  mergeRawData <- function(dt, dirName, setName)  {
    # Combine and name columns from subject_*.txt 
    dt <- read.table(file.path(dirName, setName, paste0("subject_", setName, ".txt")), 
                     col.names = "subjectID", comment.char = "")
    # Combine and name columns from y_*.txt
    dt <- cbind(dt, 
                read.table(file.path(dirName, setName, paste0("y_", setName, ".txt")), 
                           col.names = "activity", comment.char = "") )
    # Get feature names to use as x_*.txt column names: 
    if (is.null(ftDT)) {  # Load and cache ftDT in parent frame, if not already. 
      ftDT <<- read.table(file.path(dirName, "features.txt"), 
                          stringsAsFactors = FALSE, col.names = c("ID", "feature"), sep = " ", comment.char = "")
      # remove some characters from names, replace '-' with '.' and make sure are unique: 
      ftDT$feature <<- make.names(gsub("[,()]+", "", ftDT$feature), unique = TRUE) 
    }
    # Combine and name columns from x_*.txt
    dt <- cbind(dt, 
                read.table(file.path(dirName, setName, paste0("x_", setName, ".txt")), 
                           col.names = ftDT$feature, comment.char = "") )
    
    return(dt)
  } # mergeRawData()
  
  # Start of runAnalysis() 
  
  # 0. Make sure we have the raw data: 
  message("Start of analysis run...")
  rawDataDirName <- getData()   
  message("... raw data is in: ", rawDataDirName)
  
  # 1. Merge the training and data set into one. 
  message("... merge of datasets ...")
  dt <- data.frame()
  message( "... merge of all columns from the test files ..." )
  dt <- mergeRawData(dt, rawDataDirName, "test")
  message("... merge all cols from the train files, add rows to combined data frame ...")
  message(" ... this will take time ...")
  dt <- rbind(dt, mergeRawData(dt, rawDataDirName, "train"))
  
  # 2. Extracts the measurements on the mean and standard deviation for each measurement:
  message("... reducing data frame to mean() and std() measurements ...")
  dt <- dt[ , c( "subjectID", "activity", ftDT[grep("\\.mean|\\.std", ftDT$feature) , "feature"] ) ]
  
  # 3. Load activity ID numbers and descriptive labels from file:  
  message("... adding meaningful activity names ...")
  actDT <- read.table(file.path(rawDataDirName, "activity_labels.txt"), 
                      col.names = c("ID", "label"), comment.char = "")
  # Convert numeric IDs of the 'activity' column of combined data to a factor whose
  # levels match the descriptive labels from the file: 
  dt$activity <- factor(dt$activity, actDT$ID, actDT$label, ordered = FALSE)
  
  # 4.Assign meaningful column names and classes. 
  #   Done already by assigning col names in 'mergeRawData()'. 

  # 5. Make the tidy data with the average of each variable for each activity and each subject: 
  message("... generating tidy data set ...")
  dt <- makeTidy(dt)
  message("... witing tidy data file ...")
  tidyFileName <- writeTidyFile(dt)
  
  message("... END RUN. Tidy data is in: ", tidyFileName)
  
} # runAnalysis()

makeTidy <- function(dt) {
  if (!isTRUE(require(plyr))) 
      install.packages("plyr")
  library(plyr)
  
  # Split data frame on subject and activity, applies 'mean()' column-wise on unsplitted: 
  dt <- ddply(dt, c("subjectID", "activity"), numcolwise(mean))
  # Prefix 'Averaged.' to all column names but subject and activity: 
  names(dt)[ -c(1, 2) ] <- paste0("Averaged.", names(dt)[ -c(1, 2) ])
  
  return(dt)
}


writeTidyFile <- function(dt, tidyFileName = "tidy_data.txt") {
  # Write 'dt' as a space-delimited file
  write.table(dt, tidyFileName, sep = "\t", row.name=FALSE)
  
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

