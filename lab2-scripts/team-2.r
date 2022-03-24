library(sf)
library(purrr) # for flatten
library(ggplot2)

ozbig <- read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz <- thin(ozbig)
# oz = ozbig

# Each oz$geometry[[i]][[j]][[1]] is a polygon
ozgeo = oz$geometry

f = function(l){
  l = l %>% flatten() %>% flatten()
  for(i in 1:length(l)){
    l[[i]] = data.frame(l[[i]])
    colnames(l[[i]]) = c('long', 'lat')
    l[[i]]$order = 1:nrow(l[[i]])
    l[[i]]$group = i
  }
  do.call(rbind, l)
}

ozplus = f(ozgeo)
ozplus %>% ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
