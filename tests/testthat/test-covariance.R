context("estimate.covariance")

dat_cts <- generate_continuous_sparsebnData()
dat_disc <- generate_discrete_sparsebnData()

test_that("Covariance estimation correctly recovers the identity", {
    MAX_ERR <- 0.5 # a sufficiently large value that this should never fail

    ### Set up parameters
    pp <- 5
    nn <- 1000
    mvmean <- rep(0, pp)
    mvcov <- diag(rep(1, pp))

    ### Generate data
    set.seed(1)
    dat <- matrix(rnorm(nn*pp), nrow = nn)
    dat <- sparsebnData(dat, type = "c")

    ### Run algorithm
    out <- estimate.covariance(dat)
    expect_true(sqrt(sum(out[[1]] - mvcov)^2) < MAX_ERR)
})

test_that("Covariance estimation runs without errors", {
    expect_error(estimate.covariance(dat_cts), NA) # continuous data
    expect_error(estimate.covariance(dat_disc), "Covariance estimation for discrete models") # discrete data: not implemented yet
})

test_that("estimate.covariance returns expected output", {
    out <- estimate.covariance(dat_cts)
    expect_true(check_list_class(out, "Matrix"))
    expect_true(class(out[[1]]) == "ddiMatrix") # first component should always be diagonal
})
