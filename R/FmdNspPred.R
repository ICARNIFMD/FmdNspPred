################################################################
#### Prediction of Foot and Mouth disease virus exposure of ####
####     susseptible animals using 2B NSP ELISA data        ####
################################################################
#' This function calculates the probability of exposure to Foot-and-Mouth Disease Non-Structural Proteins (FMD NSP)
#' using logistic regression coefficients that are specific to species.
#'
#'@param input_data A data frame with two columns: \code{Sample.ID} (character) and \code{PP.value} (numeric).
#' @param Species A character string indicating the species: one of \code{"bovine"}, \code{"goat"}, \code{"buffalo"}, or \code{"sheep"}.
#' Defaults to \code{"bovine"} if not provided or invalid.
#'
#' @return A data frame with the predicted exposure probability, odds, log-odds, odds ratio, risk status, and predicted class.
#'
#' @examples
#' test_data <- data.frame(Sample.ID = c("sam1", "sam2"), PP.value = c(34.5, 56.3))
#' FmdNspPred(test_data, Species = "goat")
#'
#' @export
#'
FmdNspPred <- function(input_data, Species = NULL) {
  sigmoid <- function(z) {
    return(1 / (1 + exp(-z)))
  }
  # Validate input_data
  if (!all(c("Sample.ID", "PP.value") %in% colnames(input_data))) {
    stop("Error: input_data must contain 'Sample.ID' and 'PP.value' columns.")
  }

  # Extract values
  Sample.ID <- input_data$Sample.ID
  PP.value <- input_data$PP.value

  # Check for negative PP values
  if (any(PP.value < 0)) {
    stop("Error: PP.value cannot contain negative values")
  }

  # Normalize species name
  species <- tolower(Species)

  # Set weights and bias
  if (species == "bovine" || species == "") {
    weights <- matrix(c(-1.5607, 0.0442), ncol = 1)
    bias <- -1.5607
    if (species == "") {
      message("No species selected. Using default species: bovine.")
    }
  } else if (species == "goat") {
    weights <- matrix(c(-1.662, 0.056), ncol = 1)
    bias <- -1.662
  } else if (species == "pig") {
    weights <- matrix(c(-1.8306, 0.0463), ncol = 1)
    bias <- -1.8306
  } else if (species == "sheep") {
    weights <- matrix(c(-1.6821, 0.0642), ncol = 1)
    bias <- -1.6821
  } else {
    stop("Error: Unsupported species. Choose from 'bovine', 'goat', 'pig', or 'sheep'.")
  }

  # Build model matrix
  X_test <- cbind(1, PP.value)
  linear_model <- X_test %*% weights
  probabilities <- sigmoid(linear_model)

  # Compute outputs
  expos_prob <- round(probabilities * 100)
  odds <- round((expos_prob) / (100 - expos_prob), 2)
  log_odds <- round(log(odds), 2)
  odds_ratio <- round(odds / (1 / odds), 2)
  risk_status <- cut(expos_prob, breaks = c(-Inf, 50, 75, Inf), labels = c("Low", "Mod", "High"))
  pred_class <- ifelse(probabilities > 0.5, "Positive", "Negative")

  # Output results
  results_df <- data.frame(
    Samp.ID = Sample.ID,
    Expos.Probct = expos_prob,
    Odds = odds,
    Log.Odds = log_odds,
    Odds.Ratio = odds_ratio,
    Risk.Status = risk_status,
    Pred.Class = pred_class
  )

  return(results_df)
}
