library(stringr)
library(sf)
library(dplyr)
library(ggplot2)

extract_data <- function(shape_url=url, level=1){
  # Extract Name
  url_splitted = strsplit(url,split = '/')[[1]]
  file_name = url_splitted[length(url_splitted)]
  # Download File
  zipped <- shape_url
  download.file(zipped,
                destfile=paste0("data/", file_name),
                mode="wb")
  # unzip
  new_folder = str_replace(paste0("data/", file_name), '.zip', '')
  unzip(paste0("data/", file_name),
        exdir = new_folder)
  # Read
  sf_file = paste0(new_folder, "/", str_replace(file_name, 'shp.zip', paste0(level, '.shp')))
  oz <- read_sf(sf_file)

  # Thinning
  oz_sm <- thin(oz)

  # Create Data Frame
  oz_sm <- oz_sm %>% mutate(
    data = 1:length(geometry) %>% purrr::map(.f = function(i) {
      g <- geometry[[i]]
      res <- g %>% purrr::map_df(.id="i", .f = function(gelement) {
        as.data.frame(gelement[[1]])
      })
      res$group <- paste0(i,"-",res$i)
      res
    })
  )

  # Unnest Data Frame
  oz_data <- oz_sm$data[[1]]

  # Change Column Names
  colnames(oz_data) <- c('order', 'long', 'lat', 'group')

  return(oz_data)
}

# For Iran
url <- 'https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_IRN_shp.zip'
iran <- extract_data(url, level = 0)
head(iran)

iran %>%
  ggplot(aes(x =long, y = lat, group = group))+
  geom_polygon() +
  ggtitle('Iran')
