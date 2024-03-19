#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)

#### Read data ####
analysis_data <- read_csv("data/raw_data/raw_data_football.csv")


analysis_data
### Model data ####
goals_pois <-
  glm(
    Goals ~ Possession,
    data = analysis_data,
    family = "poisson"
  )

summary(grades_base)

#### Save model ####
saveRDS(
  goals_pois,
  file = "models/first_model.rds"
)


goals_rstanarm <-
  stan_glm(
    Goals ~ Possession,
    data = analysis_data,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

saveRDS(
  goals_rstanarm,
  file = "goals_rstanarm.rds"
)

modelsummary(
  list(
    "Goals" = goals_rstanarm
  )
)


