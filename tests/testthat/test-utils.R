test_that("cli silencer", {
  testthat::expect_snapshot(envstat:::cli_silencer(FALSE, "cli_h1", "hello"))
  testthat::expect_snapshot(envstat:::cli_silencer(TRUE, "cli_h1", "hello"))
})
