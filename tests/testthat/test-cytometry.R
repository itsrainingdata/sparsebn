context("datasets")

### continuous
test_that("Continuous cytometry data runs OK", {
    expect_error(data(cytometryContinuous), NA)
    expect_error(dat <- sparsebnData(cytometryContinuous$data, type = "c"), NA)
    expect_error(out <- estimate.dag(dat), NA)
    expect_error(estimate.parameters(out, dat), NA)
    expect_error(select.parameter(out, dat), NA)
})

## discrete
test_that("Discrete cytometry data runs OK", {
    expect_error(data(cytometryDiscrete), NA)
    expect_error(dat <- sparsebnData(cytometryDiscrete$data, type = "c"), NA)
    expect_error(out <- estimate.dag(dat), NA)
    expect_error(estimate.parameters(out, dat), NA)
    expect_error(select.parameter(out, dat), NA)
})

### pathfinder
test_that("Pathfinder data runs OK", {
    expect_error(data(pathfinder), NA)
    expect_error(dat <- sparsebnData(pathfinder$data, type = "c"), NA)
    expect_error(out <- estimate.dag(dat), NA)
    expect_error(estimate.parameters(out, dat), NA)
    expect_error(select.parameter(out, dat), NA)
})
