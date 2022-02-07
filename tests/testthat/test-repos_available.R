test_that("check repo checking works", {
  config <- envstat:::read_config("conf_pass.envstat")
  testthat::expect_true(envstat:::check_repos_available(config, silent = TRUE))
})

test_that("check repo checking fails", {
  config <- envstat:::read_config("conf_fail.envstat")
  testthat::expect_true(envstat:::check_repos_available(config, silent = TRUE))
})
