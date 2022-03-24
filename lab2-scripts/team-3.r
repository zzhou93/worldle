library(sf)
library(purrr)
library(ggplot2)

ozbig <- read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz <- thin(ozbig)

llg_fun <- function(y) {
  data <- data.frame(long = y[, 1],
                     lat  = y[, 2],
                     groups = rep(1,length(y)))
}

matrix <- oz$geometry %>% flatten() %>% flatten()

ozplus <- matrix %>% purrr::map_df(.x = ., .id ="group", .f = llg_fun)

ozplus %>% ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
