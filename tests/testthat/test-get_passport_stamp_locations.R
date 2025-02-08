# test_that("get_passport_stamp_locations basic functionality", {
#   skip_if_not_installed("mockery")
#   library(mockery)
#
#   mock_response <- list(
#     data = list(
#       list(
#         id = "stamp1",
#         label = "Visitor Center",
#         type = "Center",
#         parks = list(
#           list(
#             name = "Yosemite",
#             designation = "National Park",
#             fullName = "Yosemite National Park",
#             states = "CA",
#             parkCode = "yose",
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
#       result <- get_passport_stamp_locations()
#
#       expect_s3_class(result, "tbl_df")
#       expect_equal(result$label[1], "Visitor Center")
#     }
#   )
# })
