library(magrittr)
library(terra)

r <- rast('I:/Paper_data/Zhang_2023_Science_PME/ML_annual.tif')

time(r) <- 2001:2020
