# DATA DICTIONARY

## Table `jour`

| Champ       | Type SQL | Null | Défaut | Clé/Contrainte | Description                                                                |
| :---------- | :------- | :--: | :----- | :------------- | :------------------------------------------------------------------------- |
| `date_jour` | `DATE`   |   ✗  | —      | **PK**         | Jour calendaire de référence pour les classements et la purge quotidienne. |

---

## Table `partie`

| Champ         | Type SQL               | Null | Défaut  | Clé/Contrainte                                                               | Description                                                                      |
| :------------ | :--------------------- | :--: | :------ | :--------------------------------------------------------------------------- | :------------------------------------------------------------------------------- |
| `id_partie`   | `BIGSERIAL`            |   ✗  | auto    | **PK**                                                                       | Identifiant technique de la partie (auto-incr.).                                 |
| `pseudo`      | `VARCHAR(12)`          |   ✗  | —       | **UNIQUE** avec `date_jour`                                                  | Pseudo saisi (non nominatif). Validation applicative (regex `[a-z0-9_-]{3,12}`). |
| `niveau`      | `niveau_type` *(ENUM)* |   ✗  | —       | **CHECK** implicite par type                                                 | Niveau de difficulté. Valeurs : `facile`, `intermediaire`, `avance`.             |
| `points`      | `SMALLINT`             |   ✗  | —       | `CHECK (points BETWEEN 0 AND 10)`                                            | Nombre de bonnes réponses (0..10).                                               |
| `temps_total` | `INTEGER`              |   ✗  | —       | `CHECK (temps_total > 0)`                                                    | Temps total de la partie en secondes.                                            |
| `created_at`  | `TIMESTAMPTZ`          |   ✗  | `NOW()` | —                                                                            | Horodatage d’insertion (UTC).                                                    |
| `date_jour`   | `DATE`                 |   ✗  | —       | **FK** → `jour(date_jour)` (**ON DELETE CASCADE**), **UNIQUE** avec `pseudo` | Jour auquel est rattachée la partie (clé logique de classement/purge).           |

### Contraintes & index associés

* **Contraintes**

  * `PK(jour.date_jour)`
  * `PK(partie.id_partie)`
  * `FK(partie.date_jour) → jour(date_jour) ON DELETE CASCADE`
  * `UNIQUE(partie.pseudo, partie.date_jour)`
  * `CHECK(partie.points BETWEEN 0 AND 10)`
  * `CHECK(partie.temps_total > 0)`
  * `niveau_type` = `ENUM('facile','intermediaire','avance')`

* **Index (performance classements)**
  *(non uniques)*

  * `idx_partie_classement_points (date_jour, points, temps_total, pseudo)`
  * `idx_partie_classement_temps  (date_jour, temps_total, points, pseudo)`

---
