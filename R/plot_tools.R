#' Draw significant grid with line segments
#'
#'
#' @inherit graphics::segments
#' @param r SpatRaster
#' @param pvalue p value
#' @param col color
#' @param lwd line width
#' @param half_line whether draw half line for each cell
#'
#' @importFrom graphics segments
#'
#' @return plot
#' @export
significance <- function(r, pvalue = 0.05, col = 'black', lwd = 0.1,
                         half_line = TRUE, ...) {
  if (terra::nlyr(r) > 1)
    stop("Only one layer of significance data can be included in parameter r")

  cell_res <- terra::res(r)
  names(r) <- "pvalue"

  r <- terra::ifel(r <= pvalue, 1, NA)

  # rast2df
  df <- data.table::as.data.table(r, xy=TRUE)
  colnames(df) <- c("x", "y", "pvalue")

  for (i in 1:nrow(df)) {
    x_mid = df[i, x]
    y_mid = df[i, y]

    if (half_line) {
      x = x_mid
      y = y_mid
    } else {
      x = x_mid - cell_res[1] / 2
      y = y_mid - cell_res[2] / 2
    }

    x_end = x_mid + cell_res[1]
    y_end = y_mid + cell_res[2]

    graphics::segments(x, y, x_end, y_end, col = col, lwd=lwd, ...)
  }
}
