#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. Note: LL refers to Lisa, and LML refers to Lindsey (both have same initials). Other Notes: av4 has 3/4 of the coding sheet completed. cy4 has problematic condition ratings: she inputted a 1 for responses that either 1. explicitly stated the video they watched (which is ok) and 2. "showed obvious and true concern with the topic with personal reflections and ideas of people-people interaction". 
aer4=read.ods("SimpleElevation4_coding_AER.ods", sheet=2)
aer4=select(aer4, 1:5)
av4=read.ods("SimpleElevation4_coding_AV.ods", sheet=2)
cy4=read.ods("SimpleElevation4_coding_CY.ods", sheet=2)
jf4=read.ods("SimpleElevation4_coding_JF.ods", sheet=2)
jf4=select(jf4, 1:5)
ll4=read.ods("SimpleElevation4_coding_LL.ods", sheet=2)
lml4=read.ods("SimpleElevation4_coding_LML.ods", sheet=2)
lml4=select(lml4, 1:5)
pm4=read.ods("SimpleElevation4_coding_PM.ods", sheet=2)
rc4=read.ods("SimpleElevation4_coding_RC.ods", sheet=2)
tal4=read.ods("SimpleElevation4_coding_TAL.ods", sheet=2)
tal4=select(tal4, 1:5)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
aer4=setNames(aer4, c("Id", "Fr", "Rating1", "Condition1", "Notes1"))
av4=setNames(av4, c("Id", "Fr", "Rating2", "Condition2", "Notes2"))
cy4=setNames(cy4, c("Id", "Fr", "Rating3", "Condition3", "Notes3"))
jf4=setNames(jf4, c("Id", "Fr", "Rating4", "Condition4", "Notes4"))
ll4=setNames(ll4, c("Id", "Fr", "Rating5", "Condition5", "Notes5"))
lml4=setNames(lml4, c("Id", "Fr", "Rating6", "Condition6", "Notes6"))
pm4=setNames(pm4, c("Id", "Fr", "Rating7", "Condition7", "Notes7"))
rc4=setNames(rc4, c("Id", "Fr", "Rating8", "Condition8", "Notes8"))
tal4=setNames(tal4, c("Id", "Fr", "Rating9", "Condition9", "Notes9"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (aer4), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
aer4=aer4[-1, ]
av4=av4[-1,-2]
cy4=cy4[-1,-2]
jf4=jf4[-1,-2]
ll4=ll4[-1,-2]
lml4=lml4[-1,-2]
pm4=pm4[-1,-2]
rc4=rc4[-1,-2]
tal4=tal4[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. The end result should have 26 columns. Use names() to double check column names. 
study_4=inner_join(aer4, av4, by='Id', sort=FALSE)
study_4=inner_join(study_4, cy4, by='Id', sort=FALSE)
study_4=inner_join(study_4, jf4, by='Id', sort=FALSE)
study_4=inner_join(study_4, ll4, by='Id', sort=FALSE)
study_4=inner_join(study_4, lml4, by='Id', sort=FALSE)
study_4=inner_join(study_4, pm4, by='Id', sort=FALSE)
study_4=inner_join(study_4, rc4, by='Id', sort=FALSE)
study_4=inner_join(study_4, tal4, by='Id', sort=FALSE)
names(study_4)

#Eliminate the rows that contain blank free responses. 
study_4=study_4[!study_4$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Rating, then Condition, then Notes). 
study_4=study_4[ ,c(1,2,3,6,9,12,15,18,21,24,27,4,7,10,13,16,19,22,25,28,5,8,11,14,17,20,23,26,29)]

#Export study_4 as a .csv file.
write.csv(study_4, file="merged_ratings_study4.csv", row.names=F)