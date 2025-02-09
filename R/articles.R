#' Retrieve articles created by national parks and other NPS entities
#' @param park_code park codes
#' @param state_code state codes
#' @param limit Number of results to return per request. Default is 50.
#' @return a tibble of articles
#' @export
get_articles <- function(park_code = NULL, state_code = NULL, limit=50){
  query <- list()
  if(!is.null(park_code)) query$parkCode <- park_code
  if(!is.null(state_code)) query$stateCode <- state_code
  if(!is.null(limit)) query$limit <- limit

  response <- nps_get("articles", query = query)

  # Check for empty responses
  if (length(response$data) == 0) {
    warning("No alerts found for the specified park codes.")
    return(dplyr::tibble())
  }

  articles <- dplyr::tibble(
    id = purrr::map_chr(response$data, "id"),
    url = purrr::map_chr(response$data, "url"),
    title = purrr::map_chr(response$data, "title"),
    listingDescription = purrr::map_chr(response$data, "listingDescription"),
    #tags
    #latitude, longitude,
    #geometryPoiId
  )
  return(articles)
}
