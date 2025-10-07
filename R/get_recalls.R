# R/get_recalls.R

#' Get recalls by year/make/model
#' @param year Numeric model year
#' @param make Vehicle make
#' @param model Vehicle model
#' @return A tibble of recalls
#' @export
get_recalls <- function(year, make, model) {
  # Check for NULL inputs to prevent URLencode error
  if (is.null(year) || is.null(make) || is.null(model)) {
    stop("Arguments 'year', 'make', and 'model' must not be NULL")
  }

  make_encoded <- URLencode(make, reserved = TRUE)
  model_encoded <- URLencode(model, reserved = TRUE)
  year_as_character <- as.character(year)

  path <- "recalls/recallsByVehicle"
  query <- list(
    make = make_encoded,
    model = model_encoded,
    modelYear = year_as_character
  )

  data <- make_request(path = path, query = query)
  tibble::as_tibble(data)
}

#' Get recalls by campaign number
#' @param year Numeric model year
#' @param campaign_number Campaign number
#' @return A tibble of recalls
#' @export
get_recalls_by_campaign_number <- function(campaign_number) {
  campaign_number_encoded <- URLencode(campaign_number, reserved = TRUE)

  path <- "recalls/campaignNumber"
  query <- list(
    campaignNumber = campaign_number_encoded
  )

  data <- make_request(path = path, query = query)
  tibble::as_tibble(data)
}
