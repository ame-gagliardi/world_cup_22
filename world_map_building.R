library(tidyverse)
library(lubridate)
library(maps)
library(rworldmap)
library(rgdal)
library(sf)

# Script to create world map with the right region/state and cazzi e mazzi
world <- read_sf(dsn = ".") %>% 
  select(SOVEREIGNT, SUBUNIT, geometry) %>% 
  arrange(SOVEREIGNT)

# Change to both the df to match

nation.teams$FIFA_name[which(nation.teams$FIFA_name == "USA")] <- "United States"
world$SUBUNIT[which(world$SOVEREIGNT == "Belgium")] <- c("Belgium")
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "China PR")] <- "China"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Türkiye")] <- "Turkey"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Republic of Ireland")] <- "Ireland"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "St. Kitts and Nevis")] <- "Saint Kitts and Nevis"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "St. Lucia")] <- "Saint Lucia"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "IR Iran")] <- "Iran"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Congo DR")] <- "Democratic Republic of the Congo"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Macau")] <- "Macao S.A.R"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Korea Repulic")] <- "South Korea"
world$SUBUNIT[which(world$SOVEREIGNT == "South Korea")] <- "South Korea"
world$SUBUNIT[which(world$SOVEREIGNT == "North Korea")] <- "North Korea"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Korea DPR")] <- "North Korea"
nation.teams$FIFA_name[which(nation.teams$FIFA_name == "Chinese Taipei")] <- "Taiwan"
world$SUBUNIT[which(world$SUBUNIT == "French Polynesia")] <- "Tahiti"




shp_df <- broom::tidy(shp, "SUBUNIT")



# nation.teams <- read_delim("C:/Users/amega/OneDrive/Desktop/Coding/R/kaggle/WorldCup_22/Data/Cleaned/nations_cleaned.txt")
  
world.subunit <- world$SUBUNIT
nation.teams$FIFA_name[which(nation.teams$FIFA_name %!in% world$SUBUNIT)]
nation.teams$FIFA_name[which(nation.teams$FIFA_name %!in% world$SUBUNIT)] <- 
  c("United States")

ggplot(world, aes(x = long, y = lat, group = group, fill = region)) +
  geom_polygon() +
  theme(legend.position = "none")
library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

ggplot(data = world) +
  geom_sf()


library(maps)

NI <- map_data("world") %>%
  filter(region == "UK")

ggplot(NI, aes(x = long, y = lat, group = group, fill = subregion)) +
  geom_polygon() +
  coord_map() +
  ggthemes::theme_map() 
