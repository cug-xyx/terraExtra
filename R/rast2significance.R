rast2signif <- NULL

#' Generating a function that can convert rast to significane hatch line
#'
#' @return function
#' @export
rast2significance <- function() {
  t_function <-
    '
    function(r, p = 0.05, vect_class=FALSE, ...) {
      df <- data.table::as.data.table(r, xy = T)
      colnames(df) <- c("lon", "lat", "pvalue")
      df <- df |> subset(pvalue <= p)
      if (nrow(df) == 0) stop("Less than one point")

      poly <- gg.layers::st_point2poly(df) |> gg.layers::st_hatched_polygon(...)

      if (vect_class) {
        poly <- terra::vect(poly)
      }

      poly
    }
    '
  parse(text = t_function) |> eval()
}
