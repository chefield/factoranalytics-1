\name{fitStatisticalFactorModel}
\alias{fitStatisticalFactorModel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fit statistical factor model using principle components
}
\description{
Fit statistical factor model using principle components. This function is mainly
adapted from S+FinMetric function mfactor. 
}
\usage{
fitStatisticalFactorModel(x, k = 1, refine = TRUE, check = FALSE, max.k = NULL,
                           sig = 0.05, na.rm = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
T x N assets returns data which is saved as data.frame class.
}
  \item{k}{
numbers of factors if it is scalar or method of choosing optimal number of factors.
"bn" represents Bai and Ng (2002) method and "ck" represents  Connor and korajczyk
(1993) method. Default is k = 1.
}
  \item{refine}{
\code{TRUE} By default, the APCA fit will use the Connor-Korajczyk refinement.
}
  \item{check}{
check if some variables has identical values. Default is FALSE.
}
  \item{max.k}{
scalar, select the number that maximum number of factors to be considered.
}
  \item{sig}{ 
significant level when ck method uses.
}
  \item{na.rm}{
if allow missing values. Default is FALSE.
}
}

\value{
\item{factors}{
T x K the estimated factors.
}       
\item{loadings}{
K x N   the asset specific factor loadings beta_i estimated from regress the asset
 returns on factors.
}               
\item{alpha}{
1 x N  the estimated intercepts alpha_i
}         
\item{Omega}{
N x N asset returns sample variance covariance matrix.
}          
\item{r2}{
regression r square value from regress the asset returns on factors.
}             
\item{k}{
the number of the facotrs.
}             : 
\item{eigen}{
eigenvalues from the sample covariance matrix.
}          
\item{residuals}{
T x N matrix of residuals from regression.
}
\item{asset.ret}{
asset returns
}
\item{asset.fit}{
List of regression lm class of individual returns on factors.  
}
\item{residVars.vec}{
vector of residual variances 
}      
\item{mimic}{
N x K matrix of factor mimicking portfolio returns.
}         
}

\author{
Eric Zivot and Yi-An Chen
}

\examples{
# load data for fitStatisticalFactorModel.r
# data from finmetric berndt.dat and folio.dat

data(stat.fm.data)
##
# sfm.dat is for pca
# sfm.apca.dat is for apca
class(sfm.dat)
class(sfm.apca.dat)

# pca
args(fitStatisticalFactorModel)
sfm.pca.fit <- fitStatisticalFactorModel(sfm.dat,k=2)
class(sfm.pca.fit)
names(sfm.pca.fit)
sfm.pca.fit$factors
sfm.pca.fit$loadings
sfm.pca.fit$r2
sfm.pca.fit$residuals
sfm.pca.fit$residVars.vec
sfm.pca.fit$mimic
# apca
sfm.apca.fit <- fitStatisticalFactorModel(sfm.apca.dat,k=1)
names(sfm.apca.fit)
sfm.apca.res <- sfm.apca.fit$residuals
sfm.apca.mimic <- sfm.apca.fit$mimic
# apca with bai and Ng method
sfm.apca.fit.bn <- fitStatisticalFactorModel(sfm.apca.dat,k="bn")
class(sfm.apca.fit.bn)
names(sfm.apca.fit.bn)
sfm.apca.fit.bn$mimic

# apca with ck method
sfm.apca.fit.ck <- fitStatisticalFactorModel(sfm.apca.dat,k="ck")
class(sfm.apca.fit.ck)
names(sfm.apca.fit.ck)
sfm.apca.fit.ck$mimic
}
