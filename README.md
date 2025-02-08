
# npsR

<!-- badges: start -->
<!-- badges: end -->

The goal of `npsR` is to create an R interface for interacting with the National Park Service (NPS) API. The official documentation for the NPS API can be found [here](https://www.nps.gov/subjects/developer/api-documentation.htm#/). 

## Installation

You can install the development version of `npsR` like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

You will also need to obtain an API key in order to use this package. Follow the instructions [here](). 

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(npsR)
Sys.setenv(NPS_API_KEY = "your_key")
ca_parks <- get_parks(state_code = "CA", limit=10)
head(ca_parks)
```

