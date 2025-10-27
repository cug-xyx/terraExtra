#' calculate hillshade
#'
#' @inheritParams terra::terrain
#' @inheritParams terra::direction
#'
#' @import terra
#'
#' @return Description of return value
#' @export
hillshade <- function(x, direction = c(285, 15, 60, 330)) {
  r_slope <- terra::terrain(x, "slope", unit = "radians")

  r_aspect <- terra::terrain(x, "aspect", unit = "radians")

  l_hillshade_multi <- lapply(c(285, 15, 60, 330), function(direc) {
    terra::shade(r_slope, r_aspect,
      angle = 45,
      direction = direc,
      normalize = TRUE
    )
  })

  sum(terra::rast(l_hillshade_multi))
}