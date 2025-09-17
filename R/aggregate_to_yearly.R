#' Aggregating SparRaster from 8-day to yearly
#'
#' @inheritParams terra::app
#' @param r a 8-day sacle SparRaster
#' @param fun aggregate function
#' @param na.rm a logical value indicating whether NA values should be stripped
#'  before the computation proceeds.
#'
#' @import terra
#' @importFrom lubridate ymd year leap_year
#'
#' @return SpatRaster
#' @export
aggregate_8day_to_yearly <- function(x, fun = "sum", na.rm = TRUE, ...) {
  tm <- time(x)

  names(x) <- tm

  aggregate_8day_to_yearly_inner <- function(x, fun = fun, na.rm = TRUE) {
    tm <- lubridate::ymd(names(x))

    yr <- lubridate::year(tm[1])

    w <- c(rep(8, 45), ifelse(lubridate::leap_year(yr), 6, 5))

    fun(x * w, na.rm = na.rm)
  }

  # TODO: parallel is not working
  terra::tapp(
    x, index = "years", fun = aggregate_8day_to_yearly_inner,
    na.rm = na.rm, ...
  )
}