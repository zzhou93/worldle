% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_shapes.R
\name{get_shapes}
\alias{get_shapes}
\title{Download a shapefile from GADM}
\usage{
get_shapes(url, level = 0)
}
\arguments{
\item{url}{address to zipped file shapes}

\item{level}{which level to extract? 0 is country outline, 1 is state/territories, for some (but not all) countries exist lower-level country divisions (e.g. counties, municipalities)}
}
\description{
we need a bit more explanation here ... The function works with both versions 3.6 and 4.0 of the GADM library
}
