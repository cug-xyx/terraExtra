library(magrittr)
library(terra)

fs <- dir('I:/CFSV2/ET/', full.names = T)

r <- rast(fs[1])

r_res <- tapp(r, index='days', fun='mean', na.rm=T, cores=6)

r_res
