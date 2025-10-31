test_that("get_complaints() returns tibble with expected columns", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("get_complaints_acura_2012", {
    complaints <- get_complaints(2012, "ACURA", "RDX")
  })

  expect_s3_class(complaints, "tbl_df")
  expect_true(all(c("odiNumber", "products_type") %in% names(complaints)))
})


test_that("get_complaints_by_odi_number() returns tibble with expected columns", {
  skip_on_cran()
  skip_if_offline()

  vcr::use_cassette("get_complaints_by_odi_number_11132058", {
    complaints <- get_complaints_by_odi_number(11132058)
  })

  expect_s3_class(complaints, "tbl_df")
  expect_true(all(c("odiNumber", "products_type") %in% names(complaints)))
})

