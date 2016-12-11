#Install and load readODS: will allow us to import ods files as a dataframe
install.packages("readODS")
library(readODS)

#Install and load dplyr: will allow us to work with data frames. will need to load dplyr to use select() and inner_join() functions. 
install.packages("dplyr")
library(dplyr)

#Set your working directory to the folder where all the files are. Import the files using the readODS package. Select relevant columns, if needed. 
ast3=read.ods("SimpleElevation3_coding_AST.ods", sheet=2)
ast3=select(ast3, 1:5)
az3=read.ods("SimpleElevation3_coding_AZ.ods", sheet=2)
az3=select(az3, 1:5)
cm3=read.ods("SimpleElevation3_coding_CM.ods", sheet=2)
dme3=read.ods("SimpleElevation3_coding_DME.ods", sheet=2)
ecm3=read.ods("SimpleElevation3_coding_ECM.ods", sheet=2)
jdp3=read.ods("SimpleElevation3_coding_JDP.ods", sheet=2)
jp3=read.ods("SimpleElevation3_coding_JP.ods", sheet=2)
jp3=select(jp3, 1:5)
lr3=read.ods("SimpleElevation3_coding_LR.ods", sheet=2)
mkk3=read.ods("SimpleElevation3_coding_MKK.ods", sheet=2)
saa3=read.ods("SimpleElevation3_coding_SAA.ods", sheet=2)

#Set variable/column names for each file. Create variable names that are shorter and easier to use. 
ast3=setNames(ast3, c("Id", "Fr", "Rating1", "Condition1", "Notes1"))
az3=setNames(az3, c("Id", "Fr", "Rating2", "Condition2", "Notes2"))
cm3=setNames(cm3, c("Id", "Fr", "Rating3", "Condition3", "Notes3"))
dme3=setNames(dme3, c("Id", "Fr", "Rating4", "Condition4", "Notes4"))
ecm3=setNames(ecm3, c("Id", "Fr", "Rating5", "Condition5", "Notes5"))
jdp3=setNames(jdp3, c("Id", "Fr", "Rating6", "Condition6", "Notes6"))
jp3=setNames(jp3, c("Id", "Fr", "Rating7", "Condition7", "Notes7"))
lr3=setNames(lr3, c("Id", "Fr", "Rating8", "Condition8", "Notes8"))
mkk3=setNames(mkk3, c("Id", "Fr", "Rating9", "Condition9", "Notes9"))
saa3=setNames(saa3, c("Id", "Fr", "Rating10", "Condition10", "Notes10"))

#readODS does not have a header=TRUE argument; will have to eliminate the first row. Also, remove 'Fr' column in all the files besides the first one (ast3), because 'Fr' column presents issues when merging. Note: I tried to use "col_names=TRUE" and "col_names=T" when importing the files as ods, but this did not work. 
ast3=ast3[-1, ]
az3=az3[-1,-2]
cm3=cm3[-1,-2]
dme3=dme3[-1,-2]
ecm3=ecm3[-1,-2]
jdp3=jdp3[-1,-2]
jp3=jp3[-1,-2]
lr3=lr3[-1,-2]
mkk3=mkk3[-1,-2]
saa3=saa3[-1,-2]

#Merge each file (two at a time), where the common column should be 'Id'. Do not merge by 'Fr' column. The end result should have 32 columns. Use names() to double check column names. 
study_3=inner_join(ast3, az3, by='Id', sort=FALSE)
study_3=inner_join(study_3, cm3, by='Id', sort=FALSE)
study_3=inner_join(study_3, dme3, by='Id', sort=FALSE)
study_3=inner_join(study_3, ecm3, by='Id', sort=FALSE)
study_3=inner_join(study_3, jdp3, by='Id', sort=FALSE)
study_3=inner_join(study_3, jp3, by='Id', sort=FALSE)
study_3=inner_join(study_3, lr3, by='Id', sort=FALSE)
study_3=inner_join(study_3, mkk3, by='Id', sort=FALSE)
study_3=inner_join(study_3, saa3, by='Id', sort=FALSE)
names(study_3)

#Eliminate the rows that contain blank free responses. 
study_3=study_3[!study_3$Fr == "", ]

#Reorder columns so that the variables appear consecutively (Rating, then Condition, then Notes). 
study_3=study_3[ ,c(1,2,3,6,9,12,15,18,21,24,27,30,4,7,10,13,16,19,22,25,28,31,5,8,11,14,17,20,23,26,29,32)]

#Export study_3 as a .csv file. 
write.csv(study_3, file="merged_ratings_study3.csv", row.names=F)