#Coding Project Part 2: Testing for Task Performance and Friendliness
#Descriptive Statistics: Reliability Estimate

#Import the csv files (remember to set working directory). 
study1_ratings=read.csv("part2_merged_ratings_study1.csv", header=T)
study2_ratings=read.csv("part2_merged_ratings_study2.csv", header=T)
study3_ratings=read.csv("part2_merged_ratings_study3.csv", header=T)
study4_ratings=read.csv("part2_merged_ratings_study4.csv", header=T)

#TASK PERFORMANCE
#Subset the Id column and task performance rating columns. 
task1=study1_ratings[,c(1,3:6)]
task2=study2_ratings[,c(1,3:6)]
task3=study3_ratings[,c(1,3:6)]
task4=study4_ratings[,c(1,3:6)]

#Calculate the average task performance rating for each ID. The na.rm=T argument removes missing values.
task1$mean=rowMeans(task1[,2:5], na.rm=T)
task2$mean=rowMeans(task2[,2:5], na.rm=T)
task3$mean=rowMeans(task3[,2:5], na.rm=T)
task4$mean=rowMeans(task4[,2:5], na.rm=T)

#Inspect correlations between (1) each rater and the group's average, and (2) each pairwise correlation.  
cor(task1[2:6], use="pairwise.complete.obs")
cor(task2[2:6], use="pairwise.complete.obs")
cor(task3[2:6], use="pairwise.complete.obs")
cor(task4[2:6], use="pairwise.complete.obs")

#Save mean task performance ratings and Id to import to the analysis script
need = c("Id" , "mean")
write.csv(task1[, need], "study1_taskperformance.csv", row.names = F)
write.csv(task2[, need], "study2_taskperformance.csv", row.names = F)
write.csv(task3[, need], "study3_taskperformance.csv", row.names = F)
write.csv(task4[, need], "study4_taskperformance.csv", row.names = F)

#FRIENDLINESS
#Subset the Id column and friendliness rating columns. 
friendly1=study1_ratings[,c(1,7:10)]
friendly2=study2_ratings[,c(1,7:10)]
friendly3=study3_ratings[,c(1,7:10)]
friendly4=study4_ratings[,c(1,7:10)]

#Calculate the average friendliness rating for each ID. The na.rm=T argument removes missing values.
friendly1$mean=rowMeans(friendly1[,2:5], na.rm=T)
friendly2$mean=rowMeans(friendly2[,2:5], na.rm=T)
friendly3$mean=rowMeans(friendly3[,2:5], na.rm=T)
friendly4$mean=rowMeans(friendly4[,2:5], na.rm=T)

#Inspect correlations between (1) each rater and the group's average, and (2) each pairwise correlation.  
cor(friendly1[2:6], use="pairwise.complete.obs")
cor(friendly2[2:6], use="pairwise.complete.obs")
cor(friendly3[2:6], use="pairwise.complete.obs")
cor(friendly4[2:6], use="pairwise.complete.obs")

#Save mean friendliness ratings and Id to import to the analysis script
need = c("Id" , "mean")
write.csv(friendly1[, need], "study1_friendliness.csv", row.names = F)
write.csv(friendly2[, need], "study2_friendliness.csv", row.names = F)
write.csv(friendly3[, need], "study3_friendliness.csv", row.names = F)
write.csv(friendly4[, need], "study4_friendliness.csv", row.names = F)
