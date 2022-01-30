test_that("check RStudio chacking works", {
  config <- envstat:::read_config("conf_pass.envstat")
  Sys.setenv("CONNECT_API_KEY"="hatstand")
  testthat::expect_true(envstat:::check_rspm(config, silent = TRUE)[1])
  testthat::expect_true(envstat:::check_rsc(config, silent = TRUE)[1])
})

test_that("check RStudio chacking fails", {
  config <- envstat:::read_config("conf_fail.envstat")
  testthat::expect_false(envstat:::check_rspm(config, silent = TRUE)[1])
  testthat::expect_false(envstat:::check_rsc(config, silent = TRUE)[1])
})
