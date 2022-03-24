
<!-- README.md is generated from README.Rmd. Please edit that file -->

# worldle

<!-- badges: start -->
<!-- badges: end -->

The goal of worldle is to be able to play a game of guessing a country
based on its shape.

## Installation

You can install the development version of worldle like so:

``` r
remotes::install_github("Stat585-at-ISU/worldle")
```

## Example

How do you play?

``` r
library(worldle)
#> Registered S3 method overwritten by 'dplyr':
#>   method         from       
#>   print.location geojsonlint
## basic example code
# play_wordle() # that function doesn't exist yet
```

Get the shapefile of a country:

``` r
url <- "https://geodata.ucdavis.edu/gadm/gadm4.0/shp/gadm40_AUT_shp.zip"
austria <- get_shapes(url)
austria <- thin(austria, 0.001)
```

Now plot the country:

``` r
library(ggplot2)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

austria %>% ggplot() + geom_sf() + theme_void()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

Would you have guessed that this is Austria?
