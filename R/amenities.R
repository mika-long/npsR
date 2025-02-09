#' Retrieve the amenity types
#' @param limit Maximum number of results (Default:50)
#' @return a dataframe of all amenities
#' @export
get_amenities <- function(limit=50){
  query <- list()
  if (!is.null(limit)) query$limit = limit

  response <- nps_get("amenities", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("Found nothing")
    return(dplyr::tibble())
  }

  amenities <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    name = purrr::map_chr(response$data, "name"),
    categories = purrr::map(response$data, function(x){
      dplyr::tibble(categories = unlist(x$categories))
    })
  )

  return(amenities)
}

#' Retrieve "places" within national parks that have different amenities
#' @param park_code National park codes (e.g., 'ACAD')
#' @param limit Maximum number of results (Default: 50)
#' @return Return a tibble that has the places within national parks that have different amenities
#' @export
get_amenities_by_parksplace <- function(park_code = NULL, limit=50){
  query <- list()
  if (!is.null(park_code)) query$parkCode = park_code
  if (!is.null(limit)) query$limit = limit

  response <- nps_get("amenities/parksplaces", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("Found nothing")
    return(dplyr::tibble())
  }

  amenities <- dplyr::tibble(
    id = purrr::map_chr(unlist(response$data, recursive=F), "id"),
    name = purrr::map_chr(unlist(response$data, recursive=F), "name"),
    parks = purrr::map(unlist(response$data, recursive=F), function(x){
      p = x$parks
      t = dplyr::tibble(states = purrr::map_chr(p, "states"),
                 designation = purrr::map_chr(p, "designation"),
                 parkCode = purrr::map_chr(p, "parkCode"),
                 fullName = purrr::map_chr(p, "fullName"),
                 url = purrr::map_chr(p, "url"),
                 name = purrr::map_chr(p, "name")
                 #places # this is another nested object ... skipping this for now
                 )
      return(t)
    })
  )

  return(amenities)
}
