ProjectDirectory = getwd()
DataDirectory = "UCI HAR Dataset/"
setwd(DataDirectory)

#read activity labels and features
ActLab = read.table("activity_labels.txt", sep = "")
ActLab = as.character(ActLab$V2)
AttNames = read.table("features.txt", sep = "")
AttNames = AttNames$V2

#read train data
Xtrain = read.table("train/X_train.txt", sep = "")
names(Xtrain) = AttNames
Ytrain = read.table("train/y_train.txt", sep = "")
names(Ytrain) = "Activity"
trainSubjects = read.table("train/subject_train.txt", sep = "")
names(trainSubjects) = "subject"
trainSubjects$subject = as.factor(trainSubjects$subject)

#read test data
Xtest = read.table("test/X_test.txt", sep = "")
names(Xtest) = AttNames
Ytest = read.table("test/y_test.txt", sep = "")
names(Ytest) = "Activity"
testSubjects = read.table("test/subject_test.txt", sep = "")
names(testSubjects) = "subject"
testSubjects$subject = as.factor(testSubjects$subject)

#######################################################
#merged datasets
train <- cbind(Xtrain, trainSubjects,Ytrain)
test <- cbind(Xtest,testSubjects,Ytest)

#add one label to differentiate test from train datasets
train$dataset <- rep("train", length(train[,1]))
test$dataset <- rep("test", length(test[,1]))
OutData <- rbind(train,test)

#######################################################
#extract only the mean and standard deviation
#include the subject and activity columns
#include the dataset label to differentiate test and train
OutSelect <-cbind(OutData[,1:6],OutData[,562:564])
OutSelect$dataset <- as.factor(OutSelect$dataset)

######################################################
#use descriptive names for the activity
OutSelect$Activity <- as.factor(OutSelect$Activity)
levels(OutSelect$Activity) <- ActLab

#remove the () from the variable names
names(OutSelect) <- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","subject","Activity","dataset")

######################################################
#Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

NewData <- data.frame(names(OutSelect[,1:6]))
names(NewData) <- "Measurements"

#split according to activity and calculate mean
sA <- split(OutSelect, OutSelect$Activity)
for(i in names(sA)) NewData[[i]]<-colMeans(sA[[i]][,1:6])

#split according to the subject 
sS <- split(OutSelect, OutSelect$subject)
for(i in names(sS)) NewData[[i]]<-colMeans(sS[[i]][,1:6])

#remove all data from environment (except OutSelect)
rm(Ytrain,Ytest,Xtrain,Xtest,trainSubjects,testSubjects, ActLab,AttNames, sA, sS, OutData)
rm(train,test)

#Save OutSelect to a file
setwd(ProjectDirectory)
#save(OutSelect, file = "OutSelect")
write.table(NewData, file = "AverageData.txt")

