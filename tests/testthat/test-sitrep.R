test_that("test sitrep works", {
  expect_true(sitrep(silent = TRUE, path = "./test-conf.envstat"))
})
