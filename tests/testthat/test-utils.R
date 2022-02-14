test_that("cli silencer matches snapshot", {
  testthat::expect_snapshot(envstat:::cli_silencer(FALSE, "cli_h1", "hello"))
  testthat::expect_snapshot(envstat:::cli_silencer(TRUE, "cli_h1", "hello"))
})

test_that("User consent is properly handled", {
  # User consent not provided, but custom path used
  testthat::expect_true(envstat:::user_consent(
    provided = FALSE,
    path = "~/unused_test_path"
  ))

  # User consent explicitly provided
  testthat::expect_true(envstat:::user_consent(provided = TRUE))

  # User consent override via environment variable
  Sys.setenv("ENVSTAT"="OVERRIDE")
  testthat::expect_true(envstat:::user_consent())
  Sys.unsetenv("ENVSTAT")

  # User consent not provided and default path used
  testthat::expect_false(envstat:::user_consent(
    provided = FALSE,
    path = "~/.envstat"
  ))
})
