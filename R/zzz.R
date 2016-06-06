#
#  zzz.R
#  sparsebn
#
#  Created by Bryon Aragam (local) on 4/5/16.
#  Copyright (c) 2016 Bryon Aragam. All rights reserved.
#

#' @import sparsebnUtils ccdrAlgorithm discretecdAlgorithm

.onAttach <- function(libname, pkgname){
    msg <- paste0("\n",
                  "sparsebn v0.1, Copyright (c) 2016\n",
                  "\tBryon Aragam, University of California, Los Angeles\n",
                  "\tJiaying Gu, University of California, Los Angeles\n",
                  "\tQing Zhou, University of California, Los Angeles\n",
                  "\tFei Fu\n",
                  "\n",
                  "Please cite our work! Type citation(\"sparsebn\") for details.\n",
                  "---> Bugs? Please report any bugs at https://github.com/itsrainingdata/sparsebn/issues.\n"
    )
    packageStartupMessage(msg)
}

### Set global options for this packages: Shamelessly stolen from /devtools/R/zzz.R
.onLoad <- function(libname, pkgname) {
  opt <- options()
#   op.devtools <- list(
#     devtools.path = "~/R-dev",
#     devtools.install.args = "",
#     devtools.name = "Your name goes here",
#     devtools.desc.author = 'person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))',
#     devtools.desc.license = "What license is it under?",
#     devtools.desc.suggests = NULL,
#     devtools.desc = list(),
#     devtools.revdep.libpath = file.path(tempdir(), "R-lib")
#   )

  opt.sparsebn <- list(
      sparsebn.graph = NULL,       # graph package to use / NULL = no external package
      sparsebn.plotting = "igraph" # plotting mechanism to use
      # .MACHINE_EPS?
  )

  ### Only set the options which have not already been set (i.e. don't override defaults)
  toset <- !(names(opt.sparsebn) %in% names(opt)) # Which options have NOT been set already?
  if(any(toset)) options(opt.sparsebn[toset])     # Set the options which have not been set

  invisible()
}
