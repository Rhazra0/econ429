

# ECON-429 - Lab 4 -  Raster Manipulations

pacman::p_load(tidyverse,sf,haven,tmap,readxl,fixest,exactextractr,raster, terra)
select <- dplyr::select
tmap_mode("view")


#1. Bring in boundary data - country boundaries and call it countries
countries <- st_read("world-administrative-boundaries.shp") |> #only want countries with iso code
  filter(!is.na(iso3))

## Let's subset the boundary data to only african countries 

africa <- countries |>
  filter(continent == "Africa")

#tm_shape(africa) + tm_borders()

#2. Download and read agricultural suitability dataset 

## Download Suitability Index for Potato  from FAO 
#download:https://gaez-services.fao.org/apps/theme-4/
#info: https://gaez.fao.org/pages/theme-details-theme-4
#https://s3.eu-west-1.amazonaws.com/data.gaezdev.aws.fao.org/res05/CRUTS32/Hist/6190L/sxLr0_wpo.tif 
  
suitpot<- raster("sxLr0_wpo.tif")

tm_shape(suitpot) + tm_raster()

# 3. **Zonal statistics** using "exact_extract" from "exactextractr"
# exactextractr vignette: https://cran.r-project.org/web/packages/exactextractr/vignettes/vig1_population.html 

###Zonal Statistics: if we want suitability for a country that has cells with diff suitability for each cell,
###we can do the weighted mean of the grid, the minimum cell value, the maximum cell value; uses the zone overlapped
### with the raster. We can aggregate grids into country measures

#countries are zones, in this case



## For each country let's calculate the mean and minimum suitability index for potato. (range from 0-10000)


## rename the variables 
suitpot_world <- exact_extract(suitpot,countries,c("mean", "max"),append_cols = c("iso3"))|>
  rename(suitpot_mean = mean, suitpot_max = max)

## Create a map showing suitability for potato at the country level
# Merge in the new data on potato suitability and night lights to the country boundary data 
suitpot_world_tomap <- countries |>
  left_join(suitpot_world, by = c("iso3"))

tm_shape(suitpot_world_tomap) + tm_fill("suitpot_mean") #plots spefici values using tm_fill

## YOUR TURN: for each country calculate the mean and maximum suitability for maize under rain-fed and low input conditions

maize <- raster("sxLr0_mze.tif")
maize_africa <- exact_extract(maize, africa, c("max"), append_cols = c("iso3")) |>
  rename(maize_max = max)

maize_tomap <- africa |>
  left_join(maize_africa, by = c("iso3"))

tm_shape(maize_tomap) + tm_fill("maize_max")

#3. Working with nightlights

##Download night lights data in 2013 and calculate the average, sum and maximum nightlight within each country in Africa
#Source:  https://eogdata.mines.edu/products/dmsp/
## We want the "F182013.v4c.global.stable_lights.avg_vis.tif"

nt2013 <- raster("F182013.v4c.global.stable_lights.avg_vis.tif")
#tm_shape(nt2013) + tm_raster()

#4. Croping and Masking 
#Spatial data is often larger than we need it to be, the ntl2013 is in fact too large to map in interactive mode
# We may want to subset the data into the region which we may be interested in. 
## Suppose I only need to do the analysis using the ntl2013 for african countries 

# Crop
# If we want to crop the data to keep only the raster cells within the same extent as boundary of interest 
# (e.g. the africa shapefile), we can crop it
 nt2013_crop <- nt2013 |>
   crop(africa)
# Mask
#If we want to keep the full dimensions of the raster (original extent) but convert all values outside the vector to NA 
# we “mask” the data instead of cropping it
 nt2013_mask <- nt2013 |>
   mask(africa)

## Often, I would do both to reduce the data size -- crop and mask
 nt2013_cropmask <- nt2013 |>
   terra::crop(africa)|>
   terra::mask(africa)
 
 tm_shape(nt2013_cropmask) + tm_raster()
 
# Let's map this - interactively 
 
# Let's calculate the mean and maximum nightlights for each african country 
 
# Map the average ntl by country in 2013
 nt2013_africa <- exact_extract(nt2013_cropmask, africa, c("mean"), append_cols = "iso3")
 
 africa_tomap <- africa |>
   left_join(nt2013_africa, by = c("iso3"))
 
 tm_shape(africa_tomap) + tm_fill("mean", breaks = c(0,1,10,20,30,40,60,70))
 
#YOUR TURN: Calculate the average NTL for european countries in 2000, after cropping and masking the raster first 
# raster already in lab4 folder: F142000.v4b.global.stable_lights.avg_vis.tif  

#4.  Stacking and Undertaking Analysis in bulk 
# We can stack rasters like pancakes, and do the same operation (spatial aggregation) that 
# applies to all the rasters in the stack. 
 nt2012 <- raster("F182012.v4c.global.stable_lights.avg_vis.tif")

# Suppose I wanted to calculate the average ntl for afrcian countries in 2011 and 2012
# First stack the rasters from 2012 and 2013 together, 
 ntpancake <- stack(nt2013,nt2012)
## We can now calculate the mean ntl by country for both 2011 and 2012 in the same place using exact_extract
ntpancake_africa <- exact_extract(ntpancake, africa, c("mean"), append_cols = "iso3")
## Note that exact_extract using the raster file name as the variable name along with the type of statistics generated 
##can subset based on layer 
## Let's see how potato suitability and NTL in 2013 correlate for africa countries 
 
#5  Running regressions in R using the feols command from "fixest"
## fixest vignette -- https://cran.r-project.org/web/packages/fixest/vignettes/fixest_walkthrough.html 
## Running a simple regression of log ntl on log potato suitability

### Let's replicate Nunn and Qian 2011 main results -- Table 4 column 1-3
nunnqian2011 <- read_dta("country_level_panel_for_web.dta")



## Let's run and save the output from each of these regressions
#Column 1
col1 <- feols(ln_population ~ ln_wpot*post | isocode + year, cluster = "isocode", nunnqian2011)

# Column 2 -- includes differential trends by log of Old World Crops Area
col2 <- feols(ln_population ~ ln_wpot*post + i(year,ln_oworld)| isocode + year, cluster = "isocode", nunnqian2011)

# Column 3 -- includes differential trends by Old World Crops Area, elevation, ruggedness and terrain

col3<- feols(ln_population ~ ln_wpot*post + i(year,ln_oworld) + i(year,ln_rugged) + i(year,ln_elevation)+ i(year,ln_tropical)| isocode + year, 
             cluster = "isocode", nunnqian2011)

### Let create the table bringing together each of these columns
 etable(col1,col2,col3, keep = "ln_wpot", digits = 3, file = "here.tex")
## Let's clean it up a bit 
 
## You can customize it as you see fit and save it as latex or other formats
 
## YOUR TURN: do the same for columns 6-8 in Table 4





