test_that("check env var chacking works", {
  config <- envstat:::read_config("conf_pass.envstat")
  testthat::expect_true(envstat:::check_env_vars(config))
})

test_that("check env var chacking fails", {
  config <- envstat:::read_config("conf_fail.envstat")
  testthat::expect_false(envstat:::check_env_vars(config))
})
