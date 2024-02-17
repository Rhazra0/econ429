# Check if pacman is installed, and if not an empty string is returned and we proceed to install it.
if (system.file(package='pacman') == '') install.packages("pacman")
pacman::p_load("tidyverse")
pacman::p_load("sf")
pacman::p_load("tmap")
pacman::p_load("raster")
pacman::p_load("exactextractr")
pacman::p_load("fixest")
pacman::p_load("haven")
pacman::p_load("readxl")

# We’ll now map it using a unique color for each country:
tmap_options(max.categories = 251)
tm_shape(countries) + tm_borders() + tm_fill("COUNTRY", legend.show = FALSE)

# Add Grid
tm_grid() + tm_shape(countries) + tm_borders() +tm_fill("COUNTRY", legend.show =FALSE)

roads <- ethiopia_major_roads
schools <- st_read("~/GitHub/econ429/lab2/hotosm_eth_education_facilities_points_shp")

#set CRS tells you that this is the coordinate system i'm using (i.e. WGS84)
st_crs(schools)
st_crs(schools, 'WGS84')
st_set_crs(schools, 'WGS84')

#Transforming CRS,  e.g. from WGS84 to NAD83 or transforming projected (flattened) data

