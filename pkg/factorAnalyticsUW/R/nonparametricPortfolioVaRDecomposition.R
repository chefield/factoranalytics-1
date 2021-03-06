nonparametricPortfolioVaRDecomposition <-
function(bootData, w, delta.w = 0.001, tail.prob = 0.01,
                                                   method=c("derivative", "average")) {
## Compute portfolio VaR decomposition given historical or simulated data and portfolio weights.
## The partial derivative of VaR wrt factor beta is computed
## as the expected factor return given fund return is equal to its VaR and approximated by kernel estimator.
## VaR is compute either as the sample quantile. 
## inputs:
## bootData   B x n matrix of B bootstrap returns on assets in portfolio.
## w          n x 1 vector of portfolio weights
## delta.w    scalar, change in portfolio weight for computing numerical derivative
## tail.prob  scalar, tail probability 
## method     character, method for computing marginal VaR. Valid choices are
##            "derivative" for numerical computation of the derivative of portfolio
##            VaR wrt fund portfolio weight; "average" for approximating E[Ri | Rp =VaR]
## output:
## VaR.p       scalar, portfolio VaR reported as a positive number
## n.exceed   scalar, number of VaR exceedences
## idx.exceed n.exceed x 1 vector of exceedence indices
## mVaR        1 x n matrix of marginal VaR values for each fund
## cVaR        1 x n matrix of component VaR values
## pcVaR       1 x n matrix of percent contributions to portfolio VaR values
## References:
## 1. Hallerback (2003), "Decomposing Portfolio Value-at-Risk: A General Analysis",
##    The Journal of Risk 5/2.
## 2. Yamai and Yoshiba (2002). "Comparative Analyses of Expected Shortfall and
##    Value-at-Risk: Their Estimation Error, Decomposition, and Optimization
##    Bank of Japan.
## 3. Epperlein and Smillie (2006) "Cracking VAR with Kernels," Risk.  
  require(PerformanceAnalytics)
  method = method[1]
  bootData = as.matrix(bootData)
  w = as.matrix(w)
  if ( ncol(bootData) != nrow(w) )
    stop("Columns of bootData and rows of w do not match")
  if ( tail.prob < 0 || tail.prob > 1)
    stop("tail.prob must be between 0 and 1")

  n.w = nrow(w)

  ## portfolio VaR and ES with all assets
  r.p = bootData %*% w
   ## epsilon is calculated in the sense of minimizing mean square error by Silverman 1986
   epi <- 2.575*sd(bootData[,1]) * (nrow(bootData)^(-1/5))
   VaR.p = quantile(r.p, prob=tail.prob)
   idx = which(r.p <= VaR.p + epi & r.p >= VaR.p - epi)
    
  ##
  ## compute marginal VaR
  ##
  if (method=="derivative") {
  ## compute marginal ES as derivative wrt portfolio weight
    temp.w = w
    mVaR = matrix(0, n.w, 1)
    for (i in 1:n.w) {
    ## increment weight for asset i by delta.w
      temp.w[i,1] = w[i,1] + delta.w
      temp.r.p = bootData %*% temp.w
      VaR.p.new = quantile(temp.r.p, prob=tail.prob)
      mVaR[i,1] = (-VaR.p.new - (-VaR.p))/delta.w
    ## reset weight
      temp.w = w
    }
  } else {
  ## compute marginal VaR as expected value of factor return given 
  ## triangler kernel
    if (ncol(bootData) > 1) {
           if (length(idx)==1){
        mVaR = - as.matrix(bootData[idx,])
      } else{
         mVaR = -as.matrix(colMeans(bootData[idx,]))
      }
        } else {
      mVaR = -as.matrix(mean(bootData[idx, ]))
    }
  }
## compute correction factor so that sum of weighted marginal VaR adds to portfolio VaR
cf = as.numeric( -VaR.p / sum(mVaR*w) )
mVaR = cf*mVaR

## compute component and percent ES
cVaR = mVaR * w
pcVaR = cVaR/-VaR.p
rownames(mVaR) = colnames(bootData)
colnames(mVaR) = "MVaR"
colnames(cVaR) = "CVaR"
colnames(pcVaR) = "PCVaR"

ans = list(VaR.p = -VaR.p,
           n.exceed = length(idx),
           idx.exceed = idx,
           mVaR = t(mVaR),
           cVaR = t(cVaR),
           pcVaR = t(pcVaR))
return(ans)
}

