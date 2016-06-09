#
#  sparsebn-main.R
#  sparsebn
#
#  Created by Bryon Aragam (local) on 5/11/16.
#  Copyright (c) 2016 Bryon Aragam. All rights reserved.
#

#
# PACKAGE SPARSEBN: Main method for DAG estimation
#
#   CONTENTS:
#       estimate.dag
#

#' Estimate a DAG from data
#'
#' Estimate the structure of a DAG (Bayesian network) from data. Works with any
#' combination of discrete / continuous and observational / experimental data.
#'
#' For details on the underlying methods, see \code{\link[ccdrAlgorithm]{ccdr.run}}
#' and \code{\link[discretecdAlgorithm]{cd.run}}.
#'
#' @param data Data as \code{\link[sparsebnUtils]{sparsebnData}}.
#' @param lambdas (optional) Numeric vector containing a grid of lambda values (i.e. regularization
#'                parameters) to use in the solution path. If missing, a default grid of values will be
#'                used based on a decreasing log-scale  (see also \link[sparsebnUtils]{generate.lambdas}).
#' @param lambdas.length Integer number of values to include in the solution path. If \code{lambdas}
#'                       has also been specified, this value will be ignored.
#' @param error.tol Error tolerance for the algorithm, used to test for convergence.
#' @param max.iters Maximum number of iterations for each internal sweep.
#' @param edge.threshold Threshold parameter used to terminate the algorithm whenever the number of edges in the
#'              current estimate has \code{> edge.threshold} edges.
#' @param concavity (CCDr only) Value of concavity parameter. If \code{gamma > 0}, then the MCP will be used
#'              with \code{gamma} as the concavity parameter. If \code{gamma < 0}, then the L1 penalty
#'              will be used and this value is otherwise ignored.
#' @param weight.scale (CD only) A postitive number to scale weight matrix.
#' @param convLb (CD only) Small positive number used in Hessian approximation.
#' @param upperbound (CD only) A large positive value used to truncate the adaptive weights. A -1 value indicates that there is no truncation.
#' @param verbose \code{TRUE / FALSE} whether or not to print out progress and summary reports.
#'
#' @return A \code{\link[sparsebnUtils]{sparsebnPath}} object.
#'
#' @export
estimate.dag <- function(data,
                         lambdas = NULL,
                         lambdas.length = 20,
                         error.tol = 1e-4,
                         max.iters = NULL,
                         edge.threshold = NULL,
                         concavity = 2.0,
                         weight.scale = 1.0,
                         convLb = 0.01,
                         upperbound = 100.0,
                         verbose = FALSE
){
    pp <- ncol(data$data)

    ### Set edge threshold (alpha in paper)
    if(is.null(edge.threshold)){
        alpha <- sparsebnUtils::default_alpha() # by default, stop when nedge > 10*pp
    } else{
        alpha <- edge.threshold / pp
    }

    ### Set default value for maximum number of iterations run in algorithms
    if(is.null(max.iters)){
        max.iters <- sparsebnUtils::default_max_iters(pp)
    }

    ### Is the data gaussian, binomial, or multinomial? (Other data not supported yet.)
    data_family <- sparsebnUtils::pick_family(data)

    ### Run the main algorithms
    if(data_family == "gaussian"){
        ccdrAlgorithm::ccdr.run(data = data,
                                lambdas = lambdas,
                                lambdas.length = lambdas.length,
                                gamma = concavity,
                                error.tol = error.tol,
                                max.iters = max.iters,
                                alpha = alpha,
                                verbose = verbose)
    } else if(data_family == "binomial" || data_family == "multinomial"){
        ### Note that interventions are automatically handled by this method, if present
        discretecdAlgorithm::cd.run(indata = data,
                                    lambdas = lambdas,
                                    lambdas.length = lambdas.length,
                                    error.tol = error.tol,
                                    convLb = convLb,
                                    weight.scale = weight.scale,
                                    upperbound = upperbound)
    }
}
