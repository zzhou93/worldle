library(sf)
library(purrr)
library(ggplot2)


##function to convert to the dataframe we need
func.plus <- function(dat) {
  data.frame(long = dat[,1], lat = dat[,2], group = rep(rnorm(1), nrow(dat)))
}

func.oz <- function(spf){
  #thin the number of points
  oz <- thin(spf)

  oz$geometry %>%
    flatten() %>%
    flatten() %>%
    map_df(.id = "group", .f = func.plus) %>%
    ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
}


###insert any shape file and it thins it and creates a data frame from the geometry variable and
#plots it
func.oz(spf = read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp"))
