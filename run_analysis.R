#runanalysis.R
#ensure the following packages are installed...
require(dplyr)
require(utils)
require(data.table)
require(reshape2)
require(stringi)

#remember home directory
homedir <- getwd()

#download the source data
if (!file.exists("UCIDataset.zip")){
        download.file(url  =  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "UCIDataset.zip")
}

#extract the source data
if (!file.exists("UCIDataset")){
        unzip("UCIDataset.zip", exdir = "UCIDataset")
}


setwd ("UCIDataset/UCI HAR Dataset")

#load requist datafiles
features <- read.table("features.txt",sep = ' ', header = FALSE)
activities <- read.table("activity_labels.txt",sep = ' ', header = FALSE)
train_set <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt",sep = ' ', header = FALSE)
train_subjects <- read.table("train/subject_train.txt",sep = ' ', header = FALSE)
test_set <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt",sep = ' ', header = FALSE)
test_subjects <- read.table("test/subject_test.txt",sep = ' ', header = FALSE)

#consolidate datasets and apply variable names
mytest <- rbind(train_set,test_set)
names(mytest) <- features$V2
mylabels <- rbind(train_labels,test_labels)
names(mylabels) <- "label"
mysubjects <- rbind(train_subjects,test_subjects)
names(mysubjects) <- "subject"
names(activities) <- c("label","activity")
mydf <- cbind(mylabels,mysubjects,mytest)

#join activity names to the consolidated dataset
mydf2 <- merge(x=activities,y=mydf,by="label")

#extract the reqested signals, melt the selected signals into a single variable 'signal'
#placing the corresponding measurements into a single variable called measurement 
melteddata <- select(mydf2,activity,subject,contains("-mean()"),contains("-std()")) %>%
        melt(id=1:2, na.rm=TRUE, variable.name="signal", value.name="measurement") %>%
        group_by(activity, subject)

write.csv(melteddata,"HARTidyDataset.csv")

finaldt <- group_by(melteddata,activity,subject,signal) %>% 
        summarize(mean(measurement))
write.csv(finaldt,"SummarizedHARTidyDataset.csv")

print(paste("where am i:", getwd()))

print(dir())

setwd(homedir)