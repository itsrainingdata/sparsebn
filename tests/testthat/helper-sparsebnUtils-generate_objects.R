### Helper function to suppress output (form https://stat.ethz.ch/pipermail/r-help/2008-January/151471.html)
suppressFunctionOutput <- function(expr){
    this_will_die <- capture.output({expr})
}

### Return node names for use in function
helper_node_names <- function(){
    c("xyz", "abc", "123", "hij", "a1b2c3")
}

### Generate fixed data -- need 5 columns to match objects below
generate_fixed_data_frame <- function(){
    x <- runif(5)
    y <- exp(1)^(1:5)
    z <- sqrt(y)
    a <- x+1:5
    b <- log(0.5)^(1:5)
    data.frame(x, y, z, a, b)
}

generate_fixed_discrete_data_frame <- function(){
    x <- c(0,1,0,1,0)
    y <- c(1,0,1,0,1)
    z <- c(0,1,2,1,0)
    a <- c(1,1,1,0,0)
    b <- c(0,0,1,1,1)
    data.frame(x, y, z, a, b)
}

generate_continuous_sparsebnData <- function(){
    suppressMessages(sparsebnData(generate_fixed_data_frame(), type = "c"))
}

generate_discrete_sparsebnData <- function(){
    suppressMessages(sparsebnData(generate_fixed_discrete_data_frame(), type = "d"))
}

### Generate fixed data
generate_na_data_frame <- function(){
    dat <- generate_fixed_data_frame()
    dat[2,2] <- NA

    dat
}

### Generate fixed objects for empty graphs
generate_empty_edgeList <- function(){
    edgeList(list(integer(0)))
}

generate_empty_SparseBlockMatrixR <- function(){
    li <- list(rows = list(), vals = list(), blocks = list(), sigmas = c(), start = 1)
    SparseBlockMatrixR(li)
}

generate_empty_sparsebnFit <- function(){
    li <- list(edges = generate_empty_edgeList(), nodes = "test", lambda = 1, nedge = 0, pp = 1, nn = 10, time = 1)
    sparsebnFit(li)
}

generate_empty_sparsebnPath <- function(){
    sbf <- generate_empty_sparsebnFit()
    sparsebnPath(list(sbf, sbf, sbf, sbf))
}

generate_empty_adjacency_matrix <- function(){
    m <- matrix(0, nrow = 1, ncol = 1)
    m
    # Matrix::Matrix(m)
}

### Generate fixed objects for the following toy DAG
#
# 0 . . . .
# 1 0 . . .
# 0 0 0 . .
# 5 4 0 . .
# 0 3 0 0 .
#
generate_fixed_edgeList <- function(){
    nnode <- 5
    li <- vector("list", length = nnode)
    li[[1]] <- c(2L,4L)
    li[[2]] <- c(4L,5L)
    li[[3]] <- integer(0)
    li[[4]] <- integer(0)
    li[[5]] <- integer(0)
    edgeL <- edgeList(li)

    edgeL
}

generate_fixed_graphNEL <- function(){
    ### This function requires the 'graph' package to be installed
    if (!requireNamespace("graph", quietly = TRUE)) {
        stop("graph package (from BioConductor) required!", call. = FALSE)
    }


    V <- helper_node_names()
    edL <- vector("list", length=5)
    names(edL) <- V
    edL[[1]] <- list(edges=c(), weights=runif(1))     # Edge list is
    edL[[2]] <- list(edges=c(V[1]), weights=runif(1))    # to-from, not
    edL[[3]] <- list(edges=c(), weights=runif(1))    # from-to!
    edL[[4]] <- list(edges=c(V[1], V[2]), weights=runif(2))  #
    edL[[5]] <- list(edges=c(V[2]), weights=runif(1))    #

    graph::graphNEL(nodes=V, edgeL=edL, edgemode="directed")
}

generate_fixed_SparseBlockMatrixR <- function(){
    nnode <- 5
    li <- list(rows = vector("list", length = nnode),
               vals = vector("list", length = nnode),
               blocks = vector("list", length = nnode),
               sigmas = numeric(nnode),
               start = 1)

    ### Parents / rows
    li$rows[[1]] <- c(2L,4L)
    li$rows[[2]] <- c(4L,5L)
    li$rows[[3]] <- integer(0)
    li$rows[[4]] <- integer(0)
    li$rows[[5]] <- integer(0)

    ### Values
    li$vals[[1]] <- c(1,5)
    li$vals[[2]] <- c(4,3)
    li$vals[[3]] <- integer(0)
    li$vals[[4]] <- integer(0)
    li$vals[[5]] <- integer(0)

    ### Blocks -- LEAVE EMPTY

    ### Sigmas
    li$sigmas <- rep(1,5)

    SparseBlockMatrixR(li)
}

generate_fixed_sparsebnFit <- function(edges = generate_fixed_edgeList()){
    # sbm <- generate_fixed_SparseBlockMatrixR()
    # edges <- generate_fixed_edgeList()
    # sbf <- sparsebnFit(list(edges = edges, nodes = LETTERS[1:num.nodes(edges)], lambda = 1.54, nedge = num.edges(edges), pp = num.nodes(edges), nn = 10, time = 1))
    sbf <- sparsebnFit(list(edges = edges,
                            nodes = helper_node_names()[1:num.nodes(edges)],
                            lambda = 1.54,
                            nedge = num.edges(edges),
                            pp = num.nodes(edges),
                            nn = 10,
                            time = 1))

    sbf
}

generate_fixed_sparsebnPath <- function(sbf = generate_fixed_sparsebnFit()){
    # sbf <- generate_fixed_sparsebnFit()
    sbp <- sparsebnPath(list(sbf, sbf, sbf, sbf))

    sbp
}

generate_fixed_adjacency_matrix <- function(){
    ### CCDr output is unweighted adjacency matrix by default
    m <- rbind(c(0, 0, 0, 0, 0),
               c(1, 0, 0, 0, 0),
               c(0, 0, 0, 0, 0),
               c(1, 1, 0, 0, 0),
               c(0, 1, 0, 0, 0))
    m
    # Matrix::Matrix(m)
}

generate_nontrivial_sparsebnPath <- function(){
    sbf1 <- sbf2 <- sbf3 <- sbf4 <- generate_fixed_sparsebnFit()
    sbf1$edges[[1]] <- sbf1$edges[[2]] <- integer(0)
    sbf1$lambda <- 2.1
    sbf1$nedge <- 0

    sbf3$edges[[3]] <- c(4)
    sbf3$lambda <- 0.97
    sbf3$nedge <- sbf3$nedge + 1

    sbf4$edges[[4]] <- c(1,3,5)
    sbf4$lambda <- 0.57
    sbf4$nedge <- sbf4$nedge + 3

    sbp <- sparsebnPath(list(sbf1, sbf2, sbf3, sbf4))

    sbp
}

# Return cytometry graph as test edge list
cyto_edge_list <- function(){
    edges <- list(
        "akt" = c("erk", "pip3", "pka"),
        "erk" = c("pka", "mek"),
        "jnk" = c("pkc", "pka"),
        "mek" = c("pkc", "pka", "raf"),
        "p38" = c("pkc", "pka"),
        "pip2" = c("plc", "pip3"),
        "pip3" = character(0),
        "pka" = c("pkc"),
        "pkc" = c("pip2", "plc"),
        "plc" = c("pip3"),
        "raf" = c("pkc", "pka")
    )

    edges
}
