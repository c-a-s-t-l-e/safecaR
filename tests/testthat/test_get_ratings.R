test_that("get_ratings() returns tibble with expected columns", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("get_ratings_vehicleid_7520", {
    ratings <- get_ratings(7520)
  })

  expect_s3_class(ratings, "tbl_df")
  expect_true(all(c("overallRating", "vehicleDescription") %in% names(ratings)))
})


test_that("get_ratings_by_model() handles multiple variants", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("get_ratings_by_model_acura_2022_rdx", {
    ratings_all <- get_ratings_by_model(2022, "ACURA", "RDX")
  })

  expect_s3_class(ratings_all, "tbl_df")
  expect_true("variant_index" %in% names(ratings_all))
})

