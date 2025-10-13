#' Correlation Coeficient
#'
#' @export
cor.test <- function(x, y, ...) {
  UseMethod("cor.test")
}


#' @importFrom stats cor.test
#'
#' @export
cor.test.default <- function(x, y, ...) {
  stats::cor.test(x, y, ...)
}


#' @importFrom stats cor.test
#' @import terra
#'
#' @export
cor.test.SpatRaster <- function(x, y, cores = 1, method = "pearson", ...) {
  if (!inherits(y, "SpatRaster")) {
    stop("Both x and y must be SpatRaster objects!")
  }

  fun_cor <- function(v, method = "pearson") {
    v <- as.numeric(v)

    n <- length(v) / 2

    x <- v[1:n]
    y <- v[(n + 1):(2 * n)]

    ok <- is.finite(x) & is.finite(y)
    x <- x[ok]
    y <- y[ok]

    if (length(x) < 3) return(c(r = NA, pvalue = NA))

    res <- tryCatch({
      res_cor <- stats::cor.test(x, y, method = method)
      c(r = unname(res_cor$estimate), pvalue = res_cor$p.value)
    }, error = function(e) {
      c(r = NA, pvalue = NA)
    })

    res
  }

  environment(fun_cor) <- baseenv()

  r_all <- c(x, y)
  r_res <- terra::app(r_all, fun = fun_cor, cores = cores, method = method, ...)

  r_res
}