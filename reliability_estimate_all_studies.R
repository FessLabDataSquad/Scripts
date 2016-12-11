#Descriptive Statistics: Reliability Estimate

#Import the csv files (remember to set working directory). 
study1_ratings=read.csv("merged_ratings_study1.csv", header=T)
study2_ratings=read.csv("merged_ratings_study2.csv", header=T)
study3_ratings=read.csv("merged_ratings_study3.csv", header=T)
study4_ratings=read.csv("merged_ratings_study4.csv", header=T)

#Select values as numerics, if needed. In Study 2, the Rating 2 column is a factor, because there is a non-numeric character at row 175 ("1?"). 
study2_ratings$Rating2=as.numeric(as.character(study2_ratings$Rating2))

#Subset the Id column and helpfulness rating columns. 
helps1=study1_ratings[,c(1,3:12)]
helps2=study2_ratings[,c(1,3:11)]
helps3=study3_ratings[,c(1,3:12)]
helps4=study4_ratings[,c(1,3:11)]

#Calculate the average helpfulness rating for each ID. The na.rm=T argument removes missing values.
helps1$mean=rowMeans(helps1[,2:11], na.rm=T)
helps2$mean=rowMeans(helps2[,2:10], na.rm=T)
helps3$mean=rowMeans(helps3[,2:11], na.rm=T)
helps4$mean=rowMeans(helps4[,2:10], na.rm=T)

#Inspect correlations between (1) each rater and the group's average, and (2) each pairwise correlation.  
cor(helps1[2:12], use="pairwise.complete.obs")
cor(helps2[2:11], use="pairwise.complete.obs")
cor(helps3[2:12], use="pairwise.complete.obs")
cor(helps4[2:11], use="pairwise.complete.obs")


