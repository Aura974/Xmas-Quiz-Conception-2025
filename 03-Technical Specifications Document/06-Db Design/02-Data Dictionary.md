# DATA DICTIONARY

## Table `day`

| Champ       | Type SQL | Null | Défaut | Clé/Contrainte | Description                                                                |
| :---------- | :------- | :--: | :----- | :------------- | :------------------------------------------------------------------------- |
| `day_date` | `DATE`   |   ✗  | —      | **PK**         | Jour calendaire de référence pour les classements et la purge quotidienne. |

---

## Table `game`

| Champ         | Type SQL               | Null | Défaut  | Clé/Contrainte                                                               | Description                                                                      |
| :------------ | :--------------------- | :--: | :------ | :--------------------------------------------------------------------------- | :------------------------------------------------------------------------------- |
| `game_id`   | `BIGSERIAL`            |   ✗  | auto    | **PK**                                                                       | Identifiant technique de la partie (auto-incr.).                                 |
| `nickname`      | `VARCHAR(12)`          |   ✗  | —       | **UNIQUE** avec `day_date`                                                  | Pseudo saisi (non nominatif). Validation applicative (regex `[a-z0-9_-]{3,12}`). |
| `level`      | `level-type` *(ENUM)* |   ✗  | —       | **CHECK** implicite par type                                                 | Niveau de difficulté. Valeurs : `facile`, `intermédiaire`, `avancé`.             |
| `points`      | `SMALLINT`             |   ✗  | —       | `CHECK (points BETWEEN 0 AND 10)`                                            | Nombre de bonnes réponses (0..10).                                               |
| `total_time` | `INTEGER`              |   ✗  | —       | `CHECK (total_time > 0)`                                                    | Temps total de la partie en secondes.                                            |
| `created_at`  | `TIMESTAMPTZ`          |   ✗  | `NOW()` | —                                                                            | Horodatage d’insertion (UTC).                                                    |
| `day_date`   | `DATE`                 |   ✗  | —       | **FK** → `day(day_date)` (**ON DELETE CASCADE**), **UNIQUE** avec `nickname` | Jour auquel est rattachée la partie (clé logique de classement/purge).           |

### Contraintes & index associés

* **Contraintes**

  * `PK(day.day_date)`
  * `PK(game.game_id)`
  * `FK(game.day_date) → day(day_date) ON DELETE CASCADE`
  * `UNIQUE(game.nickname, game.day_date)`
  * `CHECK(game.points BETWEEN 0 AND 10)`
  * `CHECK(game.total_time > 0)`
  * `level-type` = `ENUM('facile','intermédiaire','avancé')`

* **Index (performance classements)**
  *(non uniques)*

  * `idx_game_ranking_points (day_date, points, total_time, nickname)`
  * `idx_game_ranking_time  (day_date, total_time, points, nickname)`

---
