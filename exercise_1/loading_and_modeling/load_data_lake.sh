
#!/bin/bash

# save my current directory 
MY_CWD=$(pwd)

# creating staging  directory 
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging directory
cd ~/staging/exercise_1

# get file from data.medicare.gov
MY_URL="https://medicare.gov/download/HospitalCompare/2016/December/HOSArchive_Revised_Flatfiles_20161219.zip"

wget "$MY_URL" -O medicare_data.zip

#unzip the medicare data
unzip medicare_data.zip

# remove first line of files and rename

OLD_FILE="Hospital General Information.csv"
NEW_FILE="hospitals.csv"

tail -n +2 "$OLD_FILE" >"$NEW_FILE"

OLD_FILE="Timely and Effective Care - Hospital.csv"
NEW_FILE="effective_care.csv"

tail -n +2 "$OLD_FILE" >"$NEW_FILE"

OLD_FILE="Readmissions and Deaths - Hospital.csv"
NEW_FILE="readmissions.csv"

tail -n +2 "$OLD_FILE" >"$NEW_FILE"

OLD_FILE="Measure Dates.csv"
NEW_FILE="Measures.csv"

tail -n +2 "$OLD_FILE" >"$NEW_FILE"

OLD_FILE="hvbp_hcahps_11_10_2016.csv"
NEW_FILE="surveys_responses.csv"

tail -n +2 "$OLD_FILE" >"$NEW_FILE"

# create our hdfs directory 

hdfs dfs -mkdir /user/w205/hospital_compare 

# copy files o hdfs
hdfs dfs -put hospitals.csv /user/w205/hospital_compare
hdfs dfs -put Measures.csv /user/w205/hospital_compare
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare
hdfs dfs -put effective_care.csv /user/w205/hospital_compare
hdfs dfs -put readmissions.csv /user/w205/hospital_compare

# change directory back to original

cd $MY_CWD

exit
