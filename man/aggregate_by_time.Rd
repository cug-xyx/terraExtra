% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregate_to_yearly.R
\name{aggregate_by_time}
\alias{aggregate_by_time}
\title{Aggregating SparRaster based on different time scales}
\usage{
aggregate_by_time(r, fun = mean, by = "year", na.rm = TRUE, cores = 1, ...)
}
\arguments{
\item{r}{SparRaster}

\item{fun}{a function that operates on a vector or matrix. This can be a function that is defined in base-R or in a package, or a function you write yourself (see examples). Functions that return complex output (e.g. a list) may need to be wrapped in your own function to simplify the output to a vector or matrix. The following functions have been re-implemented in C++ for speed: "sum", "mean", "median", "modal", "which", "which.min", "which.max", "min", "max", "prod", "any", "all", "sd", "std", "first". To use the base-R function for say, "min", you could use something like \code{fun=function(i) min(i)} or the equivalent \code{fun = \\(i) min(i)}}

\item{by}{time scales (character). One of "day", "month" and "year"}

\item{na.rm}{a logical value indicating whether NA values should be stripped
before the computation proceeds.}

\item{cores}{positive integer. If \code{cores > 1}, a 'parallel' package cluster with that many cores is created and used. You can also supply a cluster object. Ignored for functions that are implemented by terra in C++ (see under fun)}

\item{...}{additional arguments for \code{fun}. These are typically numerical constants. They should *never* be another SpatRaster}
}
\value{
SpatRaster
}
\description{
Aggregating SparRaster based on different time scales
}
