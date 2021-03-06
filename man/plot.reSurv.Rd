% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.R
\name{plot.reSurv}
\alias{plot.reSurv}
\title{Produce Event Plot or Cumulative Sample Mean Function Plot}
\usage{
\method{plot}{reSurv}(x, CSM = FALSE, order = TRUE, control = list(),
  ...)
}
\arguments{
\item{x}{an object of class \code{reSurv}, usually returned by the \code{reSurv} function.}

\item{CSM}{an optional logical value indicating whether the cumulative sample mean (CSM) function will
be plotted instead of the event plot (default).}

\item{order}{an optional logical value indicating whether the event plot (when \code{CSM = FALSE})
will be sorted by the terminal times.}

\item{control}{a list of control parameters. See \bold{Details}.}

\item{...}{graphical parameters to be passed to methods.
These include \code{xlab}, \code{ylab} and \code{main}.}
}
\value{
A \code{ggplot} object.
}
\description{
Plot the event plot or the cumulative sample mean (CSM) function for an \code{reSurv} object.
}
\details{
The argument \code{control} consists of options with argument defaults to a list with the following values:
\describe{
  \item{xlab}{customizable x-label, default value is "Time".}
  \item{ylab}{customizable y-label, default value is "Subject" for event plot and "Cumulative mean" for CSM plot.}
  \item{main}{customizable title, the default value is "Recurrent event plot" when \code{CSM = FALSE} and
"Sample cumulative mean function plot" when \code{CSM = TRUE}.}
  \item{terminal.name}{customizable label for terminal event, default value is "Terminal event".}
  \item{recurrent.name}{customizable legend title for recurrent event, default value is "Recurrent events".}
  \item{recurrent.types}{customizable label for recurrent event type, default value is \code{NULL}.}
  \item{alpha}{between 0 and 1, controls the transparency of points.}
}
The \code{xlab}, \code{ylab} and \code{main} parameters can also be passed down without specifying a \code{control} list.
}
\examples{
set.seed(1)
dat <- simSC(30, c(-1, 1), c(-1, 1))
reObj <- with(dat, reSurv(Time, id, event, status))

## Event plots:
## Default labels
plot(reObj)
plot(reObj, order = FALSE)
## User specified labels
plot(reObj, control = list(xlab = "User xlab", ylab = "User ylab", main = "User title"))

## With hypothetical multiple event types
set.seed(1)
reObj2 <- with(dat, reSurv(Time, id, event * sample(1:3, nrow(dat), TRUE), status))
plot(reObj2)

## CSM plots
plot(reObj, CSM = TRUE)
}
\seealso{
\code{\link{reSurv}}
}
\keyword{Plots}
