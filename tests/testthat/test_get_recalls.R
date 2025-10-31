test_that("get_recalls() returns tibble with expected columns", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("get_recalls_acura_2012_rdx", {
    recalls <- get_recalls(2012, "ACURA", "RDX")
  })

  expect_s3_class(recalls, "tbl_df")
  expect_true(all(c("nhtsaCampaignNumber", "nhtsaActionNumber") %in% names(recalls)))
})

