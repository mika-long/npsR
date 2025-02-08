test_that("get_parks() returns expected structure", {
  testthat::skip_if(nchar(Sys.getenv("NPS_API_KEY")) == 0, "No API key")
  parks <- get_parks(limit = 1)
  expect_true(tibble::is_tibble(parks))
  expect_gt(nrow(parks), 0)
})

