# R/get_complaints.R

#' Get complaints by year/make/model
#' @param year Numeric model year
#' @param make Vehicle make
#' @param model Vehicle model
#' @return A tibble of complaints
#' @export
get_complaints <- function(year, make, model) {
  # Check for NULL inputs to prevent URLencode error
  if (is.null(year) || is.null(make) || is.null(model)) {
    stop("Arguments 'year', 'make', and 'model' must not be NULL")
  }

  make_encoded <- URLencode(make, reserved = TRUE)
  model_encoded <- URLencode(model, reserved = TRUE)
  year_as_character <- as.character(year)

  path <- "complaints/complaintsByVehicle"
  query <- list(
    make = make_encoded,
    model = model_encoded,
    modelYear = year_as_character
  )

  data <- make_request(path = path, query = query)

  # unnest the products dataset that's within the returned dataset
  if (nrow(data) > 0){
    data <- data |> tidyr::unnest(products, names_sep = "_")
  }

  data
}

#' Get complaints by ODI number
#' @param odi_number ODI number
#' @return A tibble of complaints
#' @export
get_complaints_by_odi_number <- function(odi_number) {
  odi_number_as_character <- as.character(odi_number)

  path <- "complaints/odinumber"
  query <- list(
    odinumber = odi_number_as_character
  )

  data <- make_request(path = path, query = query)

  # unnest the products dataset that's within the returned dataset
  if (nrow(data) > 0){
    data <- data |> tidyr::unnest(products, names_sep = "_")
  }

  data
}
