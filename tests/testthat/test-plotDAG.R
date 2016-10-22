context("plotDAG")

el <- generate_fixed_edgeList()
sbp <- generate_fixed_sparsebnPath()
sbf <- generate_fixed_sparsebnFit()
cyto <- sparsebnUtils::edgeList(cyto_edge_list())

test_that("plotDAG runs without errors", {
    expect_error(plotDAG(el), NA)
    expect_error(plotDAG(sbf), NA)
    expect_error(plotDAG(sbp), NA)
    expect_error(plotDAG(cyto), NA)
})
