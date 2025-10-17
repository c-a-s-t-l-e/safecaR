# R/list_recalls_catalog.R

#' List all available recall years
#' @return A tibble of years
#' @export
list_recall_years <- function() {
  path <- "products/vehicle/modelYears"
  query <- list(
    issueType = utils::URLencode("r", reserved = TRUE)
  )

  data <- make_request(path, query)

  data
}

#' List all available recall makes
#' @param year Numeric model year
#' @return A tibble of years
#' @export
list_recall_makes <- function(year) {

  year_as_character <- as.character(year)

  path <- "products/vehicle/makes"
  query <- list(
    modelYear = year,
    issueType = utils::URLencode("r", reserved = TRUE)
  )

  data <- make_request(path, query)

  data
}

#' List all available recall models
#' @param year Numeric model year
#' @param make Vehicle make
#' @return A tibble of years
#' @export
list_recall_models <- function(year, make) {

  make_encoded <- utils::URLencode(make, reserved = TRUE)
  year_as_character <- as.character(year)

  path <- "products/vehicle/models"
  query <- list(
    modelYear = year,
    make = make_encoded,
    issueType = URLencode("r", reserved = TRUE)
  )

  data <- make_request(path, query)

  data
}
