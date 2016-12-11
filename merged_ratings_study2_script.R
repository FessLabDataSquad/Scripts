#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. Note: LL refers to Lisa, and LML refers to Lindsey (both have same initials).
aer2=read.ods("SimpleElevation2_coding_AER.ods", sheet=2)
aer2=select(aer2, 1:5)
av2=read.ods("SimpleElevation2_coding_AV.ods", sheet=2)
av2=select(av2, 1:5)
cy2=read.ods("SimpleElevation2_coding_CY.ods", sheet=2)
jf2=read.ods("SimpleElevation2_coding_JF.ods", sheet=2)
jf2=select(jf2, 1:5)
ll2=read.ods("SimpleElevation2_coding_LL.ods", sheet=2)
lml2=read.ods("SimpleElevation2_coding_LML.ods", sheet=2)
lml2=select(lml2, 1:5)
pm2=read.ods("SimpleElevation2_coding_PM.ods", sheet=2)
rc2=read.ods("SimpleElevation2_coding_RC.ods", sheet=2)
tal2=read.ods("SimpleElevation2_coding_TAL.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
aer2=setNames(aer2, c("Id", "Fr", "Rating1", "Condition1", "Notes1"))
av2=setNames(av2, c("Id", "Fr", "Rating2", "Condition2", "Notes2"))
cy2=setNames(cy2, c("Id", "Fr", "Rating3", "Condition3", "Notes3"))
jf2=setNames(jf2, c("Id", "Fr", "Rating4", "Condition4", "Notes4"))
ll2=setNames(ll2, c("Id", "Fr", "Rating5", "Condition5", "Notes5"))
lml2=setNames(lml2, c("Id", "Fr", "Rating6", "Condition6", "Notes6"))
pm2=setNames(pm2, c("Id", "Fr", "Rating7", "Condition7", "Notes7"))
rc2=setNames(rc2, c("Id", "Fr", "Rating8", "Condition8", "Notes8"))
tal2=setNames(tal2, c("Id", "Fr", "Rating9", "Condition9", "Notes9"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (aer2), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
aer2=aer2[-1, ]
av2=av2[-1,-2]
cy2=cy2[-1,-2]
jf2=jf2[-1,-2]
ll2=ll2[-1,-2]
lml2=lml2[-1,-2]
pm2=pm2[-1,-2]
rc2=rc2[-1,-2]
tal2=tal2[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. The end result should have 29 columns. Use names() to double check column names. 
study_2=inner_join(aer2, av2, by='Id', sort=FALSE)
study_2=inner_join(study_2, cy2, by='Id', sort=FALSE)
study_2=inner_join(study_2, jf2, by='Id', sort=FALSE)
study_2=inner_join(study_2, ll2, by='Id', sort=FALSE)
study_2=inner_join(study_2, lml2, by='Id', sort=FALSE)
study_2=inner_join(study_2, pm2, by='Id', sort=FALSE)
study_2=inner_join(study_2, rc2, by='Id', sort=FALSE)
study_2=inner_join(study_2, tal2, by='Id', sort=FALSE)
names(study_2)

#Eliminate the rows that contain blank free responses. 
study_2=study_2[!study_2$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Rating, then Condition, then Notes). 
study_2=study_2[ ,c(1,2,3,6,9,12,15,18,21,24,27,4,7,10,13,16,19,22,25,28,5,8,11,14,17,20,23,26,29)]

#Export study_2 as a .csv file.
write.csv(study_2, file="merged_ratings_study2.csv", row.names=F)