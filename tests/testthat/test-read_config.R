test_that("check reading config works", {
  # Check is the config file is available in the expected directory
  testthat::skip_if_not(
    condition = file.exists("./test-conf.envstat"),
    message = "Config file not found"
  )

  # read the config file
  config <- envstat:::read_config("test-conf.envstat")

  # Run the tests
  testthat::expect_type(config, "list")
})
