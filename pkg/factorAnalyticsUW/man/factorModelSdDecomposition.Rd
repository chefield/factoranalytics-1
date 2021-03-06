\name{factorModelSdDecomposition}
\alias{factorModelSdDecomposition}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute factor model factor risk (sd) decomposition for individual fund.
}
\description{
Compute factor model factor risk (sd) decomposition for individual fund.
}
\usage{
factorModelSdDecomposition(beta.vec, factor.cov, sig2.e)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{beta.vec}{
k x 1 vector of factor betas with factor names in the rownames.
}
  \item{factor.cov}{
k x k factor excess return covariance matrix.
}
  \item{sig2.e}{
scalar, residual variance from factor model.
}
}

\value{
\item{sd.fm}{
Scalar, std dev based on factor model.
}
\item{mcr.fm}{
(K+1) x 1 vector of factor marginal contributions to risk (sd).
}          
\item{cr.fm}{
(K+1) x 1 vector of factor component contributions to risk (sd).
}      
\item{pcr.fm}{
(K+1) x 1 vector of factor percent contributions to risk (sd).
}             
}

\author{
Eric Zivot and Yi-An Chen
}

\examples{
# load data from the database
data(managers.df)
ret.assets = managers.df[,(1:6)]
factors    = managers.df[,(7:9)]
# fit the factor model with OLS
fit <- fitMacroeconomicFactorModel(ret.assets,factors,fit.method="OLS", 
                                 variable.selection="all subsets",
                                 factor.set = 3)
# factor SD decomposition for HAM1
cov.factors = var(factors)
manager.names = colnames(managers.df[,(1:6)])
factor.names  = colnames(managers.df[,(7:9)])
factor.sd.decomp.HAM1 = factorModelSdDecomposition(fit$beta.mat["HAM1",],
                                                   cov.factors, fit$residVars.vec["HAM1"])
 
                                                        
}
