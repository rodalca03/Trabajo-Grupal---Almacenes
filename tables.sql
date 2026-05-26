-- Table: alltime_standing_entries
-- CREATE TABLE "alltime_standing_entries" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "alltime_standing_id" integer NOT NULL, "team_id" integer NOT NULL, "pos" integer, "played" integer, "won" integer, "lost" integer, "drawn" integer, "goals_for" integer, "goals_against" integer, "pts" integer, "recs" integer, "comments" varchar(50), "created_at" datetime, "updated_at" datetime);

-- Table: alltime_standings
--CREATE TABLE "alltime_standings" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Tabl: assocs
CREATE TABLE "assocs" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL, "since" integer, "web" varchar(50), "country_id" integer, "national" bit DEFAULT 0 NOT NULL, "continental" bit DEFAULT 0 NOT NULL, "intercontinental" bit DEFAULT 0 NOT NULL);

-- Table: assocs_assocs
--CREATE TABLE "assocs_assocs" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "assoc1_id" integer NOT NULL, "assoc2_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: badges
-- CREATE TABLE "badges" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "team_id" integer NOT NULL, "league_id" integer NOT NULL, "season_id" integer NOT NULL, "title" varchar(50) NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: places
-- CREATE TABLE "places" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "kind" varchar(50) NOT NULL, "lat" float, "lng" float, "created_at" datetime, "updated_at" datetime);

-- Table: continents
CREATE TABLE "continents" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "slug" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "alt_names" varchar(50));

-- Table: countries
CREATE TABLE "countries" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "slug" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "code" varchar(50) NOT NULL, "alt_names" varchar(50), "hist_names" varchar(50), "pop" integer NOT NULL, "area" integer NOT NULL, "continent_id" integer FOREIGN KEY REFERENCES continents(id), "country_id" integer FOREIGN KEY REFERENCES countries(id), "s" bit DEFAULT 0 NOT NULL, "c" bit DEFAULT 0 NOT NULL, "d" bit DEFAULT 0 NOT NULL, "m" bit DEFAULT 0 NOT NULL, "motor" varchar(50), "alpha2" varchar(50), "alpha3" varchar(50), "num" varchar(50), "fifa" varchar(50), "ioc" varchar(50), "fips" varchar(50), "net" varchar(50), "wikipedia" varchar(50));

-- Table: states
CREATE TABLE "states" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "code" varchar(50), "abbr" varchar(50), "iso" varchar(50), "nuts" varchar(50), "alt_names" varchar(50), "country_id" integer NOT NULL FOREIGN KEY REFERENCES countries(id), "level" integer DEFAULT 1 NOT NULL, "pop" integer, "area" integer);

-- Table: cities
CREATE TABLE "cities" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "code" varchar(50), "alt_names" varchar(50), "country_id" integer NOT NULL FOREIGN KEY REFERENCES countries(id), "state_id" integer FOREIGN KEY REFERENCES states(id), "part_id" integer, "county_id" integer, "muni_id" integer, "metro_id" integer, "pop" integer, "area" integer);


-- Table: counties
-- CREATE TABLE "counties" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "place_id" integer NOT NULL, "code" varchar(50), "abbr" varchar(50), "iso" varchar(50), "nuts" varchar(50), "alt_names" varchar(50), "state_id" integer NOT NULL, "part_id" integer, "level" integer DEFAULT 2 NOT NULL, "pop" integer, "area" integer, "created_at" datetime, "updated_at" datetime);


-- Table: country_codes
-- CREATE TABLE "country_codes" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "kind" varchar(50) NOT NULL, "country_id" integer NOT NULL);

-- Table: districts
-- CREATE TABLE "districts" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "place_id" integer NOT NULL, "code" varchar(50), "alt_names" varchar(50), "city_id" integer NOT NULL, "pop" integer, "area" integer, "created_at" datetime, "updated_at" datetime);

-- Table: event_standing_entries
-- CREATE TABLE "event_standing_entries" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_standing_id" integer NOT NULL, "team_id" integer NOT NULL, "pos" integer, "played" integer, "won" integer, "lost" integer, "drawn" integer, "goals_for" integer, "goals_against" integer, "pts" integer, "comments" varchar(50), "created_at" datetime, "updated_at" datetime);

-- Table: event_standings
-- CREATE TABLE "event_standings" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: seasons
CREATE TABLE "seasons" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL);

-- Table: teams
CREATE TABLE "teams" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL, "title2" varchar(50), "code" varchar(50), "synonyms" varchar(256), "country_id" integer NOT NULL FOREIGN KEY REFERENCES countries(id), "city_id" integer FOREIGN KEY REFERENCES cities(id), "club" bit DEFAULT 0 NOT NULL, "since" integer, "address" varchar(50), "web" varchar(50), "assoc_id" integer FOREIGN KEY REFERENCES assocs(id), "national" bit DEFAULT 0 NOT NULL);

-- Table: leagues
CREATE TABLE "leagues" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL, "country_id" integer NOT NULL FOREIGN KEY REFERENCES countries(id), "club" bit DEFAULT 0 NOT NULL);

-- Table: events
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "league_id" integer NOT NULL FOREIGN KEY REFERENCES leagues(id), "season_id" integer NOT NULL FOREIGN KEY REFERENCES seasons(id), "start_at" date NOT NULL, "end_at" date, "team3" bit DEFAULT 1 NOT NULL, "sources" varchar(50), "config" varchar(50));

-- Table: events_grounds
-- CREATE TABLE "events_grounds" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_id" integer NOT NULL, "ground_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: events_teams
CREATE TABLE "events_teams" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_id" integer NOT NULL FOREIGN KEY REFERENCES events(id), "team_id" integer NOT NULL FOREIGN KEY REFERENCES teams(id));

-- Table: rounds
CREATE TABLE "rounds" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_id" integer NOT NULL FOREIGN KEY REFERENCES events(id), "title" varchar(50) NOT NULL, "title2" varchar(50), "pos" integer NOT NULL, "knockout" bit DEFAULT 0 NOT NULL, "start_at" date NOT NULL, "end_at" date, "auto" bit DEFAULT 1 NOT NULL);

-- Table: grounds
 CREATE TABLE "grounds" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "title" varchar(50) NOT NULL, "synonyms" varchar(50), "country_id" integer NOT NULL FOREIGN KEY REFERENCES countries(id), "city_id" integer FOREIGN KEY REFERENCES cities(id), "since" integer, "capacity" integer, "address" varchar(50));

 -- Table: groups
 CREATE TABLE "groups" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "event_id" integer NOT NULL FOREIGN KEY REFERENCES events(id), "title" varchar(50) NOT NULL, "pos" integer NOT NULL);

-- Table: games
CREATE TABLE "games" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50), "round_id" integer NOT NULL FOREIGN KEY REFERENCES rounds(id), "pos" integer NOT NULL, "group_id" integer FOREIGN KEY REFERENCES groups(id), "team1_id" integer NOT NULL FOREIGN KEY REFERENCES teams(id), "team2_id" integer NOT NULL FOREIGN KEY REFERENCES teams(id), "play_at" datetime NOT NULL, "postponed" bit DEFAULT 0 NOT NULL, "play_at_v2" datetime, "play_at_v3" datetime, "ground_id" integer FOREIGN KEY REFERENCES grounds(id), "city_id" integer FOREIGN KEY REFERENCES cities(id), "knockout" bit DEFAULT 0 NOT NULL, "home" bit DEFAULT 1 NOT NULL, "score1" integer, "score2" integer, "score1et" integer, "score2et" integer, "score1p" integer, "score2p" integer, "score1i" integer, "score2i" integer, "score1ii" integer, "score2ii" integer, "next_game_id" integer FOREIGN KEY REFERENCES games(id), "prev_game_id" integer FOREIGN KEY REFERENCES games(id), "winner" integer, "winner90" integer);

-- Table: goals
-- CREATE TABLE "goals" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "person_id" integer NOT NULL, "game_id" integer NOT NULL, "team_id" integer NOT NULL, "minute" integer, "offset" integer DEFAULT 0 NOT NULL, "score1" integer, "score2" integer, "penalty" bit DEFAULT 0 NOT NULL, "owngoal" bit DEFAULT 0 NOT NULL, "created_at" datetime, "updated_at" datetime);


-- Table: group_standing_entries
-- CREATE TABLE "group_standing_entries" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "group_standing_id" integer NOT NULL, "team_id" integer NOT NULL, "pos" integer, "played" integer, "won" integer, "lost" integer, "drawn" integer, "goals_for" integer, "goals_against" integer, "pts" integer, "comments" varchar(50), "created_at" datetime, "updated_at" datetime);

-- Table: group_standings
-- CREATE TABLE "group_standings" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "group_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);


-- Table: groups_teams
-- CREATE TABLE "groups_teams" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "group_id" integer NOT NULL, "team_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: langs
-- CREATE TABLE "langs" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "name" varchar(50) NOT NULL, "created_at" datetime, "updated_at" datetime);


-- Table: logs
-- CREATE TABLE "logs" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "msg" varchar(50) NOT NULL, "level" varchar(50) NOT NULL, "app" varchar(50), "tag" varchar(50), "pid" integer, "tid" integer, "ts" varchar(50), "created_at" datetime, "updated_at" datetime);

-- Table: metros
-- CREATE TABLE "metros" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "place_id" integer NOT NULL, "code" varchar(50), "alt_names" varchar(50), "country_id" integer NOT NULL, "pop" integer, "area" integer, "created_at" datetime, "updated_at" datetime);

-- Table: munis
-- CREATE TABLE "munis" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "place_id" integer NOT NULL, "code" varchar(50), "abbr" varchar(50), "iso" varchar(50), "nuts" varchar(50), "alt_names" varchar(50), "state_id" integer NOT NULL, "county_id" integer, "level" integer DEFAULT 3 NOT NULL, "pop" integer, "area" integer, "created_at" datetime, "updated_at" datetime);

-- Table: names
-- CREATE TABLE "names" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "place_id" integer NOT NULL FOREIGN KEY REFERENCES places(id), "place_kind" varchar(50) NOT NULL, "lang" varchar(50) DEFAULT 'en' NOT NULL);

-- Table: parts
-- CREATE TABLE "parts" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "name" varchar(50) NOT NULL, "key" varchar(50) NOT NULL, "place_id" integer NOT NULL, "code" varchar(50), "abbr" varchar(50), "iso" varchar(50), "nuts" varchar(50), "alt_names" varchar(50), "state_id" integer NOT NULL, "level" integer DEFAULT 2 NOT NULL, "pop" integer, "area" integer, "created_at" datetime, "updated_at" datetime);

-- Table: persons
-- CREATE TABLE "persons" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "name" varchar(50) NOT NULL, "synonyms" varchar(50), "code" varchar(50), "born_at" date, "city_id" integer, "state_id" integer, "country_id" integer, "nationality_id" integer, "created_at" datetime, "updated_at" datetime);

-- Table: props
-- CREATE TABLE "props" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "value" varchar(50) NOT NULL, "kind" varchar(50));

-- Table: rosters
-- CREATE TABLE "rosters" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "person_id" integer NOT NULL, "team_id" integer NOT NULL, "event_id" integer, "pos" integer NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: taggings
-- CREATE TABLE "taggings" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "tag_id" integer NOT NULL, "taggable_id" integer NOT NULL, "taggable_type" varchar(50) NOT NULL, "created_at" datetime, "updated_at" datetime);

-- Table: tags
-- CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "key" varchar(50) NOT NULL, "slug" varchar(50) NOT NULL, "name" varchar(50), "grade" integer DEFAULT 1 NOT NULL, "parent_id" integer, "created_at" datetime, "updated_at" datetime);


-- Table: usages
-- CREATE TABLE "usages" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL, "country_id" integer NOT NULL, "lang_id" integer NOT NULL, "official" bit DEFAULT 1 NOT NULL, "minor" bit DEFAULT 0 NOT NULL, "percent" float, "created_at" datetime, "updated_at" datetime);

-- Table: zones
-- CREATE TABLE "zones" ("id" INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL);
