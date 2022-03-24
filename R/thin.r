thin <- function(x, tolerance = 0.1, minarea = 0.01) {
  xx <- maptools::thinnedSpatialPoly(
    as(x$geometry, "Spatial"),
    tolerance, minarea , topologyPreserve = TRUE)
  x$geometry <- st_as_sf(xx)$geometry
  x
}
