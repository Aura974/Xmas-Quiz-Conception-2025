# RBAC

## Objectif

Définir les **rôles applicatifs** et les **permissions associées** au sein de l’environnement du projet **Quiz de Noël**, afin de garantir la cohérence des accès et la séparation des responsabilités, même dans un cadre à effectif réduit.

Le système ne comprend **aucune authentification utilisateur** en front, mais distingue **trois niveaux de rôle techniques ou fonctionnels** au sein du projet.

---

| **Action / Ressource**                                                     | **Joueur (enfant)** | **Encadrant / Parent** |  **Développeur / Administrateur**  |
| :------------------------------------------------------------------------- | :-----------------: | :--------------------: | :--------------------------------: |
| **Accéder à l’application (UI)**                                           |          ✅          |            ✅           |                  ✅                 |
| **Jouer au quiz (répondre aux questions)**                                 |          ✅          |  ✅ *(accompagnement)*  |             ✅ *(test)*             |
| **Saisir un pseudo et soumettre un score**                                 |          ✅          | ✅ *(aide à la saisie)* |         ✅ *(test / debug)*         |
| **Consulter le classement Points / Temps**                                 |          ✅          |            ✅           |                  ✅                 |
| **Relancer une partie (Rejouer)**                                          |          ✅          |            ✅           |                  ✅                 |
| **Modifier ou supprimer un score**                                         |          ❌          |            ❌           |                  ✅                 |
| **Réinitialiser le classement journalier (00:00 UTC+4)**                   |          ❌          |            ❌           | ✅ *(automatisé / tâche planifiée)* |
| **Accéder à la base de données (PostgreSQL)**                              |          ❌          |            ❌           |                  ✅                 |
| **Accéder à l’administration Django**                                      |          ❌          |            ❌           |                  ✅                 |
| **Modifier les fichiers de configuration (settings, sécurité, CSP, etc.)** |          ❌          |            ❌           |                  ✅                 |
| **Visualiser les logs / diagnostics**                                      |          ❌          |            ❌           |                  ✅                 |
| **Déployer ou mettre à jour l’application**                                |          ❌          |            ❌           |                  ✅                 |
| **Gérer les images, sons et assets du quiz**                               |          ❌          |            ❌           |                  ✅                 |
| **Accéder aux analytics Matomo (anonymisés)**                              |          ❌          |            ❌           |         ✅ *(lecture seule)*        |

---

## Synthèse

* **Joueur (enfant)** : rôle public sans authentification, accès uniquement au **front-end** (jeu et classement).
* **Encadrant / Parent** : accès identique au joueur, mais agit comme **superviseur** (aucune permission technique).
* **Développeur / Administrateur** : accès complet au **back-end**, à la **base de données**, aux **paramètres du serveur** et à la **supervision**.

Toutes les actions critiques (modifications, réinitialisations, accès logs) sont **limitées au développeur** via **authentification système** et **droits restreints sur le serveur**.

---
