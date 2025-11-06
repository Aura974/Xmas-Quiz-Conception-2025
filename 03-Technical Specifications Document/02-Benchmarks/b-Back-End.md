# BACK-END

## Introduction

Trois technologies ont été retenues pour l’analyse du back-end, en raison de leur maturité, de leur compatibilité avec une architecture web classique et de leur adoption dans des projets éducatifs ou ludiques similaires :

| **Technologie**               | **Description synthétique**                                                                                                                               |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Django (Python)**           | Framework web complet, “batteries incluses”, offrant ORM, routage, gestion de sécurité et intégration native d’API via Django REST Framework (DRF).       |
| **FastAPI (Python)**          | Framework asynchrone moderne, basé sur Starlette et Pydantic, optimisé pour la rapidité d’exécution et la définition d’API légères et typées.             |
| **Node.js (Express/Fastify)** | Environnement JavaScript côté serveur, orienté événements, très flexible, souvent choisi pour des API REST simples ou des jeux interactifs en temps réel. |

---

## Évaluation chiffrée (notation sur 5)

| **Critère**                                    | **Django** | **FastAPI** | **Node.js (Fastify)** |
| :--------------------------------------------- | :--------: | :---------: | :-------------------: |
| **Adéquation au périmètre fonctionnel**        |      5     |      4      |           3           |
| **Courbe d’apprentissage / complexité**        |      5     |      4      |           3           |
| **Lisibilité / modularité du code**            |      5     |      4      |           3           |
| **Écosystème et documentation**                |      5     |      4      |           5           |
| **Temps de réponse / fluidité**                |      4     |      5      |           5           |
| **Robustesse / tolérance aux erreurs**         |      5     |      4      |           3           |
| **Facilité d’ajout de contenu**                |      5     |      5      |           4           |
| **Adaptabilité du déploiement**                |      5     |      5      |           4           |
| **Validation et sécurité intégrée**            |      5     |      4      |           3           |
| **Licence / dépendances / coût**               |      5     |      5      |           5           |
| **Légèreté et compatibilité environnementale** |      4     |      5      |           5           |

**Moyenne pondérée :**

* **Django** → **4.8 / 5**
* **FastAPI** → **4.4 / 5**
* **Node.js (Fastify)** → **4.0 / 5**

---

## Analyse qualitative

### 🔹 Django (Python)

* Excellente couverture fonctionnelle : authentification, ORM, validations, throttling, gestion d’erreurs et de sécurité intégrées.
* Très adapté à un **développement individuel rapide**, grâce à son outillage complet et à la stabilité de l’écosystème.
* L’intégration de **Django REST Framework (DRF)** permet de bâtir une API propre, sérialisée et sécurisée en peu de temps.
* Légère surcouche en complexité par rapport à FastAPI, mais compensée par la productivité et la cohérence globale.
* Supporte facilement des **tâches planifiées** (purge quotidienne) via management commands ou Celery Beat.

### 🔹 FastAPI (Python)

* Idéal pour des **API REST performantes** et fortement typées.
* Excellente documentation, syntaxe moderne et validation Pydantic très robuste.
* Plus léger que Django, mais nécessite d’ajouter des composants externes pour la gestion des tâches, l’ORM ou la sécurité avancée.
* Moins adapté à un environnement nécessitant une **structure complète et standardisée**, sauf pour un microservice isolé.

### 🔹 Node.js (Fastify)

* Très performant pour des appels fréquents et des opérations non bloquantes.
* Large écosystème, mais souvent plus **verbeux** et moins structuré pour un développeur solo.
* Requiert une gestion manuelle des middlewares de sécurité (helmet, rate-limit, etc.) et des validations.
* Bon choix pour un système plus orienté temps réel, mais **trop souple** pour les besoins cadrés de ce projet.

---

## Synthèse et choix recommandé

| **Option**            | **Avantages clés**                                                                                | **Inconvénients**                           | **Adéquation projet** |
| :-------------------- | :------------------------------------------------------------------------------------------------ | :------------------------------------------ | :-------------------: |
| **Django + DRF**      | Cadre complet, sécurité native, ORM intégré, rapidité de mise en œuvre, tâches planifiées simples | Légère lourdeur initiale                    |    ⭐⭐⭐ **Excellent**    |
| **FastAPI**           | Syntaxe moderne, très performant, asynchrone                                                      | Nécessite plusieurs composants additionnels |         ⭐⭐ Bon        |
| **Node.js (Fastify)** | Rapide, écosystème vaste                                                                          | Moins structuré, sécurité manuelle          |        ⭐ Moyen        |

**➡️ Choix recommandé : [Django + Django REST Framework]**

* Cohérence forte avec les besoins du projet (quiz, classements journaliers, sécurité mineurs).
* Courbe d’apprentissage adaptée à un développement individuel.
* Excellent équilibre entre **simplicité, robustesse et maintenabilité**.
* Support natif des jobs programmés, de la validation et des ORM intégrés (utile pour les benchmarks suivants).

---
