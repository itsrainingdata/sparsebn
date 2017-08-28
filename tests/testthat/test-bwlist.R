context("black/white lists")

dat_cts <- generate_continuous_sparsebnData()
dat_disc <- generate_discrete_sparsebnData()

### Get all blocks at once
nodes <- names(dat_cts$data) # same names for continuous / discrete
blocks <- lapply(nodes, function(x){
    # Allow all off-diagonal entries since we are no longer using the block decomposition
    row <- (nodes)[nodes != x]
    col <- rep(x, length(col))
    cbind(row, col)
})
blocks <- do.call("rbind", blocks)

pp <- ncol(dat_cts$data)
node_names <- names(dat_cts$data)
len_saturate <- pp*(pp-1)/2
nlambda <- 20

test_that("White lists work OK", {
    dags <- estimate.dag(dat_cts, lambdas.length = nlambda, whitelist = blocks)
    expect_equal(num.edges(dags), rep(len_saturate, nlambda))

    dags <- estimate.dag(dat_disc, lambdas.length = nlambda, whitelist = blocks)
    expect_equal(num.edges(dags), rep(len_saturate, nlambda))

    # One edge
    from <- "x"
    to <- "y"
    from.idx <- match(from, node_names)
    to.idx <- match(to, node_names)
    white <- rbind(c(from, to))

    dags <- estimate.dag(dat_cts, lambdas.length = nlambda, whitelist = white)
    check_edge <- all(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_true(check_edge)

    dags <- estimate.dag(dat_disc, lambdas.length = nlambda, whitelist = white)
    check_edge <- all(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_true(check_edge)

    # Two edges
    from <- "b"
    to <- "z"
    from.idx <- match(from, node_names)
    to.idx <- match(to, node_names)
    white <- rbind(c("x", "y"), c(from, to))

    dags <- estimate.dag(dat_cts, lambdas.length = nlambda, whitelist = white)
    check_edge <- all(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_true(check_edge)

    dags <- estimate.dag(dat_disc, lambdas.length = nlambda, whitelist = white)
    check_edge <- all(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_true(check_edge)
})

test_that("Black lists work OK", {
    dags <- ccdr.run(dat_cts, lambdas.length = nlambda, blacklist = blocks)
    expect_equal(num.edges(dags), rep(0, nlambda))

    dags <- ccdr.run(dat_disc, lambdas.length = nlambda, blacklist = blocks)
    expect_equal(num.edges(dags), rep(0, nlambda))

    # One edge
    from <- "x"
    to <- "y"
    from.idx <- match(from, node_names)
    to.idx <- match(to, node_names)
    black <- rbind(c(from, to))

    dags <- estimate.dag(dat_cts, lambdas.length = nlambda, blacklist = black)
    check_edge <- any(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_false(check_edge)

    dags <- estimate.dag(dat_disc, lambdas.length = nlambda, blacklist = black)
    check_edge <- any(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_false(check_edge)

    # Two edges
    from <- "b"
    to <- "z"
    from.idx <- match(from, node_names)
    to.idx <- match(to, node_names)
    black <- rbind(c("x", "y"), c(from, to))

    dags <- estimate.dag(dat_cts, lambdas.length = nlambda, blacklist = black)
    check_edge <- any(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_false(check_edge)

    dags <- estimate.dag(dat_disc, lambdas.length = nlambda, blacklist = black)
    check_edge <- any(unlist(lapply(dags, function(x) from.idx %in% as.list(x$edges)[[to]])))
    expect_false(check_edge)
})
