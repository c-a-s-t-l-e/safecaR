# R/ratings_catalog.R

#' List all available model years
#' @return A tibble of years
#' @export
list_rating_years <- function() {
  data <- make_request("SafetyRatings/")

  #Remove VehicleId column if data is not empty
  if (nrow(data) != 0) {
    data <- data |> dplyr::select(-vehicleId)
  }

  data
}

#' List all makes for a given year
#' @param year Numeric model year
#' @return A tibble of makes
#' @export
list_rating_makes <- function(year) {
  # Fetch data from API
  data <- make_request(paste0("SafetyRatings/modelyear/", year))

  # Remove VehicleId column if data is not empty
  if (nrow(data) != 0) {
    data <- data |> dplyr::select(-vehicleId)
  }

  data
}

#' List all models for a given year and make
#' @param year Numeric model year
#' @param make Vehicle make (string)
#' @return A tibble of models
#' @export
list_rating_models <- function(year, make) {
  # Fetch data from API
  data <- make_request(paste0("SafetyRatings/modelyear/", year, "/make/", make))

  # Remove VehicleId column if data is not empty
  if (nrow(data) != 0) {
    data <- data |> dplyr::select(-vehicleId)
  }

  data
}

#' List crash-tested variants for a given year/make/model
#' @param year Numeric model year
#' @param make Vehicle make
#' @param model Vehicle model
#' @return A tibble of vehicle variants with VehicleId
#' @export
list_rating_model_variants <- function(year, make, model) {
  data <- make_request(paste0("SafetyRatings/modelyear/", year, "/make/", make, "/model/", model))
  tibble::as_tibble(data)
}
