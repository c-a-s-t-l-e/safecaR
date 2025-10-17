# R/list_complaints_catalog.R

#' List all available complaint years
#' @return A tibble of years
#' @export
list_complaint_years <- function() {
  path <- "products/vehicle/modelYears"
  query <- list(
    issueType = utils::URLencode("c", reserved = TRUE)
  )

  data <- make_request(path = path, query = query)

  data
}

#' List all available complaint makes
#' @param year Numeric model year
#' @return A tibble of makes
#' @export
list_complaint_makes <- function(year) {

  year_as_character <- as.character(year)

  path <- "products/vehicle/makes"
  query <- list(
    modelYear = year,
    issueType = utils::URLencode("c", reserved = TRUE)
  )

  data <- make_request(path, query)

  data
}

#' List all available complaint models
#' @param year Numeric model year
#' @param make Vehicle make
#' @return A tibble of models
#' @export
list_complaint_models <- function(year, make) {

  make_encoded <- utils::URLencode(make, reserved = TRUE)
  year_as_character <- as.character(year)

  path <- "products/vehicle/models"
  query <- list(
    modelYear = year,
    make = make_encoded,
    issueType = utils::URLencode("c", reserved = TRUE)
  )

  data <- make_request(path, query)

  data
}
