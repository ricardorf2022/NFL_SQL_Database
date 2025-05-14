create table Team (
team_id 				serial Primary key,
season_rank				int unique,
team_name				varchar(100) unique not null,
city 					varchar(100) not null,
division				varchar(15) not null,
head_coach_id			int unique
);

CREATE TABLE Coach (
    coach_id 			SERIAL PRIMARY KEY,
    name 				VARCHAR(100) NOT NULL,
	Coach_type			varchar(50),
	team_name 			varchar(50) references team(team_name) on delete cascade,
    age 				INT,
    experience_years 	INT,
    team_id 			INT 
);

CREATE TABLE Player (
    player_id 			SERIAL PRIMARY KEY,
    name 				VARCHAR(100) NOT NULL,
    position 			VARCHAR(50) NOT NULL,
    jersey_number 		INT NOT NULL,
    team_id 			INT REFERENCES Team(team_id) ON DELETE CASCADE
);

CREATE TABLE Position (
    position_id 		SERIAL PRIMARY KEY,
    position_name 		VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Stadium (
    stadium_id 			SERIAL PRIMARY KEY,
    name 				VARCHAR(100) NOT NULL,
    city 				VARCHAR(100) NOT NULL,
    capacity 			INT,
    team_id 			INT UNIQUE REFERENCES Team(team_id) ON DELETE SET NULL
);

CREATE TABLE Game (
    game_id 			SERIAL PRIMARY KEY,
    home_team_id 		INT REFERENCES Team(team_id),
    away_team_id 		INT REFERENCES Team(team_id),
    game_date 			DATE NOT NULL,
    stadium_id 			INT REFERENCES Stadium(stadium_id)
);
