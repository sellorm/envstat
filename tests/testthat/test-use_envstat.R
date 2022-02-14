test_that("check use_envstat works", {
  # write the config to a temporary file
  temp_file <- tempfile()
  testthat::expect_true(
    envstat::use_envstat(filepath = temp_file,
                         source = "./test-conf.envstat",
                         consent = TRUE))

  # Read our new config file
  config <- envstat:::read_config(temp_file)

  # Check that the type is correct
  testthat::expect_type(config, "list")

  # Clean up after ourselves
  file.remove(temp_file)
})

