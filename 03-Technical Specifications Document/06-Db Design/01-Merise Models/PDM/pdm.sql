-- Type ENUM (créé une seule fois si absent)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'niveau_type') THEN
    CREATE TYPE niveau_type AS ENUM ('facile', 'intermediaire', 'avance');
  END IF;
END$$;

-- Table JOUR
CREATE TABLE IF NOT EXISTS jour(
  date_jour DATE PRIMARY KEY
);

-- Table PARTIE
CREATE TABLE IF NOT EXISTS partie(
  id_partie   BIGSERIAL    PRIMARY KEY,
  pseudo      VARCHAR(12)  NOT NULL,
  niveau      niveau_type  NOT NULL,
  points      SMALLINT     NOT NULL CHECK(points BETWEEN 0 AND 10),
  temps_total INTEGER      NOT NULL CHECK(temps_total > 0),
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  date_jour   DATE         NOT NULL,
  CONSTRAINT uq_partie_pseudo_jour UNIQUE (pseudo, date_jour),
  CONSTRAINT fk_partie_jour FOREIGN KEY(date_jour)
    REFERENCES jour(date_jour) ON DELETE CASCADE
);

-- Index non uniques pour accélérer les classements
CREATE INDEX IF NOT EXISTS idx_partie_classement_points
  ON partie (date_jour, points, temps_total, pseudo);

CREATE INDEX IF NOT EXISTS idx_partie_classement_temps
  ON partie (date_jour, temps_total, points, pseudo);
