library(recommenderlab)
library(reshape2)
library(tidyr)
library(Matrix)
library(plyr)
library(dplyr)
path = "C:/Users/Student/Documents/iX_Data_Science/TravelRecs/VacationRecs"
travel_data_tidy <- read.csv(file.path(path, 'master_tidy.csv'), stringsAsFactors = FALSE)

saveRDS(travel_data_tidy, file=file.path(path,"travel_data_tidy.RData"))