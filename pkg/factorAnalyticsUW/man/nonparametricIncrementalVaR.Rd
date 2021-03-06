\name{nonparametricIncrementalVaR}
\alias{nonparametricIncrementalVaR}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute incremental VaR given bootstrap data and portfolio weights.
}
\description{
Compute incremental VaR given bootstrap data and portfolio weights.
Incremental VaR is defined as the change in portfolio VaR that occurs
when an asset is removed from the portfolio and allocation is spread equally
among remaining assets. VaR is computed using sample quantile.
}
\usage{
nonparametricIncrementalVaR(bootData, w, tail.prob = 0.01,i1,i2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
   \item{bootData}{
B x N matrix of B bootstrap returns on n assets in portfolio.
}
  \item{w}{
N x 1 vector of portfolio weights
  }
  \item{tail.prob}{
scalar tail probability.
}
 \item{i1,i2}{
if ff object is used,  the ffapply functions do apply an EXPRession and 
provide two indices FROM="i1" and TO="i2", which mark beginning and end 
of the batch and can be used in the applied expression.
 }
}

\value{
n x 1 matrix of incremental VaR values for each asset.
}
\references{
Jorian, P. (2007). Value-at-Risk, pg. 168.
}
\author{
Eric Zivot and Yi-An Chen.
}

\examples{
data(managers.df)
ret.assets = managers.df[,(1:6)]
nonparametricIncrementalVaR(ret.assets[,1:3],w=c(1/3,1/3,1/3),tail.prob = 0.05)
}
