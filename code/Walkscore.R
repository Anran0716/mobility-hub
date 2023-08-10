setwd("C:\\Users\\yiming.xu\\Desktop")

#install.packages("walkscoreAPI")
library(walkscoreAPI)
library(sf)

test<-st_read('C:/Users/anranzheng/Dropbox (UFL)/Mobility Hub/Data/gnv/Bus Stops/new stops.shp')
test$Walkscore<-0

for (i in 1:length(test$stop_id)) {
  a<-getWS(test$stop_lon[i],test$stop_lat[i], "f5a55e59a2d6be9b2263c3471e81c86d")
  test$Walkscore[i]<-a$walkscore
}

test$Walkscore[which(test$Walkscore=='NA')] <- 0

library(raster)
projection(test) = "+init=espg:4326" # WGS84 coords
shapefile(test, "Walkscore.shp")

write.csv(test,file="Walkscore.csv")

for (i in 1:length(test$stop_id)) {
  a<-getWS(test$stop_lon[i],test$stop_lat[i], "f5a55e59a2d6be9b2263c3471e81c86d")
  test$Walkscore1[i]<-a$bscore
}

miami<-read.csv('C:/Users/anranzheng/Dropbox (UFL)/ML proj/Bus Delay Prediction/Miami/miami data/merge_schedule.csv')
