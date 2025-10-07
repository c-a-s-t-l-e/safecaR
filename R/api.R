# R/api.R

#' Perform an HTTP GET request to the NHTSA Safety Ratings API
#'
#' @param endpoint API endpoint path (string), e.g., "modelyear/2013/make/Acura/model/RDX"
#' @return Parsed JSON response as a list
make_request <- function(path, query = list()) {
  base_url <- "https://api.nhtsa.gov/"

  # Build request safely
  req <- httr2::request(base_url) |>
    httr2::req_url_path_append(path) |>
    httr2::req_url_query(!!!query) |>
    # prevent automatic stop on HTTP errors
    httr2::req_error(is_error = function(resp) FALSE)

  resp <- httr2::req_perform(req)

  # Gracefully handle failed responses (like 500s)
  status <- httr2::resp_status(resp)
  if (status >= 400) {
    warning("API request failed with status ", status)
    return(tibble::tibble())
  }

  raw <- httr2::resp_body_string(resp)

  parse_response(raw)
}

#' Parse raw JSON response from NHTSA API into a tidy list/tibble
#'
#' @param response Raw JSON string
#' @return Parsed response as a list or tibble
parse_response <- function(response) {
  # Convert JSON to R object
  parsed <- jsonlite::fromJSON(response, flatten = TRUE)

  # Extract Results (case-insensitive) and convert to tibble
  results_name <- names(parsed)[tolower(names(parsed)) == "results"]

  if (length(results_name) == 0) {
    stop("No 'Results' element found in API response")
  }

  data <- tibble::as_tibble(parsed[[results_name]])

  # Clean column names using janitor
  data <- janitor::clean_names(data, case = "lower_camel")

  return(data)
}
