# NFL_SQL_Database
## Overview

This project contains a relational SQL database that models data relevant to the National Football League (NFL). It includes structured information on teams, players, coaches, games, stadiums, and statistics, enabling complex queries and analysis of NFL data.

## Features

- Teams with division and conference alignment
- Players with position, team, and performance statistics
- Coaches associated with teams and seasons
- Schedule and results of games by week and season
- Stadiums with location and capacity details
- Support for querying player performance, team standings, head-to-head results, and more

## Database Schema

The database consists of the following primary tables:

- `teams(team_id, name, city, division, conference)`
- `players(player_id, name, team_id, position)`
- `coaches(coach_id, name, team_id, role, season)`
- `stadiums(stadium_id, name, location, capacity)`
- `games(game_id, home_team_id, away_team_id, stadium_id, week, season, home_score, away_score, date)`
- `player_stats(player_id, game_id, passing_yards, rushing_yards, receiving_yards, touchdowns, interceptions)`

## Installation

1. Clone this repository.
2. Import the SQL schema and data into your preferred SQL database (e.g., PostgreSQL, MySQL, SQLite).

```bash
psql -U your_username -d nfl_database -f schema.sql
