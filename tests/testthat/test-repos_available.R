r <- getOption("repos")
r["CRAN"] <- "https://cran.r-project.org"
r["RSPM"] <- "https://packagemanager.rstudio.com/cran/latest"
options(repos=r)

test_that("check repo checking works", {
  # Tell envstat to not check if repos are available
  config <- list(repos_available = FALSE)
  # Run the tests
  testthat::expect_true(envstat:::check_repos_available(config, silent = TRUE))
})
