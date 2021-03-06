library('tidyverse')
library('sf')
library('viridis')
library('tigris')

### Reference: https://learn.r-journalism.com/en/mapping/static_maps/static-maps/

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

### Community Statistical Areas
## https://data-bniajfi.opendata.arcgis.com/datasets/vital-signs-16-census-demographics

csas <- st_read("Vital_Signs_16_Census_Demographics/Vital_Signs_16_Census_Demographics.shp")

ggplot(csas) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent'))

ggsave('csas.png', width = 7, height = 7, bg = 'transparent')

### Zip code maps
## https://planning.maryland.gov/MSDC/Pages/zipcode_map/2015-16/zip15-16idx.aspx
## note "The resulting files are meant to serve as a "good approximation" of zip codes as polygons (which in reality they are not) but are not official Zip Code maps and are not meant to be a substitute for any products offered by the U.S. Postal Service, the official source for zip code information." via https://planning.maryland.gov/MSDC/Pages/postalservice-zipcode-map.aspx

zip.codes <- st_read("bacizc_15/bacizc15.shp")
zip.codes.2 <- st_read("bacizc_15/bacipz15.shp")

ggplot(zip.codes) + geom_sf() +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent')) +
  geom_sf(data = zip.codes.2) +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'transparent')) 

# dots bc there are multiple zip codes in the area, see https://planning.maryland.gov/MSDC/Documents/zipcode_map/2015/bacizc_15.pdf

ggsave('zipcodes.png', width = 7, height = 7, bg = 'transparent')

### interactive
# https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html

library('tmap')
tmap_mode("view")

tm_shape(neighborhoods) +
  tm_polygons(popup.vars = c("Neighborhood" = "LABEL"), id = "LABEL", fill = 'blue')  +
  tm_shape(csas) +
  tm_polygons(popup.vars = c("Name" = "CSA2010", "Population (2010)" = "tpop10"), id = "CSA2010") +
  tm_shape(legislative.districts) +
  tm_polygons(popup.vars = c("Legislative district" = "AREA_NAME"), id = "AREA_NAME") +
  tm_shape(zip.codes) +
  tm_polygons(popup.vars = c("Name" = "ZIPNAME", "ZIP Code" = "ZIPCODE1"), id = "ZIPCODE1") +
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



