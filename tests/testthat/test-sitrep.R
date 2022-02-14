test_that("test sitrep works", {
  Sys.setenv("TEST_ENV_VAR"="set")
  expect_true(sitrep(silent = TRUE, path = "./test-conf.envstat"))
  Sys.unsetenv("TEST_ENV_VAR")
})
