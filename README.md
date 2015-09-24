# Getting-and-Cleaning-Data-Project-September-2015
Repository for submissions for Coursera Getting and Cleaning Data course project

There is one command file for this project and it follows the 5 steps outlined in the project requirements.
The steps are labeled with comments in the script, but they are generally as follows:

Step 1 - Read all the data files in and assign names. This section uses a set of read.table commands. THen the various data sets are merged into one large set using cbind commands.
Step 2 - Subset the variables that are means and standard deviations after combining the trial and test data sets. This uses the select command. 
Step 3 - Applies the descriptive activity names from the activity labels file to name the activities in the data set.
Step 4 - Create and assign vector of activity names for variables. I created the names from the file because I didn't like the way they were given, so this requires a long colnames command.
Step 5 - Extracts the mean for each variable, divided by activity for each subject. This uses the reshape2 package and melts and then casts the data.

