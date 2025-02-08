# test_that("get_park_activities basic functionality", {
#   skip_if_not_installed("mockery")
#   library(mockery)
#
#   mock_response <- list(
#     data = list(
#       list(
#         id = "act1",
#         name = "Hiking",
#         parks = list(
#           list(
#             states = "CA",
#             parkCode = "yose",
#             name = "Yosemite",
#             designation = "National Park",
#             fullName = "Yosemite National Park",
#             url = "https://www.nps.gov/yose"
#           )
#         )
#       )
#     )
#   )
#
#   mock <- mock(mock_response)
#   with_mock(
#     nps_get = mock, {
#       result <- get_park_activities()
#
#       expect_s3_class(result, "tbl_df")
#       expect_equal(result$activityName[1], "Hiking")
#     }
#   )
# })
