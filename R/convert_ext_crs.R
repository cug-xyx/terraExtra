#' Convert crs of extent
#' @param xmin
#'
#' @param xmax
#' @param ymin
#' @param ymax
#'
#' @import terra
#' @export
convert_ext_crs <- function(xmin, xmax, ymin, ymax, crs = 'ESRI:54030') {
  tmp <- terra::ext(xmin, xmax, ymin, ymax) |>
    terra::vect(crs = "EPSG:4326") |>
    project(crs) |>
    ext()

  tmp@ptr@.xData$vector
}
