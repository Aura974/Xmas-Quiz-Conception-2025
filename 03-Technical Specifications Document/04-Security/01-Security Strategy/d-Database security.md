# DATABASE SECURITY

## Objectif

Garantir la **confidentialité, l’intégrité et la résilience** des données stockées dans la base PostgreSQL, tout en respectant le principe de **minimisation** (aucune donnée personnelle durable).

---

## 1. Sécurité d’accès

* La base **n’est jamais exposée publiquement** : écoute uniquement sur le réseau interne (`localhost` ou sous-réseau Docker).
* Authentification forte via **mot de passe** stocké dans une **variable d’environnement** (jamais dans le code).
* Compte PostgreSQL dédié à l’application, avec **droits restreints** (`CONNECT`, `SELECT`, `INSERT`, `DELETE` sur les tables du schéma).
* Accès administrateur réservé au **compte système local** (maintenance et sauvegarde).
* Connexion chiffrée via **SSL/TLS interne** (activé sur le service PostgreSQL).

---

## 2. Structure et intégrité

* Contraintes d’intégrité au niveau SQL :
  * `CHECK` sur les valeurs numériques (`points BETWEEN 0 AND 10`, `temps_total > 0`),
  * `UNIQUE (pseudo, date_jour)` pour garantir l’unicité des entrées quotidiennes,
  * `NOT NULL` sur tous les champs critiques.
* **Transactions atomiques** : chaque insertion de score est validée ou annulée dans son intégralité.
* **Rollback automatique** en cas d’erreur d’intégrité ou de validation.
* Index optimisés sur les colonnes `date_jour`, `points`, `temps_total` pour des tris rapides dans le classement.

---

## 3. Sécurité des données

* Données **volatiles** : réinitialisation automatique à 00:00 UTC+4 via tâche planifiée (cron/Celery Beat).
* Sauvegardes structurelles uniquement (dump du schéma, pas des scores).
* Fichiers de sauvegarde stockés **hors répertoire web**, chiffrés AES256.
* Logs PostgreSQL purgés après 7 jours.
* Pas d’export ni de réplication externe.

---

## 4. Résilience et supervision

* Vérification quotidienne de la **connectivité** et de la **disponibilité** via endpoint `/api/health`.
* Reconnexion automatique de l’ORM Django en cas de perte de lien DB.
* **Analyse périodique** (`VACUUM`, `ANALYZE`) intégrée dans la tâche planifiée pour conserver des performances constantes.
* En cas d’incident ou de crash, la base peut être **reconstruite automatiquement** depuis les migrations Django.

---

## 5. Conformité

* Aucune **PII** ni donnée persistante : pseudonymes temporaires, purgés chaque jour.
* Respect des principes **RGPD** : minimisation, finalité unique, durée limitée, sécurité du stockage.
* Objectif conforme à la **CNIL – donnée non personnelle**, car aucune corrélation possible avec une identité réelle.

---

## Résultat attendu

* Base **isolée, minimale et auto-entretenue**.
* Données cohérentes, valides et supprimées automatiquement chaque jour.
* Sécurité garantie par la combinaison **droits restreints + chiffrement + purge planifiée**.

---
