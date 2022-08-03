# To remain under BQ table operation quota / table (1500 ops)
# ATLAS SQL Codesets table violates this limit (drop table counts;
# tallies are cumulative across all tables of the same name.
# this script renames Codesets to CodesetsB in 1/2 of the sql files defined as 
# cohortSQL below. 
# a back up of the original SQL is denoted with an additional .bak extension.  Adapted from:
# https://stackoverflow.com/questions/6994947/how-to-replace-a-string-in-an-existing-file-in-perl

original_wd = getwd()
working_directory <- "/workdir/workdir/"
setwd(working_directory)

# container deployed env. requires chmod to make system changes. 
system("sudo chmod -R 777 /workdir/LegendT2dm/")

# read in list of Exposure cohort (i.e. 'class' file names);
# choose 1/2 of the files as targets for the change

cohortSQL <- list.files("/workdir/LegendT2dm/inst/sql/sql_server/class")
n = trunc(length(cohortSQL)/2)
cohortSQL_toChange = cohortSQL[1:n]

# replace 'Codesets' table name with 'CodesetsB' in cohortSQL_toChange
setwd("/workdir/LegendT2dm/inst/sql/sql_server/class")
for (i in 1:length(cohortSQL_toChange)){
  perl_script <- paste0("perl -pi.bak -e 's/Codesets/CodesetsB/g' ",cohortSQL_toChange[i])
  system(perl_script)
}

setwd(original_wd)
