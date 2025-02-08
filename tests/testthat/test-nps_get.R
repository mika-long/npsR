# library(mockery)
#
# # Error handling tests
# test_that("functions handle API errors gracefully", {
#   mock_error <- mock(stop("API Error"))
#   with_mock(
#     nps_get = mock_error, {
#       expect_error(get_parks())
#       expect_error(get_passport_stamp_locations())
#       expect_error(get_park_activities())
#     }
#   )
# })
