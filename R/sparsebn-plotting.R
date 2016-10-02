#
#  sparsebn-plotting.R
#  sparsebn
#
#  Created by Bryon Aragam (local) on 10/2/16.
#  Copyright (c) 2016 Bryon Aragam. All rights reserved.
#

#
# PACKAGE SPARSEBN: Default methods for plotting DAGs
#
#   CONTENTS:
#       plotDAG
#       plotDAG.sparsebnFit
#       plotDAG.sparsebnPath
#

#' @export
plotDAG <- function(x){
    ### Must use igraph for the default method
    current_plot_pkg <- getPlotPackage()
    if(current_plot_pkg != "igraph"){
        err_msg <- sprintf("This method requires that the 'igraph' package be set as your plotting package. You are currently set to use the '%s' package instead. Please set this packge to be 'igraph', or use the default plot() method from the %s package instead. See ?setPlotPackage for more details.", current_plot_pkg, current_plot_pkg)
        stop(err_msg)
    }

    UseMethod("plotDAG", x)
}

#' @export
plotDAG.edgeList <- function(x, ...){

    #
    # Note that the defaults used here are not the same as for sparsebnPath!
    #
    plot(x,
         vertex.size = 4,
         vertex.label = NA,
         vertex.label.color = gray(0),
         vertex.color = rgb(1,0,0),
         edge.width = 1,
         edge.color = gray(0),
         edge.arrow.size = 0.5,
         ...)
}

#' @export
plotDAG.sparsebnFit <- function(x, ...){
    plotDAG(x$edges, ...)
}

#' @export
plotDAG.sparsebnPath <- function(x, ...){

    #
    # This method does not delegate directly to sparsebnFit because
    #  plotting a grid of graphs requires a different visual layout.
    #

    plot(x,
         vertex.size = 4,
         vertex.label = NA,
         vertex.label.color = gray(0),
         vertex.color = rgb(1,0,0),
         edge.width = 0.5,
         edge.color = gray(0),
         edge.arrow.size = 0.15,
         ...)
}
