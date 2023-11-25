#' Aggregating SparRaster based on different time scales
#'
#' @inheritParams terra::app
#' @param r SparRaster
#' @param by time scales (character). One of "day", "month" and "year"
#' @param na.rm a logical value indicating whether NA values should be stripped
#'  before the computation proceeds.
#'
#' @import terra
#'
#' @return SpatRaster
#' @export
aggregate_by_time <- function(r, fun=mean, by='year', na.rm=TRUE, cores=1, ...) {
  tm <- terra::time(r) |> as.Date()
  tm_unique <- unique(tm)

  # TODO：names

  if (length(tm_unique) == 1 && is.na(tm_unique)) stop("No time attributes")

  if (by == "year") {
    tm <- format(tm, "%Y") |> paste0("-01-01") |> as.Date()
  }
  else if (by == "month") {
    tm <- format(tm, "%Y-%m") |> paste0("-01") |> as.Date()
  }
  else if (by == "day") {}
  else {
    stop("Incorrect argument 'by'")
  }
  tm_unique <- unique(tm)

  l_rs <- lapply(tm_unique, function(t) {
    inds <- which(t == tm)

    r_res <- terra::app(r[[inds]], fun, na.rm=na.rm, cores=cores, ...)
    terra::time(r_res) <- t

    r_res
  })

  do.call(c, l_rs)
}

