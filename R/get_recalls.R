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

  path <- "recalls/recallsByVehicle"
  query <- list(
    make = make,
    model = model,
    modelYear = year
  )

  data <- make_request(path = path, query = query)
  tibble::as_tibble(data)
}

#' Get recalls by campaign number
#' @param campaign_number Campaign number
#' @return A tibble of recalls
#' @export
get_recalls_by_campaign_number <- function(campaign_number) {

  path <- "recalls/campaignNumber"
  query <- list(
    campaignNumber = campaign_number
  )

  data <- make_request(path = path, query = query)
  tibble::as_tibble(data)
}
