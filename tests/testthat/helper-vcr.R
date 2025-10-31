vcr::vcr_configure(
  dir = test_path("fixtures/vcr_cassettes"),
  record = "once"
)

# Turn vcr on locally, off on CRAN
if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  vcr::turn_on()
} else {
  vcr::turn_off()
}
