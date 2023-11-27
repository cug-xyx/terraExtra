library(ggplot2)
library(terra)
library(sf)
sf_use_s2(FALSE)

r <- rast('I:/GLEAM/yearly/E_1980-2021_GLEAM_v3.6a_YR.nc')[[1]] |>
  flip() |> #' `数据有错误反了，需要正过来，不用管`
  crop(ext(-180, 180, -60, 90)) |> #' `去掉南极洲`
  project('ESRI:54030') #' `转换投影`
df <- data.table::as.data.table(r, xy=T)

sf_world <- read_sf('I:/shpfiles/natural_earth/physical/ne_110m_land.shp') |>
  `st_crs<-`('EPSG:4326') |>
  st_crop(xmin=-180, ymin=-60, xmax=180, ymax=90) |>
  st_transform('ESRI:54030')


#' `边框`
sf_border <- st_graticule(lat=c(-60, 89.9999), lon=c(-180, 180), ndiscr = 100) |>
  st_as_sf() |>
  st_crop(xmin=-180, xmax=180, ymin=-60, ymax=90) |>
  st_transform('ESRI:54030')

#' `网格线`
sf_gridline <- st_graticule(lat=seq(-30, 60, 30), lon=seq(-120, 120, 60), ndiscr=100)['degree'] |>
  st_crop(xmin=-180, xmax=180, ymin=-60, ymax=90) |>
  st_transform('ESRI:54030')


ggplot(data=sf_world) +
  geom_sf(fill='transparent') +
  geom_sf(data=sf_gridline, color='grey', linetype='longdash') +
  geom_sf(data=sf_border, color='black') +
  geom_world_border() +
  theme(plot.margin = margin(rep(0, 4)),
        plot.background = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

geom_world_border <- function(ext=c(-180, -60, 180, 90), ndiscr = 100, crs="ESRI:54030") {
  err = 1e-7
  ext_new <- ifelse(ext <= 0, ext + err, ext - err)

  sf_border <-
    sf::st_graticule(lat=ext_new[c(2, 4)], lon=ext_new[c(1, 3)], ndiscr = ndiscr) |>
    st_crop(xmin=ext[1], xmax=ext[3], ymin=ext[2], ymax=ext[4]) |>
    st_transform(crs)

  ggplot2::geom_sf(data=sf_border, color='black')
}
