#' Retrieve National Park Service park data
#' @param state_code Filter parks by state (e.g., 'CA')
#' @param park_code Filter parks by park code (e.g., 'ACAD')
#' @param limit Maximum number of results (default: 50)
#' @return A tibble of park data
#' @export
get_parks <- function(park_code = NULL, state_code = NULL, limit=50) {
  query <- list()
  if(!is.null(park_code)) query$parkCode <- park_code
  if(!is.null(state_code)) query$stateCode <- state_code
  if(!is.null(limit)) query$limit <- limit

  response <- nps_get("parks", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("No alerts found for the specified park codes.")
    return(dplyr::tibble())
  }

  # convert nested lists to a tibble
  parks <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    url = purrr::map_chr(response$data, "url"),
    name = purrr::map_chr(response$data, "fullName"),
    state = purrr::map_chr(response$data, ~paste(.x$states, collapse = ", ")),
    description = purrr::map_chr(response$data, "description"),
    weatherInfo = purrr::map_chr(response$data, "weatherInfo"),
    latitude = as.numeric(purrr::map_chr(response$data, "latitude")),
    longitude = as.numeric(purrr::map_chr(response$data, "longitude"))
  )

  return(parks)
}

#' Retrieve location that have national park passport stamps
#' @param state_code Filter by state (e.g., 'CA')
#' @param park_code Filter by park_code (e.g., 'CA')
#' @param limit Maximum number of results (default: 50)
#' @return A tibble of passport location data
#' @export
get_passport_stamp_locations <- function(park_code = NULL,
                                         state_code = NULL,
                                         limit=50) {
  query <- list()
  if(!is.null(state_code)) query$stateCode <- state_code
  if(!is.null(park_code)) query$parkCode <- park_code
  if(!is.null(limit)) query$limit <- limit

  response <- nps_get("passportstamplocations", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("No alerts found for the specified park codes.")
    return(dplyr::tibble())
  }

  # convert nested lists to a tibble
  passport_locations <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    label = purrr::map_chr(response$data, "label"),
    type = purrr::map_chr(response$data, "type"),
    parks = purrr::map(response$data, function(x) {
      dplyr::tibble(
        name = x$parks[[1]]$name,
        designation = x$parks[[1]]$designation,
        fullName = x$parks[[1]]$fullName,
        states = x$parks[[1]]$states,
        parkCode = x$parks[[1]]$parkCode,
        url = x$parks[[1]]$url
      )
    })
  )
  return(passport_locations)
}

#' Retrieve national parks that are related to particular categories of activities
#' @param limit Maximum number of results (default: 50)
#' @return A tibble of activities and national parks
#' @export
get_park_activities <- function(limit=50) {
  query <- list()
  if(!is.null(limit)) query$limit <- limit

  response <- nps_get("activities/parks", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("No alerts found for the specified park codes.")
    return(dplyr::tibble())
  }


  activity <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    activityName = purrr::map_chr(response$data, "name"),
    parks = purrr::map(response$data, function(x) {
      purrr::map_df(x$parks, function(park) {
        dplyr::tibble(states = park$states,
               parkCode = park$parkCode,
               parkName = park$name,
               designation = park$designation,
               fullName = park$fullName,
               url = park$url
               )
      })
    })
  )
  return(activity)
}
