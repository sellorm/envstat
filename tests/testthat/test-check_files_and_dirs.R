test_that("files and dirs pass", {
  # create temporary items to use during testing
  test_dir <- file.path(tempdir(), "tests")
  dir.create(test_dir)
  test_file <- file.path(test_dir, "test_file")
  file.create(test_file)

  # Load a custom config using the temporary items
  config <- list(dir_exists = c(test_dir), file_exists = c(test_file))

  # Run the tests
  testthat::expect_true(envstat:::check_files(config, silent = TRUE)[1])
  testthat::expect_true(envstat:::check_dirs(config, silent = TRUE)[1])

  # Clean up after ourselves
  unlink(test_dir, recursive = TRUE)
})


test_that("files and dirs fail", {
  # These tests check that envstat fails appropriately
  # Create references to items that we know do now exist
  fake_test_dir <- file.path(tempdir(), "tests")
  fake_test_file <- file.path(fake_test_dir, "test_file")

  # Loac a custom config using the fake test items
  config <- list(dir_exists = c(fake_test_dir), file_exists = c(fake_test_file))

  # Run the tests
  testthat::expect_false(envstat:::check_files(config, silent = TRUE)[1])
  testthat::expect_false(envstat:::check_dirs(config, silent = TRUE)[1])
})
