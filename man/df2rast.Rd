% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_convert_tools.R
\name{df2rast}
\alias{df2rast}
\title{Converting data.table to SpatRaster}
\usage{
df2rast(df, crs = "EPSG:4326", extent = NULL, ...)
}
\arguments{
\item{df}{data.table}

\item{crs}{character. Description of the Coordinate Reference System (map projection) in \code{PROJ.4}, \code{WKT} or \code{authority:code} notation. See \code{\link[terra]{crs}}. If this argument is missing, and the x coordinates are within -360 .. 360 and the y coordinates are within -90 .. 90, longitude/latitude is assigned}

\item{extent}{object of class SpatExtent. If present, the arguments xmin, xmax, ymin and ymax are ignored}

\item{...}{additional arguments passed on to the \code{rast,missing-method}}
}
\value{
SpatRaster
}
\description{
Converting data.table to SpatRaster
}
