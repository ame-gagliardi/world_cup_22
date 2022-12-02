library(tidyverse)
source("Script/functions.R")

# Script to create a match database
games <- read_delim("Data/results.csv")

games <- games %>% 
  filter(date < as.Date("2022-11-20")) %>%
  # Change names to match the Official FIFA rankings name in home team column
  mutate(home_team = case_when(
    home_team == "United States" ~ "USA",
    home_team == "DR Congo" ~ "Congo DR",
    home_team == "South Korea" ~ "Korea Republic",
    home_team == "Iran" ~ "IR Iran",
    home_team == "Vietnam Republic" ~ "Vietnam",
    home_team == "North Korea" ~ "Korea DPR",
    home_team == "Kyrgyzstan" ~ "Kyrgyz Republic",
    home_team == "Cape Verde" ~ "Cabo Verde",
    home_team == "Brunei" ~ "Brunei Darussalam",
    home_team == "Yemen DPR" ~ "Yemen",
    home_team == "Ivory Coast" ~ "Côte d'Ivoire",
    home_team == "North Macedonia" ~ "FYR Macedonia",
    home_team == "Taiwan" ~ "Chinese Taipei",
    home_team == "São Tomé and Príncipe" ~ "Sao Tome e Principe", 
    home_team == "United States Virgin Islands" ~ "US Virgin Islands",
    home_team == "Saint Vincent and the Grenadines" ~ "St. Vincent / Grenadines",
    home_team == "Netherlands Antilles" ~ "Curacao",
    home_team == "Turkey" ~ "Türkiye"
    , TRUE ~ home_team)) %>% 
  # Change names to match the Official FIFA rankings name in away team column
  mutate(away_team = case_when(
    away_team == "United States" ~ "USA",
    away_team == "DR Congo" ~ "Congo DR",
    away_team == "South Korea" ~ "Korea Republic",
    away_team == "Iran" ~ "IR Iran",
    away_team == "Vietnam Republic" ~ "Vietnam",
    away_team == "North Korea" ~ "Korea DPR",
    away_team == "Kyrgyzstan" ~ "Kyrgyz Republic",
    away_team == "Cape Verde" ~ "Cabo Verde",
    away_team == "Brunei" ~ "Brunei Darussalam",
    away_team == "Yemen DPR" ~ "Yemen",
    away_team == "Ivory Coast" ~ "Côte d'Ivoire",
    away_team == "North Macedonia" ~ "FYR Macedonia",
    away_team == "Taiwan" ~ "Chinese Taipei",
    away_team == "São Tomé and Príncipe" ~ "Sao Tome e Principe", 
    away_team == "United States Virgin Islands" ~ "US Virgin Islands",
    away_team == "Saint Vincent and the Grenadines" ~ "St. Vincent / Grenadines",
    away_team == "Netherlands Antilles" ~ "Curacao",
    away_team == "Turkey" ~ "Türkiye"
    , TRUE ~ away_team)) %>%
  mutate(home_team = str_replace_all(home_team, "Saint", "St."),
         away_team = str_replace_all(away_team, "Saint", "St.")) %>% 
  # Split the date format in Y-M-D column for further analyses
  mutate(year = year(date),
         month = month(date, label = T),
         day = wday(date, label = T, week_start = 1)) %>% 
  rowwise() %>% 
  # Create additional column for easier management 
  mutate(outcome = game_outcome(home_score, away_score),
         winner = winning_team(home_score, away_score, home_team, away_team),
         loser = losing_team(home_score, away_score, home_team, away_team),
         full_result = paste0(home_score, "-", away_score)) %>% 
  ungroup() %>% 
  select(year, month, day, city, country, tournament, neutral, home_team, away_team, home_score, away_score, full_result, outcome, winner, loser)


write_delim(games, file = "Data/Cleaned/games_cleaned.txt", quote = "none", delim = "\t")

