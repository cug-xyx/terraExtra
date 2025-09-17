#' Filter SpatRaster layers by time attributes
#'
#' @param r a SpatRaster object
#'
#' @importFrom lubridate ymd
#'
#' @return SpatRaster
#' @export
#'
#' @examples filter_date(r, start=20010101, end=20010102)
filter_date <- function(r, start=NULL, end=NULL) {
  t <- time(r)
  if (is.na(t[1])) stop("SpatRaster does not have time attribute")

  # TODO: time sacle, like hourly daily monthly and yearly
  t_daily <- as.Date(t)
  n <- length(t_daily)

  if (is.null(start)) {
    start <- t_daily[1]
  } else {
    start <- lubridate::ymd(start)
  }
  if (is.null(end)) {
    end <- t_daily[n]
  } else {
    end <- lubridate::ymd(end)
  }

  inds <- which((start <= t_daily) & (end >= t_daily))

  r[[inds]]
}
