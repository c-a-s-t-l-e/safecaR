test_that("get_recalls() returns tibble with expected columns", {
  # Pick a known year, make, and model from a working example
  recalls <- get_recalls(2012, "ACURA", "RDX")
  expect_s3_class(recalls, "tbl_df")
  expect_true(all(c("nhtsaCampaignNumber", "nhtsaActionNumber") %in% names(recalls)))
})
