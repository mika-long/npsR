#' Internal function to make API requests
#' @keywords internal
nps_get <- function(endpoint, query=list(), api_key=Sys.getenv("NPS_API_KEY")) {
  if(nchar(api_key) == 0) {
    stop("API key not found. Set it with `Sys.setenv(NPS_API_KEY = 'your_key')`")
  }

  req <- httr2::request("https://developer.nps.gov/api/v1") |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(api_key = api_key) |>
    httr2::req_url_query(!!!query, .multi="comma") |>
    httr2::req_user_agent("npsR R package")

  rsp <- httr2::req_perform(req)

  if(httr2::resp_is_error(rsp)){
    state <- httr2::resp_status(rsp)
    description <- httr2::resp_status_desc(rsp)
    stop(sprintf("API request failed: %s (%s)", description, state))
  }

  httr2::resp_body_json(rsp)
}


