# R/get_complaints.R

#' Get complaints by year/make/model
#'
#' Note: For Tesla Model Y, only 2020 returns complaints; other years return empty.
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

  path <- "complaints/complaintsByVehicle"
  query <- list(
    modelYear = year,
    make = make,
    model = model
  )

  data <- make_request(path = path, query = query)

  # unnest the products dataset that's within the returned dataset
  if (nrow(data) > 0){
    data <- data |> tidyr::unnest(products, names_sep = "_")
  }

  if (tolower(make) == "tesla" &&
      tolower(model) == "model y" &&
      year != 2020 &&
      nrow(data) == 0) {
    warning("API ERROR: All Tesla Model Y complaints for all years are returned only if you enter for the year parameter 2020. Other years return no records.")
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
