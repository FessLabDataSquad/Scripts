#Coding Project Part 2: Testing for Task Performance and Friendliness
#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
jp3=read.ods("SimpleElevation3_coding_part2_JP.ods", sheet=2)
jp3=select(jp3, 1:6)
lml3=read.ods("SimpleElevation3_coding_part2_LML.ods", sheet=2)
lml3=select(lml3, 1:6)
ns3=read.ods("SimpleElevation3_coding_part2_NS.ods", sheet=2)
pm3=read.ods("SimpleElevation3_coding_part2_PM.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
jp3=setNames(jp3, c("Id", "Fr", "Performance1", "Friendliness1", "Condition1", "Notes1"))
lml3=setNames(lml3, c("Id", "Fr", "Performance2", "Friendliness2", "Condition2", "Notes2"))
ns3=setNames(ns3, c("Id", "Fr", "Performance3", "Friendliness3", "Condition3", "Notes3"))
pm3=setNames(pm3, c("Id", "Fr", "Performance4", "Friendliness4", "Condition4", "Notes4"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (jp3), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
jp3=jp3[-1, ]
lml3=lml3[-1,-2]
ns3=ns3[-1,-2]
pm3=pm3[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. Use names() to double check column names. 
study_3=inner_join(jp3, lml3, by='Id', sort=FALSE)
study_3=inner_join(study_3, ns3, by='Id', sort=FALSE)
study_3=inner_join(study_3, pm3, by='Id', sort=FALSE)
names(study_3)

#Eliminate the rows that contain blank free responses. 
study_3=study_3[!study_3$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Performance, Friendliness, Condition, and then Notes). 
study_3=study_3[, c(1,2,3,7,11,15,4,8,12,16,5,9,13,17,6,10,14,18)]

#Export as a .csv file.
write.csv(study_3, file="part2_merged_ratings_study3.csv", row.names=F)