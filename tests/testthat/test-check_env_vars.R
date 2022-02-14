test_that("check environment variable chacking works", {
  # Set an environment variable to test
  Sys.setenv("ENVSTAT_TEST"="hatstand")

  # Load a custom config to test the env var
  config <- list(env_vars = c("ENVSTAT_TEST"))

  # Run the tests
  testthat::expect_true(envstat:::check_env_vars(config, silent = TRUE)[1])

  # Tidy up after ourselves
  Sys.unsetenv("ENVSTAT_TEST")
})

test_that("check environment variable chacking fails", {
  # Here we check that envstat fails appropriately
  # We'll use ENVSTAT_TEST as we can be confident that is not set

  # Load a custom config to test the env var
  config <- list(env_vars = c("ENVSTAT_TEST"))

  # Run the tests
  testthat::expect_false(envstat:::check_env_vars(config, silent = TRUE)[1])
})
