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
    li <- list(edges = generate_empty_edgeList(), lambda = 1, nedge = 0, pp = 1, nn = 10, time = 1)
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
# 0 1 0 . .
# 5 4 0 . .
# 0 3 0 0 .
#
generate_fixed_edgeList <- function(){
    nnode <- 5
    li <- vector("list", length = nnode)
    li[[1]] <- c(2L,4L)
    li[[2]] <- c(3L,4L,5L)
    li[[3]] <- integer(0)
    li[[4]] <- integer(0)
    li[[5]] <- integer(0)
    edgeL <- edgeList(li)

    edgeL
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
    li$rows[[2]] <- c(3L,4L,5L)
    li$rows[[3]] <- integer(0)
    li$rows[[4]] <- integer(0)
    li$rows[[5]] <- integer(0)

    ### Values
    li$vals[[1]] <- c(1,5)
    li$vals[[2]] <- c(1,4,3)
    li$vals[[3]] <- integer(0)
    li$vals[[4]] <- integer(0)
    li$vals[[5]] <- integer(0)

    ### Blocks -- LEAVE EMPTY

    ### Sigmas
    li$sigmas <- rep(1,5)

    SparseBlockMatrixR(li)
}

generate_fixed_sparsebnFit <- function(){
    # sbm <- generate_fixed_SparseBlockMatrixR()
    edges <- generate_fixed_edgeList()
    sbf <- sparsebnFit(list(edges = edges, lambda = 1.54, nedge = num.edges(edges), pp = num.nodes(edges), nn = 10, time = 1))

    sbf
}

generate_fixed_sparsebnPath <- function(){
    sbf <- generate_fixed_sparsebnFit()
    sbp <- sparsebnPath(list(sbf, sbf, sbf, sbf))

    sbp
}

generate_fixed_adjacency_matrix <- function(){
    ### CCDr output is unweighted adjacency matrix by default
    m <- rbind(c(0, 0, 0, 0, 0),
               c(1, 0, 0, 0, 0),
               c(0, 1, 0, 0, 0),
               c(1, 1, 0, 0, 0),
               c(0, 1, 0, 0, 0))
    m
    # Matrix::Matrix(m)
}
