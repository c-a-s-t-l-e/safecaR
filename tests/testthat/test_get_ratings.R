test_that("get_ratings() returns tibble with expected columns", {
  # Pick a known VehicleId from a working example
  ratings <- get_ratings(7520)
  expect_s3_class(ratings, "tbl_df")
  expect_true(all(c("overallRating", "vehicleDescription") %in% names(ratings)))
})

test_that("get_ratings_by_model() handles multiple variants", {
  ratings_all <- get_ratings_by_model(2022, "ACURA", "RDX")
  expect_s3_class(ratings_all, "tbl_df")
  expect_true("variant_index" %in% names(ratings_all))
})
