

# ECON-429 - Lab 4 -  Raster Manipulations

setwd("/Users/mgebresilasse/Dropbox (Amherst College)/Courses/202324_Spring/Econ429/econ429labs/lab4")
pacman::p_load(tidyverse,sf,haven,tmap,readxl,fixest,exactextractr,raster)
select <- dplyr::select
tmap_mode("view")


#1. Bring in boundary data - country boundaries

countries <- st_read("world-administrative-boundaries.shp") %>% 
  filter(!is.na(iso3))

## Let's subset the boundary data to only african countries 
africa <- countries %>% filter(continent=="Africa")
tm_shape(africa) + tm_borders()

#2. Download and read agricultural suitability dataset 

## Download Suitability Index for Potato  from FAO 
#download:https://gaez-services.fao.org/apps/theme-4/
#info: https://gaez.fao.org/pages/theme-details-theme-4
#https://s3.eu-west-1.amazonaws.com/data.gaezdev.aws.fao.org/res05/CRUTS32/Hist/6190L/sxLr0_wpo.tif 
  
suitind_potato <- raster("sxLr0_wpo.tif")
plot(suitind_potato)

# 3. Zonal statistics using "exact_extract" from "exactextractr"
# exactextractr vignette: https://cran.r-project.org/web/packages/exactextractr/vignettes/vig1_population.html 
suitind_potato_by_country <- exact_extract(suitind_potato,countries,c("mean","min"),append_cols="iso3")

suitind_potato_by_country <- suitind_potato_by_country %>%
  rename(suitind_pot_mean=mean,suitind_pot_min=min)

## Create a map showing suitability for potato at the country level
# Merge in the new data on potato suitability and night lights to the country boundary data 
countries_withdata <- countries %>% 
  left_join(suitind_potato_by_country,by=c("iso3"))

tm_shape(countries_withdata) + tm_fill("suitind_pot_mean")

## YOUR TURN: for each country calculate the mean and maximum suitability for maize under rain-fed and low input conditions

#3. Working with nightlights

##Download night lights data in 2013 and calculate the average, sum and maximum nightlight within each country in Africa
#Source:  https://eogdata.mines.edu/products/dmsp/
## We want the "F182013.v4c.global.stable_lights.avg_vis.tif"
## Note that 
ntl2013 <- raster("F182013.v4c.global.stable_lights.avg_vis.tif")
plot(ntl2013)

#4. Croping and Masking 
#Spatial data is often larger than we need it to be, the ntl2013 is in fact too large to map in interactive mode
# We may want to subset the data into the region which we may be interested in. 
## Suppose I only need to do the analysis using the ntl2013 for african countries 

# Crop
# If we want to crop the data to keep only the raster cells within the same extent as boundary of interest 
# (e.g. the africa shapefile), we can crop it
ntl2013_africa_crop <- ntl2013 %>% crop(africa)
plot(ntl2013_africa_crop)

# Mask
#If we want to keep the full dimensions of the raster (original extent) but convert all values outside the vector to NA 
# we “mask” the data instead of cropping it
ntl2013_africa_mask <- ntl2013 %>% mask(africa)
plot(ntl2013_africa_mask)

## Often, I would do both to reduce the data size -- crop and mask
ntl2013_africa_cropmask <- ntl2013 %>% crop(africa) %>% mask(africa)

# Let's map this - interactively 
tm_shape(ntl2013_africa_cropmask)+ tm_raster() + tm_shape(africa) + tm_borders()

# Let's calculate the mean and maximum nightlights for each african country 
ntl2013_africa_countryave <- exact_extract(ntl2013_africa_cropmask,africa,c("mean","max"),append_cols="iso3") 

# Map the average ntl by country in 2013
africa_withdata <- africa %>% left_join(ntl2013_africa_countryave %>% rename(ntl2013_mean=mean,ntl2013_max=max,),by=c("iso3"))

tm_shape(africa_withdata) + tm_fill("ntl2013_mean",style="quantile",n=5)

#YOUR TURN: Calculate the average NTL for european countries in 2000, after cropping and masking the raster first 
# raster already in lab4 folder: F142000.v4b.global.stable_lights.avg_vis.tif  

#4.  Stacking and Undertaking Analysis in bulk 
# We can stack rasters like pancakes, and do the same operation (spatial aggregation) that 
# applies to all the rasters in the stack. 

# Suppose I wanted to calculate the average ntl for afrcian countries in 2011 and 2012
# First stack the rasters from 2011 and 2011 togther
ntl_201112 <- stack(raster("F182011.v4c.global.stable_lights.avg_vis.tif"),
                    raster("F182012.v4c.global.stable_lights.avg_vis.tif"))

ntl201112_africa_countryave <- exact_extract(ntl_201112,africa,c("mean"),append_cols="iso3") 

africa_withdata <- africa_withdata %>% 
    left_join(ntl201112_africa_countryave %>% 
             rename(ntl2011_mean=mean.F182011.v4c.global.stable_lights.avg_vis,
             ntl2012_mean=mean.F182012.v4c.global.stable_lights.avg_vis),by=c("iso3"))
    
## Let's see how potato suitability and NTL in 2013 correlate for africa countries 
africa_withdata <- africa_withdata %>% 
    left_join(suitind_potato_by_country,by=c("iso3"))


#5  Running regressions in R using the feols command from "fixest"
## fixest vignette -- https://cran.r-project.org/web/packages/fixest/vignettes/fixest_walkthrough.html 
## Running a simple regression of log ntl on log potato suitability
feols(log(ntl2011_mean+1) ~ log(suitind_pot_mean+1), africa_withdata)
feols(log(ntl2011_mean+1) ~ log(suitind_pot_mean+1), africa_withdata) %>% etable()



### Let's replicate Nunn and Qian 2011 main results -- Table 4 column 1-3
nunnqian2011 <- read_dta("country_level_panel_for_web.dta")

feols(ln_population ~ ln_wpot*post | isocode+year,cluster="isocode",nunnqian2011)

## Let's run and save the output from each of these regressions
col1 <- feols(ln_population ~ ln_wpot*post | isocode+year, cluster="isocode", nunnqian2011)
col2 <- feols(ln_population ~ ln_wpot*post + i(year,ln_oworld) | isocode+year, cluster="isocode", nunnqian2011)
col3 <- feols(ln_population ~ ln_wpot*post + i(year,ln_oworld) + i(year,ln_elevation) + i(year,ln_rugged)  + i(year,ln_tropical)
              | isocode+year, cluster="isocode", nunnqian2011)
### Let create the table bringing together each of these columns
etable(col1,col2,col3)

## Let's clean it up a bit 
etable(col1,col2,col3,digits ="r3",keep="ln_wpot")

## You can customize it as you see fit and save it as latex or other formats
textab <- etable(col1,col2,col3,replace= TRUE, keep = "ln_wpot", digits="r3", depvar=FALSE,
       headers = .(" " = .('Dependent Variable'=3)," " = .('ln total population'=3)), 
       file="nunnqian2011_table4.tex")

## YOUR TURN: do the same for columns 6-8 in Table 4





