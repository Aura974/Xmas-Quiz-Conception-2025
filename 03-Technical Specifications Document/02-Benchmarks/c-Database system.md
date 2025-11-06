# DATABASE SYSTEM

## Introduction

Trois systèmes de gestion de base de données (SGBD) ont été étudiés pour le projet **Quiz de Noël**, en fonction de leurs caractéristiques, de leur intégration avec les frameworks envisagés, et de leur pertinence dans un **environnement web interne à faible charge**.

| **Technologie**     | **Description synthétique**                                                                                                                                              |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **PostgreSQL**      | SGBD relationnel open-source avancé, robuste et complet, compatible avec Django et FastAPI via de nombreux ORM. Excellente fiabilité et support des fonctions complexes. |
| **SQLite**          | Base de données embarquée légère, sans serveur, parfaitement adaptée aux applications locales ou prototypes rapides.                                                     |
| **MySQL / MariaDB** | SGBD relationnel largement diffusé, performant, mais moins flexible sur certains types de données et contraintes avancées.                                               |

---

## Évaluation chiffrée (notation sur 5)

| **Critère**                             | **PostgreSQL** | **SQLite** | **MySQL / MariaDB** |
| :-------------------------------------- | :------------: | :--------: | :-----------------: |
| **Adéquation au périmètre fonctionnel** |        5       |      4     |          4          |
| **Courbe d’apprentissage / complexité** |        4       |      5     |          4          |
| **Intégration avec frameworks Python**  |        5       |      5     |          4          |
| **Fiabilité et robustesse**             |        5       |      3     |          4          |
| **Gestion du reset quotidien (tâches)** |        5       |      3     |          4          |
| **Performance / stabilité**             |        5       |      4     |          5          |
| **Maintenance et monitoring**           |        5       |      3     |          4          |
| **Sécurité et conformité RGPD**         |        5       |      4     |          4          |
| **Licence / coût / disponibilité**      |        5       |      5     |          5          |
| **Évolutivité et portabilité**          |        5       |      3     |          4          |

**Moyenne pondérée :**

* **PostgreSQL → 4.9 / 5**
* **SQLite → 3.9 / 5**
* **MySQL / MariaDB → 4.2 / 5**

---

## Analyse qualitative

### 🔹 PostgreSQL

* Offre une **stabilité exemplaire** et un excellent support pour les opérations transactionnelles.
* Compatible nativement avec **Django ORM**, **SQLAlchemy** et d’autres outils Python.
* Supporte facilement les **tâches planifiées**, les **index composites** (ex. pseudo + date du jour), et la **purge quotidienne**.
* Dispose d’un écosystème mature pour le **monitoring** et la **sauvegarde** (pgAdmin, extensions).
* Léger sur VPS, et idéal pour un **usage interne** à charge modérée.

### 🔹 SQLite

* Extrêmement simple et rapide à mettre en place.
* Convient bien pour le **prototypage** ou les tests unitaires.
* Ses limites : pas de **multi-utilisateur concurrent** efficace et difficulté à gérer un **reset quotidien automatisé** sans verrouillage.
* Risque d’instabilité si l’application grandit ou si plusieurs instances (totems) écrivent simultanément.

### 🔹 MySQL / MariaDB

* Solution éprouvée, mais légèrement **moins souple** sur les contraintes complexes et les index composites.
* Moins bien intégrée dans l’écosystème **Django moderne** (certaines optimisations spécifiques à PostgreSQL non disponibles).
* Nécessite davantage de configuration pour la **sécurité et la conformité** RGPD.
* Restent des options fiables pour hébergements classiques.

---

## Synthèse et choix recommandé

| **Option**          | **Avantages clés**                                                                      | **Inconvénients**                                          | **Adéquation projet** |
| :------------------ | :-------------------------------------------------------------------------------------- | :--------------------------------------------------------- | :-------------------: |
| **PostgreSQL**      | Fiabilité, robustesse, compatibilité Django, gestion facile du reset, sécurité intégrée | Légèrement plus lourd à installer                          |    ⭐ **Excellent**    |
| **SQLite**          | Simplicité, légèreté, zéro maintenance                                                  | Mauvaise tolérance au multi-accès, difficile à automatiser |      ⭐⭐ Prototype     |
| **MySQL / MariaDB** | Performances stables, bonne diffusion                                                   | Moins adapté à Django et contraintes spécifiques           |       ⭐⭐ Correct      |

**➡️ Choix recommandé : [PostgreSQL]**

* Parfait équilibre entre **robustesse, sécurité et compatibilité Django**.
* Supporte aisément la **purge quotidienne automatisée**, les **index par jour** et la **concurrence** modérée attendue.
* Solution durable, conforme à un **usage professionnel interne** sans surcoût de licence.

---
