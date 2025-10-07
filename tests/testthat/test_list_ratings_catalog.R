library(testthat)
library(safecaR)

test_that("list_rating_years() returns a non-empty tibble", {
  years <- list_rating_years()
  expect_s3_class(years, "tbl_df")       # tibble class
  expect_true(nrow(years) > 0)          # not empty
  expect_true("modelYear" %in% names(years))
})

test_that("list_rating_makes() returns expected columns", {
  makes <- list_rating_makes(2022)
  expect_s3_class(makes, "tbl_df")
  expect_true(all(c("modelYear", "make") %in% names(makes)))
  expect_true(nrow(makes) > 0)
})

test_that("list_rating_models() handles invalid make gracefully", {
  models <- list_rating_models(2022, "INVALIDMAKE")
  expect_s3_class(models, "tbl_df")
  expect_equal(nrow(models), 0)
})
