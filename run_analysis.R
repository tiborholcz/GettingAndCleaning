tidy_set<-function(){
  
  # Load variable names:
  
  print("Loading feature names...")
  features<-read.table("features.txt")
  names(features)<-c("id", "name")
  
  # Load activity names:
  
  print("Loading activity labels...")
  activity_labels<-read.table("activity_labels.txt")
  names(activity_labels)<-c("id", "name")
  
  # Load training data
  # Load training activity labels
  
  print("Loading training activities...")
  train_labels<-read.table("y_train.txt")
  names(train_labels)<-"activitycode"
  
  # Load training set
  
  print("Loading training data...")
  train<-read.table("X_train.txt")
  names(train)<-features$name
  
  # Load training subject data
  
  print("Loading training subjects...")
  subject_train<-read.table("subject_train.txt")
  names(subject_train)<-"subjectid"
  
  # Load test data
  # Load test activity labels
  
  print("Loading test activities...")
  test_labels<-read.table("y_test.txt")
  names(test_labels)<-"activitycode"
  
  # Load test set
  
  print("Loading test data...")
  test<-read.table("X_test.txt")
  names(test)<-features$name
  
  # Load test subject data
  
  print("Loading test subjects...")
  subject_test<-read.table("subject_test.txt")
  names(subject_test)<-"subjectid"
  
  # Extract the mean and standard deviation columns
  
  print("Extracing mean and standard deviation...")
  train_extracted<-train[,grep("mean|std", names(train))]
  test_extracted<-test[,grep("mean|std", names(test))]
    
  # Bind subject and activity columns
  
  print("Bind subjects, activities and measured data...")
  train_full<-cbind(subject_train, activity=activity_labels[train_labels$activitycode,"name"], train_extracted)
  test_full<-cbind(subject_test, activity=activity_labels[test_labels$activitycode, "name"], test_extracted)
  
  # Merge train and test data
  
  print("Merge full data set...")
  result<-rbind(train_full, test_full)
  
  # Clean variable names
  
  names(result)<-tolower(gsub("[-()]", "", names(result)))
  
  print("Done.")
  return(result)
}

averages_of<-function(tidy_set){
  
  # Check if package reshape2 is installed or not, install if necessary
  
  if (sum(as.data.frame(installed.packages())$Package=="reshape2")==0){
    print("Install package reshape2...")
    install.packages("reshape2")
  }
  
  # If install was unsuccesful, exit from fuction with error code (-1)
  
  if (sum(as.data.frame(installed.packages())$Package=="reshape2")==0){
    print("Install of package reshape2 was unsuccesful.")
    print("Function stops now.")
    return(-1)
  }
  
  # Load libary if necessary
  
  if (sum(search()=="package:reshape2")==0) {
    print("Loading library reshape2...")
    library(reshape2)
  }
  
  # Exit, if library wasn't able to load
  
  if (sum(search()=="package:reshape2")==0) {
    print("Library was unable to load.")
    print("Function stops now.")
    return(-1)
  }
  
  # Create requested data set from original tidy set
  
  temp<-melt(tidy_set, id.vars=c("subjectid", "activity"))
  result<-dcast(temp, subjectid + activity ~ variable,mean)
  
  # Update variable names
  
  names(result)<-names(tidy_set)
  names(result)[3:length(names(result))]<-paste(names(result)[3:length(names(result))], "average", sep="")
  
  return(result)
}