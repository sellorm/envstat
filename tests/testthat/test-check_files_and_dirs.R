test_that("files and dirs pass", {
  if (!dir.exists("/tmp")){
    dir.create("/tmp")
  }
  if (!file.exists("/tmp/delete_me")){
    file.create("/tmp/delete_me")
  }
  config <- envstat:::read_config("conf_pass.envstat")
  testthat::expect_true(envstat:::check_files(config, silent = TRUE)[1])
  testthat::expect_true(envstat:::check_dirs(config, silent = TRUE)[1])
})


test_that("files and dirs fail", {
  config <- envstat:::read_config("conf_fail.envstat")
  testthat::expect_false(envstat:::check_files(config, silent = TRUE)[1])
  testthat::expect_false(envstat:::check_dirs(config, silent = TRUE)[1])
})
