library(recommenderlab)
library(reshape2)
library(tidyr)
library(Matrix)
library(plyr)
library(dplyr)



vac_data = arrange(master_tidy, User) %>%
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
engine.ubcf = Recommender(ratings.binary, method = "UBCF", parameter = list(nn = 2))
as(predict(engine.ubcf, ratings.binary[7], n = 10), "list")
