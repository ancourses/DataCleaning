library(plyr)

# Load label data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("ActivityIndex", "Activity"))
feature_labels  <- read.table("UCI HAR Dataset/features.txt", col.names=c("FeatureIndex", "Feature"))

# Select interesting features
interesting_features <- which(grepl("-(mean|std)\\(", feature_labels$Feature))

# Rename features to remove brackets
feature_labels$Feature <- sub("\\(\\)","", feature_labels$Feature)

# Load train data
train_X <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=feature_labels$Feature)
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("ActivityIndex"))
train_subjects   <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("Subject"))

# Load test data
test_X <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=feature_labels$Feature)
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("ActivityIndex"))
test_subjects    <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("Subject"))

# Merge train and test data
data_X <- rbind(train_X, test_X)
data_activities <- join(rbind(train_activities, test_activities), activity_labels) # Unless merge, join preserves the order of first argument
data_subjects <-rbind(train_subjects, test_subjects)

# Make full dataset

data_full <- mutate(data_subjects, Activity = data_activities$Activity)
data_full <- cbind(data_full, data_X[, interesting_features])

# Make tidy dataset

data_tidy <- aggregate(data_full[,3:68], by=list(Activity=data_full$Activity, Subject=data_full$Subject), mean)

# Save tidy data to file

write.csv(data_tidy, "data_tidy.csv")
