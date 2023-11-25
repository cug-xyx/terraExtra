#' Converting array or matrix to SpatRaster
#'
#' @inheritParams terra::rast
#' @param arr array or matrix
#' @param varname variable name (character)
#'
#' @import terra
#'
#' @return SpatRaster
#' @export
array2rast <- function(arr, varname = NULL, crs = "EPSG:4326", extent = NULL, ...) {
  r <- terra::rast(arr, crs = crs, extent = extent, ...)

  if (is.null(varname)) varname <- "lyr"

  names(r) <- paste0(varname, "_", 1:terra::nlyr(r))

  r
}


#' Converting data.table to SpatRaster
#'
#' @inheritParams terra::rast
#' @param df data.table
#'
#' @return SpatRaster
#' @export
df2rast <- function(df, crs = "EPSG:4326", extent = NULL, ...) {
  terra::rast(df, crs = crs, extent = extent, ...)
}


#' Converting SpatRaster to data.table
#'
#' @inheritParams data.table::melt
#' @param r SpatRaster
#' @param melt whether or not to use the 'melt' function on data.table
#'
#' @importFrom data.table as.data.table melt
#'
#' @return data.table
#' @export
rast2df <- function(r, melt=FALSE, ...) {
  df <- data.table::as.data.table(r, xy = T)
  colnames(df)[1:2] <- c("lon", "lat")

  if (melt) df <- data.table::melt(df, c("lon", "lat"), ...)

  df
}
