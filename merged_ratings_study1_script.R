#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
ast1=read.ods("SimpleElevation1_coding_AST.ods", sheet=2)
ast1=select(ast1, 1:5)
az1=read.ods("SimpleElevation1_coding_AZ.ods", sheet=2)
cm1=read.ods("SimpleElevation1_coding_CM.ods", sheet=2)
dme1=read.ods("SimpleElevation1_coding_DME.ods", sheet=2)
dme1=select(dme1, 1:5)
ecm1=read.ods("SimpleElevation1_coding_ECM.ods", sheet=2)
jdp1=read.ods("SimpleElevation1_coding_JDP.ods", sheet=2)
jp1=read.ods("SimpleElevation1_coding_JP.ods", sheet=2)
jp1=select(jp1, 1:5)
lr1=read.ods("SimpleElevation1_coding_LR.ods", sheet=2)
mkk1=read.ods("SimpleElevation1_coding_MKK.ods", sheet=2)
saa1=read.ods("SimpleElevation1_coding_SAA.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
ast1=setNames(ast1, c("Id", "Fr", "Rating1", "Condition1", "Notes1"))
az1=setNames(az1, c("Id", "Fr", "Rating2", "Condition2", "Notes2"))
cm1=setNames(cm1, c("Id", "Fr", "Rating3", "Condition3", "Notes3"))
dme1=setNames(dme1, c("Id", "Fr", "Rating4", "Condition4", "Notes4"))
ecm1=setNames(ecm1, c("Id", "Fr", "Rating5", "Condition5", "Notes5"))
jdp1=setNames(jdp1, c("Id", "Fr", "Rating6", "Condition6", "Notes6"))
jp1=setNames(jp1, c("Id", "Fr", "Rating7", "Condition7", "Notes7"))
lr1=setNames(lr1, c("Id", "Fr", "Rating8", "Condition8", "Notes8"))
mkk1=setNames(mkk1, c("Id", "Fr", "Rating9", "Condition9", "Notes9"))
saa1=setNames(saa1, c("Id", "Fr", "Rating10", "Condition10", "Notes10"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (ast1), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
ast1=ast1[-1, ]
az1=az1[-1,-2]
cm1=cm1[-1,-2]
dme1=dme1[-1,-2]
ecm1=ecm1[-1,-2]
jdp1=jdp1[-1,-2]
jp1=jp1[-1,-2]
lr1=lr1[-1,-2]
mkk1=mkk1[-1,-2]
saa1=saa1[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. The end result should have 32 columns. Use names() to double check column names. 
study_1=inner_join(ast1, az1, by='Id', sort=FALSE)
study_1=inner_join(study_1, cm1, by='Id', sort=FALSE)
study_1=inner_join(study_1, dme1, by='Id', sort=FALSE)
study_1=inner_join(study_1, ecm1, by='Id', sort=FALSE)
study_1=inner_join(study_1, jdp1, by='Id', sort=FALSE)
study_1=inner_join(study_1, jp1, by='Id', sort=FALSE)
study_1=inner_join(study_1, lr1, by='Id', sort=FALSE)
study_1=inner_join(study_1, mkk1, by='Id', sort=FALSE)
study_1=inner_join(study_1, saa1, by='Id', sort=FALSE)
names(study_1)

#Eliminate the rows that contain blank free responses. 
study_1=study_1[!study_1$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Rating, then Condition, then Notes). 
study_1=study_1[ ,c(1,2,3,6,9,12,15,18,21,24,27,30,4,7,10,13,16,19,22,25,28,31,5,8,11,14,17,20,23,26,29,32)]

#Export study_1 as a .csv file.
write.csv(study_1, file="merged_ratings_study1.csv", row.names=F)