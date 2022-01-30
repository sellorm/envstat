test_that("check reading config works", {
  config <- envstat:::read_config("conf_pass.envstat")
  testthat::expect_type(config, "list")
})
