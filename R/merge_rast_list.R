#' Merging multiple SpatRasters
#'
#' @param l A list containing multiple SpatRaster
#'
#' @return SpatRaster
#' @export
merge_rast_list <- function(l) {
  nm <- names(l)

  if (is.null(nm)) {
    r <- return(do.call(c, l))
  }
  else {
    names(l)[1] <- "x"
    r <- do.call(c, l) |> `names<-`(nm)
  }

  r
}
