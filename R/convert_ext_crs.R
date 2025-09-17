#' Convert crs of extent
#' 
#' @param xmin xmin
#' @param xmax xmax
#' @param ymin ymin
#' @param ymax ymax
#' @param crs crs
#'
#' @import terra
#' @export
convert_ext_crs <- function(xmin, xmax, ymin, ymax, crs = 'ESRI:54030') {
  tmp <- terra::ext(xmin, xmax, ymin, ymax) |> # nolint: object_usage_linter.
    terra::vect(crs = "EPSG:4326") |>
    terra::project(crs) |>
    ext()

  tmp@ptr@.xData$vector
}