#' The pathfinder network
#'
#' Simulated data and network for the pathfinder network from the
#' \href{http://www.bnlearn.com/bnrepository/#pathfinder}{Bayesian network repository}.
#' Pathfinder is an expert system developed by
#' \href{http://heckerman.com/david/HN92cbr.pdf}{Heckerman et. al (1992)} [1]
#' to assist with the diagnosis of lymph-node diseases.
#'
#' This is a benchmark network used to test algorithms for learning Bayesian
#' networks. The data is simulated from a Gaussian SEM assuming unit edge weights and
#' unit variances for all nodes.
#'
#' @format A \code{\link{list}} with four components:
#'
#' \itemize{
#' \item \code{dag} An \code{\link[sparsebnUtils]{edgeList}} containing the pathfinder network (109 nodes, 195 edges).
#' \item \code{data} A \code{\link{data.frame}} with 109 variables and 1000 observations.
#' \item \code{ivn} A \code{\link{list}} specifying which nodes are under intervention in each observation; since this dataset
#' is purely observational, this is just \code{NULL}. Compatible with the input to \code{\link[sparsebnUtils]{sparsebnData}}.
#' \item \code{cov} Covariance matrix used to generate the data.
#' }
#'
#' @format An \code{\link{edgeList}} object with 109 nodes and 195 edges.
#'
#' @usage
#' data(pathfinder)
#'
#' @references
#' [1] Heckerman, David E., and Bharat N. Nathwani. "\href{http://heckerman.com/david/HN92cbr.pdf}{An evaluation of the diagnostic accuracy of Pathfinder}." Computers and Biomedical Research 25.1 (1992): 56-74.
#'
#' @examples
#' \dontrun{
#' # Create a valid sparsebnData object from the simulated pathfinder data
#' data(pathfinder)
#' dat <- sparsebnData(pathfinder$data, type = "c")
#'
#' # If desired, change the edge weights to be randomly generated
#' coefs <- get.adjacency.matrix(pathfinder$dag)
#' coefs[coefs != 0] <- runif(n = num.edges(pathfinderDAG), min = 0.5, max = 2)
#' vars <- Matrix::Diagonal(n = num.nodes(pathfinderDAG), x = rep(1, num.nodes(pathfinderDAG)))
#' id <- vars
#' covMat <- t(solve(id - coefs)) %*% vars %*% solve(id - coefs)
#' pathfinder.data <- rmvnorm(n = 1000, sigma = as.matrix(covMat))
#' }
#'
"pathfinder"

#' The discrete cytometry network
#'
#' Data and network for analyzing the flow cytometry experiment
#' from \href{http://science.sciencemag.org/content/308/5721/523.long}{Sachs et al. (2005)} [1].
#' The data is a cleaned and discretized version of the raw data (see
#' \code{\link{cytometryContinuous}} for details) from these experiments.
#'
#' After cleaning and pre-processing, the raw continuous measurements have been
#' binned into one of three levels: low = 0, medium = 1, or high = 2. Due to the
#' pre-processing, the discrete data contains fewer observations (n = 5400)
#' compared to the raw, continuous data.
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
#' @usage
#' data(cytometryDiscrete)
#'
#' @references
#' [1] Sachs, Karen, et al. "\href{http://science.sciencemag.org/content/308/5721/523.long}{Causal protein-signaling networks derived from multiparameter single-cell data}." Science 308.5721 (2005): 523-529.
#'
#' @examples
#' # Create a valid sparsebnData object from the cytometry data
#' data(cytometryDiscrete)
#' dat <- sparsebnData(cytometryDiscrete$data, type = "d", ivn = cytometryDiscrete$ivn)
#'
"cytometryDiscrete"

#' The continuous cytometry network
#'
#' Data and network for analyzing the flow cytometry experiment
#' from \href{http://science.sciencemag.org/content/308/5721/523.long}{Sachs et al. (2005)} [1].
#' This dataset contains the raw measurements from these experiments.
#'
#' The dataset consists of n = 7466 observations of p = 11 continuous
#' variables corresponding to different proteins and phospholipids in human
#' immune system cells, and each observation indicates the measured level of
#' each biomolecule in a single cell under different experimental interventions.
#' Based on this data, a consensus network was reconstructed and validated, which
#' is included as well.
#'
#' @format A \code{\link{list}} with three components:
#'
#' \itemize{
#' \item \code{dag} An \code{\link[sparsebnUtils]{edgeList}} containing the consensus network (11 nodes, 17 edges).
#' \item \code{data} A \code{\link{data.frame}} with 11 variables and 7466 observations.
#' \item \code{ivn} A \code{\link{list}} specifying which nodes are under intervention in each observation.
#' Compatible with the input to \code{\link[sparsebnUtils]{sparsebnData}}.
#' }
#'
#' @usage
#' data(cytometryContinuous)
#'
#' @references
#' [1] Sachs, Karen, et al. "\href{http://science.sciencemag.org/content/308/5721/523.long}{Causal protein-signaling networks derived from multiparameter single-cell data}." Science 308.5721 (2005): 523-529.
#'
#' @examples
#' # Create a valid sparsebnData object from the cytometry data
#' data(cytometryContinuous)
#' dat <- sparsebnData(cytometryContinuous$data, type = "c", ivn = cytometryContinuous$ivn)
#'
"cytometryContinuous"
