# EXHAUSTIVE TOOL LIST

## Développement & poste de travail

| Outil     | Usage     | Remarques     |
| :------------------------ | :----------------------------------------------- | :---------------------------------------------------------------------- |
| **Python 3.14.x**         | Langage principal du projet                      | Version stable et récente, utilisée pour tout le développement.         |
| **pip + venv**            | Gestion des dépendances et environnement virtuel | Environnement isolé pour éviter les conflits entre projets.             |
| **requirements.txt**      | Fichier de dépendances                           | Liste figée des packages avec versions exactes pour reproductibilité.   |
| **Visual Studio Code**    | IDE principal                                    | Développement, tests, debug et intégration avec Docker.                 |
| **Git / GitHub**          | Gestion de version et hébergement du code        | Branches `main` et `feature/*`, versionnage du CdCF et CdCT inclus.     |
| **Black / Flake8**        | Formatage et vérification du code                | Respect des normes PEP8 et cohérence stylistique.                       |
| **Trello**                | Suivi des tâches                                 | Gestion du flux de travail (*À faire → En cours → À tester → Terminé*). |

---

## 5.2 Back-end (API & serveur web)

| Outil     | Usage     | Remarques     |
| :------------------------------- | :------------------------- | :-------------------------------------------------------------- |
| **Django 5.2.8**                 | Framework web principal    | Gère la structure, la logique métier et le rendu des templates. |
| **Django REST Framework 3.16.1** | API REST                   | Sérialisation, validation et endpoints du classement.           |
| **Gunicorn 23.0.0**              | Serveur WSGI de production | Interface entre Nginx et Django pour la gestion des requêtes.   |

---

## 5.3 Front-end (intégré)

| Outil     | Usage     | Remarques     |
| --------------------------- | -------------- | ---------------------------------------- |
| **Django Templates**        | Rendu UI       | Pages Accueil/Quiz/Résultats/Classement. |
| **JavaScript natif (ES6+)** | Logique client | Chrono, transitions, feedback.           |
| **Sass/SCSS (optionnel)**   | Styles         | Compilé en build local si utile.         |

## 5.4 Base de données & accès

| Outil     | Usage     | Remarques     |
| ----------------------- | ------------------ | -------------------------------- |
| **PostgreSQL 16**       | SGBD               | Index, contraintes, perf stable. |
| **psql / pg_dump**      | Admin & sauvegarde | Dump schéma (pas de données).    |
| **pgAdmin (optionnel)** | GUI                | Administration ponctuelle.       |

## 5.5 Conteneurisation & déploiement

| Outil     | Usage     | Remarques     |

| :----------------------------------- | :----------------------------- | :--------------------------------------------------------------------------------------------------------- |
| **Docker** | Conteneurisation des services  | Permet d’isoler les composants (application, base de données, proxy) dans des environnements indépendants. |
| **Docker Compose 2.40.3**            | Orchestration multi-conteneurs | Coordonne le lancement des services `web`, `db` et `nginx`.                                                |
| **Nginx 1.29.3**                     | Reverse proxy et HTTPS         | Gère le chiffrement TLS, les en-têtes de sécurité (CSP, HSTS) et le routage vers Gunicorn.                 |

---

## 5.6 Sécurité (mise en œuvre)

| Outil     | Usage     | Remarques     |
| :----------------------------- | :---------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| **OpenSSL**                    | Génération et gestion des certificats TLS       | Utilisé pour créer des certificats auto-signés ou gérer ceux fournis par l’hébergeur.                |
| **Certbot**                    | Obtention automatique de certificats HTTPS      | Permet de générer et renouveler les certificats Let’s Encrypt sur le serveur public.                 |
| **django-cors-headers**        | Gestion du partage de ressources (CORS)         | Restreint les appels API aux seules origines autorisées (le domaine du jeu).                         |
| **Django Security Middleware** | Sécurisation applicative native                 | Active les en-têtes HTTP de sécurité (CSP, HSTS, Referrer-Policy, X-Frame-Options, etc.).            |
| **pip-audit**                  | Vérification de sécurité des dépendances Python | Analyse les librairies installées et signale les vulnérabilités connues.                             |
| **Fail2ban**                   | Protection réseau active                        | Surveille les logs Nginx et bloque temporairement les IP effectuant des tentatives d’accès abusives. |

---

## 5.7 Observabilité & logs

| Outil     | Usage     | Remarques     |
| :------------------------------- | :--------------------------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| **Système de logs Django**       | Journalisation applicative               | Enregistre les soumissions de scores, erreurs API et tâches planifiées ; rotation automatique via `RotatingFileHandler`. |
| **Nginx access.log / error.log** | Suivi des requêtes HTTP et erreurs proxy | Permet de surveiller le trafic, les statuts de réponse et les erreurs réseau.                                            |
| **Endpoint `/api/health`**       | Supervision technique interne            | Vérifie la disponibilité de l’API et de la base de données.                                                              |

---

## 5.8 Analytics (anonymisés)

| Outil     | Usage     | Remarques     |
| ---------------------- | ------------------ | ----------------------------- |
| **Matomo (optionnel)** | Événements agrégés | Mode sans cookies, anonymisé. |

## 5.9 Qualité & tests

| Outil     | Usage     | Remarques     |
| :-------------------- | :------------------------------- | :---------------------------------------------------------------- |
| **pytest**            | Tests unitaires et d’intégration | Cadre principal de test pour Django et les fonctions internes.    |
| **pytest-django**     | Extension spécifique Django      | Permet la gestion automatique de la base de données de test.      |
| **requests**          | Tests fonctionnels d’API REST    | Simule les appels HTTP pour vérifier les réponses et statuts API. |
| **coverage.py**       | Mesure de couverture du code     | Génère des rapports de couverture (objectif : 80 % minimum).      |

---

## 5.10 Build & CI (optionnel mais recommandé)

| Outil     | Usage     | Remarques     |
| ----------------------------------- | ----------- | ---------------------------- |
| **GitHub Actions** | CI          | Automatise les tests, la vérification du code et la construction du projet à chaque commit. |

## 5.11 Contenus & assets

| Outil     | Usage     | Remarques     |
| ------------------------------ | ------------------- | --------------------------- |
| **JSON**                     | Format de stockage des questions du quiz  | Un fichier par niveau de difficulté, lisible côté back-end et front-end.      |
| **Canva / Photopea / Figma** | Création et retouche des visuels          | Utilisés pour concevoir les images, icônes et éléments graphiques du jeu.     |
| **ImageOptim**               | Optimisation des images avant intégration | Réduit le poids des fichiers PNG/JPEG pour accélérer le chargement des pages. |

---

## 5.12 Documentation & gestion projet

| Outil     | Usage     | Remarques     |
| -------------------- | ------------ | ---------------------------------------- |
| **Markdown**          | Rédaction de la documentation technique      | Utilisé pour le CdCF, le CdCT et les guides internes du projet.                                     |
| **Trello**            | Gestion des tâches et suivi du développement | Organisation du flux de travail selon le modèle Kanban (*À faire → En cours → À tester → Terminé*). |
| **PlantUML**          | Création des diagrammes UML                  | Génération des diagrammes de cas d’utilisation, de séquence, d’activité et de classes.              |
| **Looping**           | Conception des modèles Merise                | Réalisation des MCD, MLD et MPD pour la base de données du projet.                                  |

---
