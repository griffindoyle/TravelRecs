library(recommenderlab)
library(reshape2)
library(tidyr)
library(Matrix)
library(plyr)
library(dplyr)
travel_data_tidy <- read.csv("C:\\Users\\Student\\Documents\\iX_Data_Science\\TravelRecs\\VacationRecs\\master_tidy.csv")

vac_data = arrange(travel_data_tidy, User) %>%
  mutate(
    User = factor(User, levels = unique(User)),
    Location = factor(Location)
  )

GOODRATING = 5

ratings = sparseMatrix(i = as.integer(vac_data$User),
                       j = as.integer(vac_data$Location),
                       x = vac_data$Rating)

rownames(ratings) = levels(vac_data$User)
colnames(ratings) = levels(vac_data$Location)

ratings.real = new("realRatingMatrix", data = ratings)

ratings.binary <- binarize(ratings.real, minRating = GOODRATING)

travel_model = Recommender(ratings.binary, method = "UBCF", parameter = list(nn = 2))

travel_matrix <- spread(travel_data_tidy,Location,Rating)
travel_matrix[is.na(travel_matrix)] <- 0
travel_matrix <- travel_matrix

save(travel_data_tidy, file="travel_data_tidy.RData")
save(travel_matrix, file="travel_matrix.RData")
