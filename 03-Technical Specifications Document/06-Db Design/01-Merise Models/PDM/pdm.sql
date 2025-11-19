-- Type ENUM (créé une seule fois si absent)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'level_type') THEN
    CREATE TYPE level_type AS ENUM ('facile', 'intermédiaire', 'avancé');
  END IF;
END$$;

-- Table DAY
CREATE TABLE IF NOT EXISTS day(
  day_date DATE PRIMARY KEY
);

-- Table GAME
CREATE TABLE IF NOT EXISTS game(
  game_id     BIGSERIAL    PRIMARY KEY,
  nickname    VARCHAR(12)  NOT NULL,
  level       level_type  NOT NULL,
  points      SMALLINT     NOT NULL CHECK(points BETWEEN 0 AND 10),
  total_time  INTEGER      NOT NULL CHECK(total_time > 0),
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  day_date    DATE         NOT NULL,
  CONSTRAINT uq_game_nickname_day UNIQUE (nickname, day_date),
  CONSTRAINT fk_day_game FOREIGN KEY(day_date)
    REFERENCES day(day_date) ON DELETE CASCADE
);

-- Index non uniques pour accélérer les classements
CREATE INDEX IF NOT EXISTS idx_game_ranking_points
  ON game (day_date, points, total_time, nickname);

CREATE INDEX IF NOT EXISTS idx_game_ranking_time
  ON game (day_date, total_time, points, nickname);
