#shoutout to JoshMcCrain and GG2TOR

library(osmdata)   #download and use openstreetmap data
#if we want the up-to-date version of the package:
#remotes::install_github("ropensci/osmdata")
library(tidyverse)
library(showtext)  #fonts
library(ggmap)
library(rvest)     #to download and manipulate HTML and XML
library(sf)        #for spatial vector data

#----Loading in osm data----
town <- getbb("Debrecen")

big_streets <- town %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()

med_streets <- town %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()

small_streets <- town %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway"
                  )) %>%
  osmdata_sf()

waterway <- town %>%
  opq()%>%
  add_osm_feature(key = "waterway") %>%
  osmdata_sf()

railway <- town %>%
  opq()%>%
  add_osm_feature(key = "railway") %>%
  osmdata_sf()

#----Plotting----
#first simpler maps, with less detail to tweak the visuals
#darkplot1
ggplot() +
  
  geom_sf(data = waterway$osm_lines,
          inherit.aes = FALSE,
          color = "lightblue",
          size = .2) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#f1a45a") +
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          color = "#ff9933",
          size = .3,
          linetype="dashed",
          alpha = .5) +
  coord_sf(xlim = c(21.3, 21.9), 
           ylim = c(47.40, 47.67),
           expand = FALSE) +
  theme_void() +
  theme(plot.title = element_text(size = 20, face="bold", color = "#fcf5ed", hjust=.5),
        plot.subtitle = element_text(size = 8, color = "#fcf5ed", hjust=.5, margin=margin(2, 0, 5, 0)), plot.background = element_rect(fill = "#282828")) +
  labs(title = "Debrecen", subtitle = "é. sz. 47° 31′ 48″ / k. h. 21° 38′ 21″")

ggsave("output/map_dark.tiff", width = 8.2, height = 6)

  
#lightplot1
ggplot() +
  
  geom_sf(data = waterway$osm_lines,
          inherit.aes = FALSE,
          color = "lightblue",
          size = .2) +
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          linetype="dashed",
          alpha = .5) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black") +
  coord_sf(xlim = c(21.3, 21.9), 
           ylim = c(47.40, 47.67),
           expand = FALSE) +
  theme_void() +
  theme(plot.title = element_text(size = 20, face="bold", color = "black", hjust=.5),
        plot.subtitle = element_text(size = 8, color = "black", hjust=.5, margin=margin(2, 0, 5, 0)), plot.background = element_rect(fill = "#fcf6f0")) +
  labs(title = "Debrecen", subtitle = "é. sz. 47° 31′ 48″ / k. h. 21° 38′ 21″")

ggsave("output/map_light.tiff", width = 8.2, height = 6)

#detailed maps

#darkplot2
ggplot() +
  
  geom_sf(data = waterway$osm_lines,
          inherit.aes = FALSE,
          color = "lightblue",
          size = .2) +
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          color = "#ff9933",
          size = .3,
          linetype="dashed",
          alpha = .5) +
  geom_sf(data = small_streets$osm_lines,
            inherit.aes = FALSE,
            color = "#f1a45a",
            size = .2,
            alpha = .3) +
  geom_sf(data = med_streets$osm_lines,
            inherit.aes = FALSE,
            color = "#f1a45a",
            size = .3,
            alpha = .5) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#f1a45a") +
  coord_sf(xlim = c(21.3, 21.9), 
             ylim = c(47.40, 47.67),
             expand = FALSE) +
    theme_void() +
    theme(plot.title = element_text(size = 20, face="bold", color = "#fcf5ed", hjust=.5),
          plot.subtitle = element_text(size = 8, color = "#fcf5ed", hjust=.5, margin=margin(2, 0, 5, 0)), plot.background = element_rect(fill = "#282828")) +
    labs(title = "Debrecen", subtitle = "é. sz. 47° 31′ 48″ / k. h. 21° 38′ 21″")
  
  

  ggsave("output/map_dark_detailed.tiff", width = 8.2, height = 6)
  
  #lightplot2
  ggplot() +
    
    geom_sf(data = waterway$osm_lines,
            inherit.aes = FALSE,
            color = "lightblue",
            size = .2) +
    geom_sf(data = railway$osm_lines,
            inherit.aes = FALSE,
            color = "black",
            size = .3,
            linetype="dashed",
            alpha = .5) +
    geom_sf(data = small_streets$osm_lines,
            inherit.aes = FALSE,
            color = "#666666",
            size = .2,
            alpha = .3) +
    geom_sf(data = med_streets$osm_lines,
            inherit.aes = FALSE,
            color = "#404040",
            size = .3,
            alpha = .5) +
    geom_sf(data = big_streets$osm_lines,
            inherit.aes = FALSE,
            color = "black") +
    coord_sf(xlim = c(21.3, 21.9), 
             ylim = c(47.40, 47.67),
             expand = FALSE) +
    theme_void() +
    theme(plot.title = element_text(size = 20, face="bold", color = "black", hjust=.5),
          plot.subtitle = element_text(size = 8, color = "black", hjust=.5, margin=margin(2, 0, 5, 0)), plot.background = element_rect(fill = "#fcf6f0")) +
    labs(title = "Debrecen", subtitle = "é. sz. 47° 31′ 48″ / k. h. 21° 38′ 21″")
  
  ggsave("output/map_light_detailed.tiff", width = 8.2, height = 6)
  