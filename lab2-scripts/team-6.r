library(sf)
library(purrr)
library(ggplot2)

# Load in the data from the shapefile for Australia
ozbig <- read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz <- thin(ozbig)

# Helper function to turn a matrix into a single data frame with variables long, lat, group, order
mat2df <- function(mat){
  data.frame(long = mat[, 1],
             lat  = mat[, 2],
             group = rep(rnorm(1),nrow(mat)),
             order= 1:nrow(mat))
}

# Create data frames from the geometry variable and plot
oz$geometry %>%
  flatten() %>%
  flatten() %>%
  map_df(.id ="group", .f = mat2df) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon() +
  geom_path(aes(x = long, y = lat, group = group), alpha = 0.2, inherit.aes = FALSE) +
  theme_bw()
