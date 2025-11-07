CREATE TABLE jour(
   date_jour DATE,
   PRIMARY KEY(date_jour)
);

-- Assure-toi d’avoir créé le type ENUM niveau_type avant, ou remplace-le par VARCHAR + CHECK
-- CREATE TYPE niveau_type AS ENUM ('facile','intermediaire','avance');

CREATE TABLE partie(
   id_partie   BIGSERIAL,
   pseudo      VARCHAR(12)  NOT NULL,
   niveau      niveau_type  NOT NULL,
   points      SMALLINT     NOT NULL CHECK(points BETWEEN 0 AND 10),
   temps_total INTEGER      NOT NULL CHECK(temps_total > 0),
   created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
   date_jour   DATE         NOT NULL,
   PRIMARY KEY(id_partie),
   UNIQUE(pseudo, date_jour),
   FOREIGN KEY(date_jour) REFERENCES jour(date_jour) ON DELETE CASCADE
);

-- Index pour les classements (NON-UNIQUES, sans ASC/DESC pour compat max)
CREATE INDEX idx_partie_classement_points
  ON partie (date_jour, points, temps_total, pseudo);

CREATE INDEX idx_partie_classement_temps
  ON partie (date_jour, temps_total, points, pseudo);
