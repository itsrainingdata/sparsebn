context("estimate.dag")

dat_cts <- generate_continuous_sparsebnData()
dat_disc <- generate_discrete_sparsebnData()

test_that("", {
    ### More tests added here
})

test_that("DAG estimation runs without errors", {
    expect_error(estimate.dag(dat_cts), NA)  # continuous data
    expect_error(estimate.dag(dat_disc), NA) # discrete data
})

test_that("estimate.dag returns expected output", {
    out <- estimate.dag(dat_cts)
    expect_is(out, "sparsebnPath")
    expect_true(check_list_class(as.list(out), "sparsebnFit"))
    expect_true(is.zero(out[[1]]$edges)) # first estimate should always be null
})
