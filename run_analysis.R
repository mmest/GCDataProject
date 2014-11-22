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
  if (!file.exists(rawDataDirName)) {
    tmpZippedFile = tempfile(pattern = "GCDataTemp_", tmpdir = ".")
    message("Downloading file from: ", rawDataURL)
    download.file(rawDataURL, destfile = tmpZippedFile, method = "curl")
    message("Unzipping file: ", tmpZippedFile)
    unzip(tmpZippedFile)
    message("Removing file: ", tmpZippedFile)
    file.remove(tmpZippedFile)
  }
  return(rawDataDirName) 
}

## Function'cleanUpData()' removes the raw data directory. 
##
cleanUpData <- function(rawDataDirName = "UCI HAR Dataset") {
  if (file.exists(rawDataDirName)) {
    message("Removing directory: ", rawDataDirName)
    unlink(rawDataDirName, recursive = TRUE, force = TRUE)
  }
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

