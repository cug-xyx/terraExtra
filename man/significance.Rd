% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_tools.R
\name{significance}
\alias{significance}
\title{Draw significant grid with line segments}
\usage{
significance(r, pvalue = 0.05, col = "black", lwd = 0.1, half_line = TRUE, ...)
}
\arguments{
\item{r}{SpatRaster}

\item{pvalue}{p value}

\item{col}{color}

\item{lwd}{line width}

\item{half_line}{whether draw half line for each cell}

\item{...}{further \link[graphics]{graphical parameters} (from \code{\link[graphics]{par}}),
    such as \code{xpd} and the line characteristics \code{lend}, \code{ljoin}
    and \code{lmitre}.}
}
\value{
plot
}
\description{
Draw line segments between pairs of points.
}
\details{
For each \code{i}, a line segment is drawn between the point
  \code{(x0[i], y0[i])} and the point \code{(x1[i], y1[i])}.  The
  coordinate vectors will be recycled to the length of the longest.

  The \link[graphics]{graphical parameters} \code{col}, \code{lty} and \code{lwd} can be
  vectors of length greater than one and will be recycled if necessary.
}
\examples{
x <- stats::runif(12); y <- stats::rnorm(12)
i <- order(x, y); x <- x[i]; y <- y[i]
plot(x, y, main = "arrows(.) and segments(.)")
## draw arrows from point to point :
s <- seq(length(x)-1)  # one shorter than data
arrows(x[s], y[s], x[s+1], y[s+1], col= 1:3)
s <- s[-length(s)]
segments(x[s], y[s], x[s+2], y[s+2], col= 'pink')
}
\references{
Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988)
  \emph{The New S Language}.
  Wadsworth & Brooks/Cole.
}
\seealso{
\code{\link[graphics]{arrows}},
  \code{\link[graphics]{polygon}} for slightly easier and less flexible line
  drawing, and
  \code{\link[graphics]{lines}} for the usual polygons.
}
