test_that("list_rating_years() returns a non-empty tibble", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("list_rating_years", {
    years <- list_rating_years()
  })

  expect_s3_class(years, "tbl_df")       # tibble class
  expect_true(nrow(years) > 0)           # not empty
  expect_true("modelYear" %in% names(years))
})


test_that("list_rating_makes() returns expected columns", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("list_rating_makes_2022", {
    makes <- list_rating_makes(2022)
  })

  expect_s3_class(makes, "tbl_df")
  expect_true(all(c("modelYear", "make") %in% names(makes)))
  expect_true(nrow(makes) > 0)
})


test_that("list_rating_models() handles invalid make gracefully", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("list_rating_models_invalidmake_2022", {
    models <- list_rating_models(2022, "INVALIDMAKE")
  })

  expect_s3_class(models, "tbl_df")
  expect_equal(nrow(models), 0)
})
