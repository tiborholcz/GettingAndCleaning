GettingAndCleaning
==================

Getting and Cleaning Data Course Project

How to use script "run_analysis.R":

To wrok perfectly, you should copy the related original data files to the working directory:

activity_labels.txt

features.txt

subject_test.txt

subject_train.txt

X_test.txt

X_train.txt

y_test.txt

y_train.txt

First, you should run the tidy_set() function, without any argument. It will read the original files, and create a tidy dataset.

Example:

resultvariable<-tidy_set()

Then you could call averages_of() function, with one argument: the previously created variable. To run this function, reshape2 library is required. If it is not installed or loaded, the function will try to install and load it.

Example:

finalvariable<-averages_of(resultvariable)
