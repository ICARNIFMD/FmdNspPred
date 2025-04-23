---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

```{r, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%"
)
```

# FmdNspPred

<!-- badges: start -->
<!-- badges: end -->

The goal of FmdNspPred is for Prediction of Foot and Mouth Disease Virus Exposure Using 2B NSP ELISA Data 

## Installation

You can install the development version of FmdNspPred from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ICARNIFMD/FmdNspPred")
```

## Example

This is a basic example which shows you how to solve a common problem:

Users can use sample data into FmdNspPred in a structured text file format (.txt or .csv) or can paste it. The data must follow a specific format to ensure proper processing by the server. Each row of the file should contain the information of Sample.ID and PP.Value. All input data must be organized in a clean and structured manner, ensuring that no missing values are present in the required columns and a correct species should be choosed.
An example of data set: -
Sample.ID	PP.Value
samc1	34.6
samb2	35.9
sams3	27.6
…	…
samg7	53.2

After the data is processed, FmdNspPred provides result in a table format with the columns “Samp.ID”, “Expos.Prob(%)”, “Log.Odds” , “Odds.Ratio”, “Risk.Status” and  “ Pred.Class”.

Samp.ID	Expos.Prob(%)	Log.Odds	Odds.Ratio	Risk.Status	Pred.Class
1	84	1.53	1.69	High	Positive
2	55	0.18	1.20	Mod	Positive
3	44	-0.25	0.78	Low	Negative
…	…	…	…	…	…
65	24	0.32	-1.15	Low	Negative
