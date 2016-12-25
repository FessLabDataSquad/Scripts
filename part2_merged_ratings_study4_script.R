#Coding Project Part 2: Testing for Task Performance and Friendliness
#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
jp4=read.ods("SimpleElevation4_coding_part2_JP.ods", sheet=2)
jp4=select(jp4, 1:6)
lml4=read.ods("SimpleElevation4_coding_part2_LML.ods", sheet=2)
lml4=select(lml4, 1:6)
ns4=read.ods("SimpleElevation4_coding_part2_NS.ods", sheet=2)
pm4=read.ods("SimpleElevation4_coding_part2_PM.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
jp4=setNames(jp4, c("Id", "Fr", "Performance1", "Friendliness1", "Condition1", "Notes1"))
lml4=setNames(lml4, c("Id", "Fr", "Performance2", "Friendliness2", "Condition2", "Notes2"))
ns4=setNames(ns4, c("Id", "Fr", "Performance3", "Friendliness3", "Condition3", "Notes3"))
pm4=setNames(pm4, c("Id", "Fr", "Performance4", "Friendliness4", "Condition4", "Notes4"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (jp4), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
jp4=jp4[-1, ]
lml4=lml4[-1,-2]
ns4=ns4[-1,-2]
pm4=pm4[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. Use names() to double check column names. 
study_4=inner_join(jp4, lml4, by='Id', sort=FALSE)
study_4=inner_join(study_4, ns4, by='Id', sort=FALSE)
study_4=inner_join(study_4, pm4, by='Id', sort=FALSE)
names(study_4)

#Eliminate the rows that contain blank free responses. 
study_4=study_4[!study_4$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Performance, Friendliness, Condition, and then Notes). 
study_4=study_4[, c(1,2,3,7,11,15,4,8,12,16,5,9,13,17,6,10,14,18)]

#Export as a .csv file.
write.csv(study_4, file="part2_merged_ratings_study4.csv", row.names=F)