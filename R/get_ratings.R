# R/get_ratings.R

#' Get crash test ratings for a specific vehicle
#' @param vehicle_id NHTSA Vehicle ID
#' @return A tibble of ratings
#' @export
get_ratings <- function(vehicle_id) {
  data <- make_request(paste0("SafetyRatings/VehicleId/", vehicle_id))
  tibble::as_tibble(data)
}

#' Get ratings for all variants of a year/make/model
#' @param year Numeric model year
#' @param make Vehicle make
#' @param model Vehicle model
#' @return A tibble of ratings for all variants
#' @export
get_ratings_by_model <- function(year, make, model) {
  variants <- list_rating_model_variants(year, make, model)

  if (nrow(variants) == 0) return(tibble::tibble())

  dplyr::bind_rows(
    lapply(variants$vehicleId, get_ratings),
    .id = "variant_index"
  )
}
