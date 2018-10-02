library('tidyverse')
library('sf')
library('viridis')
library('tigris')

### Neighborhoods
## http://data.imap.maryland.gov/datasets/maryland-baltimore-city-neighborhoods/data

neighborhoods <- st_read("Maryland_Baltimore_City_Neighborhoods/Maryland_Baltimore_City_Neighborhoods.shp")

ggplot(neighborhoods) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('neighborhoods.png', width = 7, height = 7, bg = 'transparent')

### Census tracts
## https://github.com/walkerke/tigris

options(tigris_class = "sf")
tracts <- tracts(state = "MD", county = "Baltimore City", cb = T)

ggplot(tracts) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('tracts.png', width = 7, height = 7, bg = 'transparent')

### Public elementary school zones
## https://data.baltimorecity.gov/Geographic/Baltimore-City-Public-School-System-Elementary-Sch/6jcd-xgn7#revert

school.zones <- st_read("bcpss_es_boundary/bcpss_es_boundary.shp")

ggplot(school.zones) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('schoolzones.png', width = 7, height = 7, bg = 'transparent')

### Police districts
## http://gis-baltimore.opendata.arcgis.com/datasets/police-districts?geometry=-77.116%2C39.192%2C-76.127%2C39.378

police.districts <- st_read("Police_Districts/Police_Districts.shp")

ggplot(police.districts) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('policedistricts.png', width = 7, height = 7, bg = 'transparent')

### Legislative districts
## http://gis-baltimore.opendata.arcgis.com/datasets/legislative-districts

legislative.districts <- st_read("Legislative_Districts/Legislative_Districts.shp")

ggplot(legislative.districts) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('legislativedistricts.png', width = 7, height = 7, bg = 'transparent')

### City Council districts
## http://gis-baltimore.opendata.arcgis.com/datasets/council-district

council.districts <- st_read("Council_District/Council_District.shp")

ggplot(council.districts) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('councildistricts.png', width = 7, height = 7, bg = 'transparent')


### interactive

library('tmap')
tmap_mode("view")

tm_shape(neighborhoods) +
  tm_polygons(popup.vars = c("Neighborhood" = "LABEL"), id = "LABEL", fill = 'blue')  +
  tm_shape(legislative.districts) +
  tm_polygons(popup.vars = c("Legislative district" = "AREA_NAME"), id = "AREA_NAME") +
  tm_shape(police.districts) +
  tm_polygons(popup.vars = c("Police district" = "Dist_Name"), id = "Dist_Name") +
  tm_shape(tracts) +
  tm_polygons(popup.vars = c("Census tract" = "NAME"), id = "NAME") +
  tm_shape(school.zones) +
  tm_polygons(popup.vars = c("School" = "NAME", 
                             "Address" = "ADDRESS"), id = "NAME") +
  tm_shape(council.districts) +
  tm_polygons(popup.vars = c("District" = "AREA_NAME", 
                             "Council member" = "CNTCT_NME"), id = "NAME") 



