 ##Introduction ##

The script run_analysis.R performs the 5 steps described in the course project's definition.

 * Merged the "Activity", "Subject", "Features", "Test", and "Train" files to create one data set using rbind() and cbind() function.
 * Change the variable names to get a tidy dataset with apprpriate variable names.
 * Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. 
 * As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
 * Finally, we generate a new dataset with all the average measures for each subject and activity type