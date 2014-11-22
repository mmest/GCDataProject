


##Files overview

The following is not part of the run_analysis.R procedure. I have run a few operating system commands and an R script to look at important characteristics of the input file. 

#Summary: 
activity_labels.txt		2 columns: id and activity name; 6 rows. 
features.txt			2 columns: id and feature name; 561 rows

Files in test/ have 2497 rows, those in train/ have 7352 (30/70 split): 
subject_test.txt,		 
subject_train.txt		1 column: subject id.
X_test.txt, X_train		561 cols: one for each feature; 
						the rows are observation for each row in subject_test.txt
y_test.txt, y_train.txt	1 col: activity id (1:6) as in activity_labels.txt

The above fits with the discussion and diagram on the Coursera forums, see: 
<a ref="https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369>comment</a>

#Method: 

Though not used, the function 'countFileFields() is available in my script. It checks the number of fields in files with '.txt' extension in the given directory paths:  

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



