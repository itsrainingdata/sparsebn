#' sparsebn: Learning Sparse Bayesian Networks from High-Dimensional Data.
#'
#' Methods for learning sparse Bayesian networks and other graphical models from
#' observational and experimental data via sparse regularization. Includes algorithms
#' for both continuous and discrete data.
#'
#' The main methods for learning graphical models in \code{\link{sparsebn}} are:
#'
#' \itemize{
#' \item \code{\link{estimate.dag}} for directed acyclic graphs.
#' \item \code{\link{estimate.precision}} for undirected graphs.
#' \item \code{\link{estimate.covariance}} for covariance matrices.
#' }
#'
#' The workhorse behind \code{\link{sparsebn}} is the \code{\link[sparsebnUtils]{sparsebnUtils}}
#' package, which provides various S3 classes and methods for representing and manipulating graphs.
#' For more details on this package and the functionality it provides, see \code{?sparsebnUtils}.
#'
#' @docType package
#' @name sparsebn
NULL