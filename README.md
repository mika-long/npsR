
<!-- README.md is generated from README.Rmd. Please edit that file -->

# npsR

<!-- badges: start -->
<!-- badges: end -->

The goal of npsR is to interact with the National Park Service (NPS) API
and pull data from them in an easy fashion.

## Installation

You can install the development version of npsR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mika-long/npsR")
```

For the code to work, you will also need an API key from NPS, which can
be easily attained from [this
website](https://www.nps.gov/subjects/developer/get-started.htm).

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(npsR)
# Sys.setenv(NPS_API_KEY = "Your key")
Sys.getenv
#> function (x = NULL, unset = "", names = NA) 
#> {
#>     if (is.null(x)) {
#>         x <- .Internal(Sys.getenv(character(), ""))
#>         m <- regexpr("=", x, fixed = TRUE)
#>         n <- substring(x, 1L, m - 1L)
#>         v <- substring(x, m + 1L)
#>         if (isFALSE(names)) 
#>             v[sort.list(n)]
#>         else {
#>             v <- structure(v, names = n)
#>             structure(class = "Dlist", v[sort.list(n)])
#>         }
#>     }
#>     else {
#>         v <- .Internal(Sys.getenv(as.character(x), as.character(unset)))
#>         if (isTRUE(names) || (length(x) > 1L && !isFALSE(names))) 
#>             structure(v, names = x)
#>         else v
#>     }
#> }
#> <bytecode: 0x000001a3d1d1f000>
#> <environment: namespace:base>
ca_parks <- get_parks(state_code = "CA", limit=10)
head(ca_parks)
#> # A tibble: 6 × 8
#>   id                url   name  state description weatherInfo latitude longitude
#>   <chr>             <chr> <chr> <chr> <chr>       <chr>          <dbl>     <dbl>
#> 1 C08AD828-98FF-47… http… Alca… CA    Alcatraz r… The climat…     37.8     -122.
#> 2 F2A0D649-ED66-4B… http… Butt… MO,A… In 1857, b… Due to the…     32.3     -107.
#> 3 2DB09FB7-0408-44… http… Cabr… CA    In 1542, J… Check the …     32.7     -117.
#> 4 B39C368F-CB27-49… http… Cali… CA,C… Follow in … Due to the…     42.4     -109.
#> 5 872417E6-2F91-4F… http… Cast… CA    Castle Mou… Weather at…     35.3     -115.
#> 6 5595FC7A-F218-44… http… Chan… CA    Channel Is… In general…     34.0     -120.
```

<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so: -->
<!-- ```{r cars} -->
<!-- summary(cars) -->
<!-- ``` -->
<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
<!-- You can also embed plots, for example: -->
<!-- ```{r pressure, echo = FALSE} -->
<!-- plot(pressure) -->
<!-- ``` -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->
