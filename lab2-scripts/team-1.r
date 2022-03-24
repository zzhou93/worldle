library(sf)
library(ggplot2)
library(dplyr)

# consider the case when multiple inputs have the same name
# group: polygon group
# district: principal administrative divisions
get_df <- function(geodf)
{
  pointdf <- data.frame()
  for(i in 1:nrow(geodf))
  {
    tmp <- geodf[i,]$points[[1]]
    pointdf <-
      rbind(pointdf,
            lapply(1:length(tmp), FUN = function(x) data.frame(tmp[[x]][[1]], 1:nrow(tmp[[x]][[1]]),
                                                               paste0(geodf$ID[i], x), geodf$name[i])) %>%
              do.call(rbind,.) %>% "names<-"(c("long", "lat","order", "group", "district")))
  }
  return(pointdf)
}

ozbig <- read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz <- thin(ozbig)


oz %>% transmute(ID = GID_1, points = geometry, name = NAME_1) %>%
  split(.$ID) %>% purrr::map(function(x) get_df(x)) %>%
  do.call(rbind, .) %>%
  ggplot(aes(x = long, y = lat, group = group, fill = district)) + geom_polygon() +
  scale_y_continuous(n.breaks = 5)  + theme_bw() + theme(legend.position = "none")
