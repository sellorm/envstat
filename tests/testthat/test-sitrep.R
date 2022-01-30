test_that("test sitrep works", {
  expect_true(sitrep(silent = TRUE, path = "./conf_pass.envstat"))
})

test_that("test sitrep fails", {
  expect_false(sitrep(silent = TRUE, path = "./conf_fail.envstat"))
})
