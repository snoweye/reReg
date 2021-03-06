% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reReg.R
\name{reReg}
\alias{reReg}
\title{Fits Semiparametric Regression Models for Recurrent Event Data}
\usage{
reReg(formula, data, B = 200, method = c("cox.LWYY", "cox.GL",
  "cox.HW", "am.GL", "am.XCHWY", "sc.XCYH"), se = c("NULL", "bootstrap",
  "resampling"), contrasts = NULL, control = list())
}
\arguments{
\item{formula}{a formula object, with the response on the left of a "~" operator, and the predictors on the right.
The response must be a recurrent event survival object as returned by function \code{reSurv}.}

\item{data}{an optional data frame in which to interpret the variables occurring in the \code{"formula"}.}

\item{B}{a numeric value specifies the number of resampling for variance estimation.
When \code{B = 0}, variance estimation will not be performed.}

\item{method}{a character string specifying the underlying model. See \bold{Details}.}

\item{se}{a character string specifying the method for standard error estimation. See \bold{Details}.}

\item{contrasts}{an optional list.}

\item{control}{a list of control parameters.}
}
\description{
Fits a semiparametric regression model for the recurrent event data.
The rate function of the underlying process for the recurrent event process
can be specified as a Cox-type model, an accelerated mean model, or a generalized scale-change model.
See details for model specifications.
}
\details{
Suppose the recurrent event process and the failure events are observed in the time interval \eqn{t\in[0,\tau]},
for some constant \eqn{\tau}.
We formulate the rate function, \eqn{\lambda(t)}, for the recurrent event process and
the hazard function, \eqn{h(t)}, for the censoring time
under the following model specifications:
\describe{
  \item{Cox-type model:}{
\deqn{\lambda(t) = Z \lambda_0(t) e^{X^\top\alpha}, h(t) = Z h_0(t)e^{X^\top\beta},}}
  \item{Accelerated mean model:}{
\deqn{\lambda(t) = Z \lambda_0(te^{X^\top\alpha})e^{X^\top\alpha}, h(t) = Z h_0(te^{X^\top\beta})e^{X^\top\beta},}}
  \item{Scale-change model:}{
\deqn{\lambda(t) = Z \lambda_0(te^{X^\top\alpha})e^{X^\top\beta},}}
}
where \eqn{\lambda_0(t)} is the baseline rate function, \eqn{h_0(t)} is the baseline hazard function,
\eqn{X} is a \eqn{n} by \eqn{p} covariate matrix and \eqn{\alpha},
\eqn{Z} is an unobserved shared frailty variable,
and \eqn{\beta} are unknown \eqn{p}-dimensional regression parameters.

The \code{reReg} function fits models with the following available methods:
\describe{
  \item{\code{method = "cox.LWYY"}}{
assumes the Cox-type model with \code{Z = 1} and requires independent censoring. 
The returned result is equivalent to that from \code{coxph}. See reference Lin et al. (2000).}
  \item{\code{method = "cox.HW"}}{
assumes the Cox-type model with unspecified \code{Z}, thus accommodate informative censoring.
See the references See reference Wang, Qin and Chiang (2001) and Huang and Wang (2004).}
  \item{\code{method = "am.GL"}}{
assumes the accelerated mean model with \code{Z = 1} and requires independent censoring. 
See the reference Ghosh and Lin (2003).}
  \item{\code{method = "am.XCHWY"}}{
assumes the accelerated mean model with unspecified \code{Z}, thus accommodate informative censoring.
See the reference Xu et al. (2017).}
  \item{\code{method = "sc.XCYH"}}{
assumes the generalized scale-change model, and includes the methods \code{"cox.HW"} and \code{"am.XCHWY"} as special cases.
Informative censoring is accounted for through the unspecified frailty variable \code{Z}.
The methods also provide a hypothesis test of these submodels.}
}

The available methods for variance estimation are:
\describe{
  \item{\code{NULL}}{variance estimation will not be performed. This is equivalent to setting \code{B = 0}.}
  \item{\code{"resampling"}}{performs the efficient resampling-based sandwich estimator that works with methods \code{"cox.HW"}, \code{"am.XCHWY"} and \code{"sc.XCYH"}.}
  \item{\code{"bootstrap"}}{works with all fitting methods.}
}

The \code{control} list consists of the following parameters:
\describe{
  \item{\code{tol}}{absolute error tolerance.}
  \item{\code{a0, b0}}{initial guesses used for root search.}
  \item{\code{solver}}{the equation solver used for root search.
The available options are \code{BB::BBsolve}, \code{BB::dfsane}, \code{BB:BBoptim}, and \code{optim}.}
  \item{\code{parallel}}{an logical value indicating whether parallel computation will be applied when \code{se = "bootstrap"} is called.}
  \item{\code{parCl}}{an integer value specifying the number of CPU cores to be used when \code{parallel = TRUE}.
The default value is half the CPU cores on the current host.}
}
}
\examples{
set.seed(1)
dat <- simSC(80, c(-1, 1), c(-1, 1), type = "am")
## Accelerated Mean Model
(fit <- reReg(reSurv(Time, id, event, status) ~ x1 + x2, 
        data = dat, method = "am.XCHWY", se = "resampling", B = 20))
summary(fit)

## Generalized Scale-Change Model
set.seed(1)
dat <- simSC(100, c(-1, 1), c(-1, 1), type = "sc")
(fit <- reReg(reSurv(Time, id, event, status) ~ x1 + x2, 
              data = dat, method = "sc.XCYH", se = "resampling", B = 20))
summary(fit)
}
\references{
Xu, G., Chiou, S.H., Huang, C.-Y., Wang, M.-C. and Yan, J. (2017). Joint Scale-change Models for Recurrent Events and Failure Time.
\emph{Journal of the American Statistical Association}, \bold{112}(518): 796--805.

Lin, D., Wei, L., Yang, I. and Ying, Z. (2000). Semiparametric Regression for the Mean and Rate Functions of Recurrent Events.
\emph{Journal of the Royal Statistical Society: Series B (Methodological)}, \bold{62}: 711--730.

Wang, M.-C., Qin, J., and Chiang, C.-T. (2001). Analyzing Recurrent Event Data with Informative Censoring.
\emph{Journal of the American Statistical Association}, \bold{96}(455): 1057--1065.

Ghosh, D. and Lin, D.Y. (2003). Semiparametric Analysis of Recurrent Events Data in the Presence of Dependent Censoring.
\emph{Biometrics}, \bold{59}: 877--885.

Huang, C.-Y. and Wang, M.-C. (2004). Joint Modeling and Estimation for Recurrent Event Processes and Failure Time Data.
\emph{Journal of the American Statistical Association}, \bold{99}(468): 1153--1165.
}
\seealso{
\code{\link{reSurv}}, \code{\link{simSC}}
}
