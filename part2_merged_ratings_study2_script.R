#Coding Project Part 2: Testing for Task Performance and Friendliness
#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
ast2=read.ods("SimpleElevation2_coding_part2_AST.ods", sheet=2)
ast2=select(ast2, 1:6)
az2=read.ods("SimpleElevation2_coding_part2_AZ.ods", sheet=2)
dme2=read.ods("SimpleElevation2_coding_part2_DME.ods", sheet=2)
dme2=select(dme2, 1:6)
tal2=read.ods("SimpleElevation2_coding_part2_TAL.ods", sheet=2)
tal2=select(tal2, 1:6)
ns2=read.ods("SimpleElevation2_coding_part2_NS.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
ast2=setNames(ast2, c("Id", "Fr", "Performance1", "Friendliness1", "Condition1", "Notes1"))
az2=setNames(az2, c("Id", "Fr", "Performance2", "Friendliness2", "Condition2", "Notes2"))
dme2=setNames(dme2, c("Id", "Fr", "Performance3", "Friendliness3", "Condition3", "Notes3"))
tal2=setNames(tal2, c("Id", "Fr", "Performance4", "Friendliness4", "Condition4", "Notes4"))
ns2=setNames(ns2, c("Id", "Fr", "Performance5", "Friendliness5", "Condition5", "Notes5"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (ast2), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
ast2=ast2[-1, ]
az2=az2[-1,-2]
dme2=dme2[-1,-2]
tal2=tal2[-1,-2]
ns2=ns2[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. Use names() to double check column names. 
study_2=inner_join(ast2, az2, by='Id', sort=FALSE)
study_2=inner_join(study_2, dme2, by='Id', sort=FALSE)
study_2=inner_join(study_2, tal2, by='Id', sort=FALSE)
study_2=inner_join(study_2, ns2, by='Id', sort=FALSE)
names(study_2)

#Eliminate the rows that contain blank free responses. 
study_2=study_2[!study_2$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Performance, Friendliness, Condition, and then Notes). 
study_2=study_2[,c(1,2,3,7,11,15,19,4,8,12,16,20,5,9,13,17,21,6,10,14,18,22)]

#Export as a .csv file.
write.csv(study_2, file="part2_merged_ratings_study2.csv", row.names=F)
