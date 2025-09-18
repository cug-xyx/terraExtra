#' Aggregating SparRaster from 8-day to yearly
#'
#' @inheritParams terra::tapp
#' @param x a 8-day sacle SparRaster
#' @param agg_fun aggregate function
#' @param na.rm a logical value indicating whether NA values should be stripped
#'  before the computation proceeds.
#'
#' @import terra
#' @importFrom lubridate ymd year leap_year
#'
#' @return SpatRaster
#' @export
aggregate_8day_to_yearly <- function(x, agg_fun = sum, na.rm = TRUE, ...) {
  tm <- time(x)

  names(x) <- tm

  day8_to_yearly_inner <- function(x, na.rm = TRUE) {
    tm <- lubridate::ymd(names(x))

    yr <- lubridate::year(tm[1])

    w <- c(rep(8, 45), ifelse(lubridate::leap_year(yr), 6, 5))

    agg_fun(x * w, na.rm = na.rm)
  }

  # TODO: parallel is not working
  terra::tapp(
    x, index = "years", fun = day8_to_yearly_inner,
    na.rm = na.rm, ...
  )
}


#' Aggregate 8-day raster data to monthly totals
#'
#' @param x A SpatRaster with 8-day time series data.
#' @param agg_fun Aggregation function, e.g., sum or mean.
#' @param na.rm Logical, whether to remove NA values.
#' @param ... Additional arguments passed to terra::tapp.
#'
#' @return A SpatRaster aggregated to monthly scale.
#' 
#' @import terra
#' @importFrom lubridate ymd year month days_in_month
#' @export
aggregate_8day_to_monthly <- function(x, agg_fun = sum, na.rm = TRUE, ...) {
  tm <- time(x)
  names(x) <- tm

  day8_to_monthly_inner <- function(x, na.rm = TRUE) {
    tm <- lubridate::ymd(names(x))
    yr <- lubridate::year(tm[1])
    mo <- lubridate::month(tm[1])
    date_ym <- lubridate::ymd(sprintf("%d-%02d-01", yr, mo))

    ndays <- lubridate::days_in_month(date_ym)

    w <- diff(c(0, pmin(seq(8, 8 * length(x), by = 8), ndays)))

    agg_fun(x * w, na.rm = na.rm)
  }

  terra::tapp(
    x, index = "yearmonths", fun = day8_to_monthly_inner,
    na.rm = na.rm, ...
  )
}