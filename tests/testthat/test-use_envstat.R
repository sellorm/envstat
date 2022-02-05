test_that("check use_envstat works", {
  temp_file <- tempfile(tmpdir = "/tmp")
  testthat::expect_true(
    envstat::use_envstat(filepath = temp_file, NULL))
                         # source = "../../inst/example.envstat"))
  config <- envstat:::read_config(temp_file)
  testthat::expect_type(config, "list")
  file.remove(temp_file)
})

