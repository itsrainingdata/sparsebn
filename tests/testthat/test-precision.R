context("estimate.precision")

dat_cts <- generate_continuous_sparsebnData()
dat_disc <- generate_discrete_sparsebnData()

test_that("Precision estimation correctly recovers scalar matrix", {
    MAX_ERR <- 0.5 # a sufficiently large value that this should never fail

    ### Set up parameters
    pp <- 5
    nn <- 1000
    mvmean <- rep(0, pp)
    mvcov <- diag(rep(5, pp))

    ### Generate data
    set.seed(1)
    dat <- sqrt(5) * matrix(rnorm(nn*pp), nrow = nn)
    dat <- sparsebnData(dat, type = "c")

    ### Run algorithm
    out <- estimate.precision(dat)
    expect_true(sqrt(sum(out[[1]] - solve(mvcov))^2) < MAX_ERR)
})

test_that("Precision estimation runs without errors", {
    expect_error(estimate.precision(dat_cts), NA) # continuous data
    expect_error(estimate.precision(dat_disc), "Precision matrix estimation for discrete models") # discrete data: not implemented yet
})

test_that("estimate.precision returns expected output", {
    out <- estimate.precision(dat_cts)
    expect_true(check_list_class(out, "Matrix"))
    expect_true(class(out[[1]]) == "ddiMatrix") # first component should always be diagonal
})
