context("estimate.dag")

dat_cts <- generate_continuous_sparsebnData()
dat_disc <- generate_discrete_sparsebnData()

### Helper functions for unit tests
check_edgelist_integer <- function(out){
    sapply(out, function(x) all(sapply(x$edges, function(e) is.integer(e))))
}

check_edgelist_names <- function(out){
    sapply(out, function(x) !is.null(names(x$edges)))
}

edgelist_names_equal <- function(out, compare){
    sapply(out, function(x) isTRUE(all.equal(names(x$edges), compare)))
}

test_that("", {
    ### More tests added here
})

test_that("DAG estimation runs without errors", {
    ### Test main algorithms
    expect_error(estimate.dag(dat_cts), NA)  # continuous data
    expect_error(estimate.dag(dat_disc), NA) # discrete data
    expect_error(estimate.dag(dat_disc, adaptive = TRUE), NA) # adaptive algorithm

    ### White and black lists
    expect_error(estimate.dag(dat_cts, whitelist = rbind(c(1,2))), NA) # non-NULL whitelist
    expect_error(estimate.dag(dat_cts, blacklist = rbind(c(1,2))), NA) # non-NULL blacklist
    expect_error(estimate.dag(dat_cts, whitelist = rbind(c(1,2)), blacklist = rbind(c(2,3))), NA) # non-NULL black- AND whitelist
    expect_error(estimate.dag(dat_disc, whitelist = rbind(c(1,2))), NA) # non-NULL whitelist
    expect_error(estimate.dag(dat_disc, blacklist = rbind(c(1,2))), NA) # non-NULL blacklist
    expect_error(estimate.dag(dat_disc, whitelist = rbind(c(1,2)), blacklist = rbind(c(2,3))), NA) # non-NULL black- AND whitelist
})

test_that("estimate.dag returns expected output: Continuous input", {
    ### Continuous data
    out <- estimate.dag(dat_cts)
    expect_is(out, "sparsebnPath")
    expect_true(check_list_class(as.list(out), "sparsebnFit"))
    expect_true(check_list_class(lapply(out, function(x) x$edges), "edgeList"))
    expect_true(is.zero(out[[1]]$edges)) # first estimate should always be null

    # Check that edgeLists have proper format
    expect_true(all(check_edgelist_integer(out))) # contents are indices, not characters
    expect_true(all(check_edgelist_names(out))) # names is not NULL
    expect_true(all(edgelist_names_equal(out, names(dat_cts$data)))) # names is correct
})

test_that("estimate.dag returns expected output: Discrete input", {
    ### Discrete data
    out <- estimate.dag(dat_disc)
    expect_is(out, "sparsebnPath")
    expect_true(check_list_class(as.list(out), "sparsebnFit"))
    expect_true(check_list_class(lapply(out, function(x) x$edges), "edgeList"))
    expect_true(is.zero(out[[1]]$edges)) # first estimate should always be null

    # Check that edgeLists have proper format
    expect_true(all(check_edgelist_integer(out))) # contents are indices, not characters
    expect_true(all(check_edgelist_names(out))) # names is not NULL
    expect_true(all(edgelist_names_equal(out, names(dat_disc$data)))) # names is correct
})
