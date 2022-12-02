library(tidyverse)

# Script to create a national team info dataset

games <- read_delim("Data/Cleaned/games_cleaned.txt")

rankings <- read_delim("Data/fifa_rankings_06_2022.csv") %>% 
  distinct(country_full, .keep_all = T) %>% 
  select(country_full, country_abrv, confederation) %>% 
  rename("team" = country_full)

tmp.1 <- games %>% select(home_team, year) %>% distinct(home_team, .keep_all = T) %>% rename("team" = home_team)
tmp.2 <- games %>% select(away_team, year) %>% distinct(away_team, .keep_all = T) %>% rename("team" = away_team)

nation <- rbind(tmp.1, tmp.2) %>% 
  arrange(year) %>% 
  distinct(team, .keep_all = T) %>% 
  inner_join(rankings, by = "team") %>% 
  mutate() %>% 
  rename("FIFA_name" = team,
         "First_game" = year,
         "FIFA_short" = country_abrv,
         "FIFA_confederation" = confederation) %>% 
  select(FIFA_name, FIFA_short, FIFA_confederation, First_game)

write_delim(nation, file = "Data/Cleaned/nations_cleaned.txt", quote = "none", delim = "\t")



  
  