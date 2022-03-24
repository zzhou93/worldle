#' Shape file for Austria
#'
#' @examples
#' \dontrun{
#' # created from
#' url <- "https://geodata.ucdavis.edu/gadm/gadm4.0/shp/gadm40_AUT_shp.zip"
#' austria <- get_shapes(url)
#' austria <- austria %>% thin(tolerance = 0.0001)
#' usethis::use_data(austria)
#' }
#' library(ggplot2)
#' library(dplyr)
#' data(austria)
#' austria %>% ggplot() + geom_sf()
"austria"
