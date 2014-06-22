DataCleaning
============

Analysis script supposes that:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip downloaded and unpacked in this dir.
* `plyr` package installed

Script works as follows:
* It loads activity and feature labels from dataset (to use as activity values and column names in data)
* Mean and std feature indexes are selected - these one which have "mean(" and "std(" at the end. As all of the data in files are derived and no raw data, all such features are supposed to be features of "measurements".
* Features are slightly renamed to remove brackets from it (because they aren't valid in R column names)
* X, y and subjects data are loaded from train and test datasets
* train and test datasets are merged together through `rbind`
* Activity indexes are replaced with activity labels though usage of join which preserves activity order
* Full data is created by adding activities to subjects and cbind'ing interesting features to it
* Tidy data is created by aggregating data features with mean with grouping on activity and subject
* Tidy data is written to csv file
