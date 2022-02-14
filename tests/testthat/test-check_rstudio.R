test_that("check env var chacking works", {
  # Skip these tests on CRAN as they make external connections to internet resources
  testthat::skip_on_cran()

  # Set up our config for an envstat test that should pass
  config <- list(
    RSPM = c("https://colorado.rstudio.com/rspm"),
    RSConnect = c("https://colorado.rstudio.com/rsc")
  )

  # run the tests
  testthat::expect_true(envstat:::check_rsc(config, silent = TRUE))
  testthat::expect_true(envstat:::check_rspm(config, silent = TRUE))
})


test_that("check env var chacking fails", {
  # Skip these tests on CRAN as they make external connections to internet resources
  testthat::skip_on_cran()

  # Set up our config for an envstat test that should fail
  config <- list(
    RSPM = c("https://rstudio.example.com/rspm"),
    RSConnect = c("https://rstudio.example.com/rsc")
  )

  # Run the tests
  testthat::expect_false(envstat:::check_rsc(config, silent = TRUE))
  testthat::expect_false(envstat:::check_rspm(config, silent = TRUE))
})
