#' Reading multiple files with terra::rast
#'
#' @inheritParams terra::rast
#' @param path multiple file paths or folder path (character)
#' @param merge whether to merge into one SpatRaster
#'
#' @import terra
#'
#' @return a list or SpatRaster
#' @export
rast_multifiles <- function(path, merge=TRUE, ...) {
  if (length(path) == 1 && is_dir(path)) path <- dir(path, full.names = T)

  r <- lapply(path, terra::rast, ...)

  if (merge) r <- merge_rast_list(r)

  r
}

#' Check if the path is a folder
#'
#' @param path file or folder path (character)
#'
#' @return logical
#' @export
is_dir <- function(path) {
  file.info(path)$isdir
}
