library('GISTools')
library('sp')
library('rgdal')
library('data.table')
library('sf')
library('dplyr')

#Reading Shape file of the comunities
filepath <- "xxxxxxx"
Comunities_sf<- st_read(filepath)
Comunities_sf<-st_transform(Comunities_sf,crs=4326)

#Plotting the Comunities
plot(Comunities)
plot(Comunities_sf["comm_code"], key.pos = 1, key.width = lcm(1.3), key.length = 1.0, axes = TRUE)
plot(Comunities_sf["sector"], key.pos = 1, key.width = lcm(1.3), key.length = 1.0, axes = TRUE)


#Reading Property Coordinates of  Properties and Tranforming them into a sf file.
Properties<-read.csv("xxxxxxxxx")
Properties_sf<- st_as_sf(Properties, coords = c("Longitude", "Latitude"),crs=4326)
plot(Properties_sf["Address"], key.pos = 1, key.width = lcm(1.3), key.length = 1.0, axes = TRUE)


#Checking the Intersection
Result <- Properties_sf %>% mutate(intersection = as.integer(st_intersects(geometry, Comunities_sf)),
  Micromarket = if_else(is.na(intersection), '', Comunities_sf$name[intersection])) 

#Write cs.v

write.csv("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/Python Projects/Community_files/intersection.csv")