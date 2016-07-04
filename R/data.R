#' The pathfinder network
#'
#' The pathfinder network from the \href{http://www.bnlearn.com/bnrepository/#pathfinder}{Bayesian network repository}.
#' Pathfinder is an expert system developed in 1992 by Heckerman et. al
#' to assist with the diagnosis of lymph-node diseases.
#'
#' @format An \code{\link{edgeList}} object with 109 nodes and 195 edges.
#'
"pathfinder"

#' The cytometry network
#'
#' Data and network for analyzing the flow cytometry experiment
#' from \href{http://science.sciencemag.org/content/308/5721/523.long}{Sachs et al. (2005)}.
#' The data is a cleaned and discretized version of the raw data from these experiments.
#'
#' @format A \code{\link{list}} with three components:
#'
#' \itemize{
#' \item \code{dag} An \code{\link[sparsebnUtils]{edgeList}} containing the consensus network (11 nodes, 17 edges).
#' \item \code{data} A \code{\link{data.frame}} with 11 variables and 5400 observations.
#' \item \code{ivn} A \code{\link{list}} specifying which nodes are under intervention in each observation.
#' Compatible with the input to \code{\link[sparsebnUtils]{sparsebnData}}.
#' }
#'
"cytometry"
