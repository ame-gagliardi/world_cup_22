# Functions

game_outcome <- function(home_score, away_score) {
  outcome <- "D"
  if (home_score > away_score) {outcome <- "H"}
  if (home_score < away_score) {outcome <- "A"}
  return(outcome)
}

winning_team <- function(home_score, away_score, home_team, away_team) {
  winning_team <- NA
  if (home_score > away_score) {winning_team <- home_team}
  if (home_score < away_score) {winning_team <- away_team}
  return(winning_team)
}

losing_team <- function(home_score, away_score, home_team, away_team) {
  losing_team <- NA
  if (home_score < away_score) {losing_team <- home_team}
  if (home_score > away_score) {losing_team <- away_team}
  return(losing_team)
}