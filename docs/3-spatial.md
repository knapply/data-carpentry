---
output: html_document
editor_options:
  chunk_output_type: console
---

# Types of Spatial Data


```r
packages <- c(
  "leaflet",  # interactive web mapping
  "osmdata",  # Open Street Maps API data
  "raster",   # obtaining administrative boundary data and spatial raster data handling
  "sf",       # spatial vector data handling
  "stars",    # {sf}'s spatio-temporal raster counterpart
  "tidyverse" # data manipulation
)

install.packages(
  packages[!sapply(packages, requireNamespace, quietly = TRUE)]
)

library(leaflet)
library(sf)
#> Linking to GEOS 3.7.1, GDAL 2.4.2, PROJ 5.2.0
library(stars)
#> Loading required package: abind
library(tidyverse)
#> -- Attaching packages ---------------------------------------------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.2     v purrr   0.3.4
#> v tibble  3.0.3     v dplyr   1.0.2
#> v tidyr   1.1.2     v stringr 1.4.0
#> v readr   1.3.1     v forcats 0.5.0
#> -- Conflicts ------------------------------------------------------------------- tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
```









\begin{center}\includegraphics[width=1\linewidth]{images/osm_all} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{3-spatial_files/figure-latex/unnamed-chunk-5-1} \end{center}




\begin{center}\includegraphics[width=1\linewidth]{3-spatial_files/figure-latex/unnamed-chunk-6-1} \end{center}



\begin{center}\includegraphics[width=1\linewidth]{3-spatial_files/figure-latex/unnamed-chunk-7-1} \includegraphics[width=1\linewidth]{3-spatial_files/figure-latex/unnamed-chunk-7-2} \end{center}


