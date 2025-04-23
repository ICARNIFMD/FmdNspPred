test_that("FmdNspPred() returns correct output structure and values for species input", {
  test_data <- data.frame(
    Sample.ID = c("samc1", "samb2", "sams3", "samg7"),
    PP.value = c(34.6, 35.9, 27.6, 53.2)
  )

  # Test for species = "goat"
  result_goat <- FmdNspPred(input_data = test_data, Species = "goat")
  expect_s3_class(result_goat, "data.frame")

  expected_columns <- c("Samp.ID", "Expos.Probct", "Odds", "Log.Odds", "Odds.Ratio", "Risk.Status", "Pred.Class")
  expect_equal(colnames(result_goat), expected_columns)

  # Check that output dimensions match input rows
  expect_equal(nrow(result_goat), nrow(test_data))

  # Test that default species ("bovine") is used and message is displayed
  expect_message(
    result_default <- FmdNspPred(input_data = test_data),
    regexp = "No species selected or invalid input. Defaulting to 'bovine'.",
    fixed = TRUE
  )
  expect_s3_class(result_default, "data.frame")
  expect_equal(nrow(result_default), nrow(test_data))

  # Test for handling negative PP values
  test_data_neg <- data.frame(
    Sample.ID = c("neg1"),
    PP.value = c(-10)
  )
  expect_error(FmdNspPred(test_data_neg, Species = "sheep"),
               regexp = "PP.value cannot contain negative values")
})

