# R/api.R

#' Perform an HTTP GET request to the NHTSA Safety Ratings API
#'
#' This function sends a GET request to the NHTSA public API and returns
#' the parsed response as a tibble. If the request fails (e.g., due to
#' no internet connection or an invalid path), it returns an empty tibble
#' and issues a warning.
#'
#' @param path A character string specifying the endpoint path (e.g.,
#'   "modelyear/2013/make/Acura/model/RDX")
#' @param query Optional list of query parameters to include in the request
#'
#' @return A tibble with the API response data, or an empty tibble on error
#' @note This function requires an internet connection and may return
#'   an empty result if the API is unavailable.
#' @examples
#' \dontrun{
#' make_request("SafetyRatings/modelyear/2013/make/Acura/model/RDX")
#' }
#' @export
make_request <- function(path, query = list()) {
  base_url <- "https://api.nhtsa.gov/"

  tryCatch({
    req <- httr2::request(base_url) |>
      httr2::req_url_path_append(path) |>
      httr2::req_url_query(!!!query) |>
      httr2::req_error(is_error = function(resp) FALSE)

    resp <- httr2::req_perform(req)

    status <- httr2::resp_status(resp)
    if (status >= 400) {
      stop("API request failed with status ", status)
      return(tibble::tibble())
    }

    raw <- httr2::resp_body_string(resp)
    parse_response(raw)
  }, error = function(e) {
    warning("API request error: ", conditionMessage(e))
    tibble::tibble()
  })
}

#' Parse raw JSON response from the NHTSA API
#'
#' Parses a raw JSON string returned from the NHTSA API. Extracts the 'Results'
#' element (case-insensitive) and returns it as a cleaned tibble.
#'
#' @param response Raw JSON string from the API
#' @return A tibble with parsed and cleaned data
#' @keywords internal
parse_response <- function(response) {
  parsed <- jsonlite::fromJSON(response, flatten = TRUE)

  results_name <- names(parsed)[tolower(names(parsed)) == "results"]

  if (length(results_name) == 0) {
    stop("No 'Results' element found in API response")
  }

  data <- tibble::as_tibble(parsed[[results_name]])
  janitor::clean_names(data, case = "lower_camel")
}
