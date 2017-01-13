#Coding Project Part 2: Testing for Task Performance and Friendliness
#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
ast1=read.ods("SimpleElevation1_coding_part2_AST.ods", sheet=2)
ast1=select(ast1, 1:6)
az1=read.ods("SimpleElevation1_coding_part2_AZ.ods", sheet=2)
dme1=read.ods("SimpleElevation1_coding_part2_DME.ods", sheet=2)
dme1=select(dme1, 1:6)
tal1=read.ods("SimpleElevation1_coding_part2_TAL.ods", sheet=2)
tal1=select(tal1, 1:6)
ns1=read.ods("SimpleElevation1_coding_part2_NS.ods", sheet=2)
ns1=select(ns1, 1:6)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
ast1=setNames(ast1, c("Id", "Fr", "Performance1", "Friendliness1", "Condition1", "Notes1"))
az1=setNames(az1, c("Id", "Fr", "Performance2", "Friendliness2", "Condition2", "Notes2"))
dme1=setNames(dme1, c("Id", "Fr", "Performance3", "Friendliness3", "Condition3", "Notes3"))
tal1=setNames(tal1, c("Id", "Fr", "Performance4", "Friendliness4", "Condition4", "Notes4"))
ns1=setNames(ns1, c("Id", "Fr", "Performance5", "Friendliness5", "Condition5", "Notes5"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (ast1), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
ast1=ast1[-1, ]
az1=az1[-1,-2]
dme1=dme1[-1,-2]
tal1=tal1[-1,-2]
ns1=ns1[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. The end result should have 32 columns. Use names() to double check column names. 
study_1=inner_join(ast1, az1, by='Id', sort=FALSE)
study_1=inner_join(study_1, dme1, by='Id', sort=FALSE)
study_1=inner_join(study_1, tal1, by='Id', sort=FALSE)
study_1=inner_join(study_1, ns1, by='Id', sort=FALSE)
names(study_1)

#Eliminate the rows that contain blank free responses. 
study_1=study_1[!study_1$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Performance, Friendliness, Condition, and then Notes). 
study_1=study_1[,c(1,2,3,7,11,15,19,4,8,12,16,20,5,9,13,17,21,6,10,14,18,22)]

#Export as a .csv file.
write.csv(study_1, file="part2_merged_ratings_study1.csv", row.names=F)
