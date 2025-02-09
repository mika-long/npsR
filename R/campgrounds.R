#' Retrieve data about National Park Service campgrounds
#' @param park_code park codes
#' @param state_code state codes
#' @param limit Number of results to return per request. Default is 50.
#' @return a tibble of articles
#' @export
get_campgrounds <- function(park_code = NULL, state_code = NULL, limit=50){
  query <- list()
  if(!is.null(park_code)) query$parkCode <- park_code
  if(!is.null(state_code)) query$stateCode <- state_code
  if(!is.null(limit)) query$limit <- limit

  response <- nps_get("campgrounds", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("No data found.")
    return(dplyr::tibble())
  }

  campgrounds <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    url = purrr::map_chr(response$data, "url"),
    name = purrr::map_chr(response$data, "name"),
    parkCode = purrr::map_chr(response$data, "parkCode"),
    description = purrr::map_chr(response$data, "description"),
    latitude = purrr::map_chr(response$data, "latitude"),
    longitude = purrr::map_chr(response$data, "longitude"),
    directionsOverview = purrr::map_chr(response$data, "directionsOverview"),
    weatherOverview = purrr::map_chr(response$data, "weatherOverview")
    # campsites
    # accessibility
    # operatingHours
    # amenities
    # contacts
    # fees
    )
  return(campgrounds)
}
