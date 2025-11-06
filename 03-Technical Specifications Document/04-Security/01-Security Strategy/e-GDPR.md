# GDRP

## Objectif

Assurer la **conformité au Règlement Général sur la Protection des Données (RGPD)**, tout en reconnaissant que l’application **Quiz de Noël** ne collecte **aucune donnée à caractère personnel** au sens strict, mais met tout de même en œuvre les **principes de protection des données**.

---

## 1. Applicabilité du RGPD

Le RGPD s’applique à tout traitement de données permettant d’identifier, directement ou indirectement, une personne physique.
Dans le cadre du projet :

* Seule une **chaîne de caractères “pseudo”** est collectée, sans lien avec une identité réelle.
* Les données (pseudo, score, temps) sont **anonymes**, **non corrélées**, et **supprimées automatiquement chaque jour**.
* Aucun cookie, identifiant, adresse IP, ni traceur n’est conservé.

➡️ Le projet relève donc **du champ du RGPD**, mais **sans constituer un traitement de données personnelles identifiable**.

---

## 2. Principes appliqués

| **Principe RGPD**                | **Mise en œuvre dans le projet**                                                                                  |
| :------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| **Licéité / Finalité**           | Le traitement est limité à la gestion du classement du quiz, dans un but ludique et éducatif interne à la Nordev. |
| **Minimisation**                 | Aucune donnée nominative collectée. Seul le pseudo (non identifiable) est utilisé et purgé quotidiennement.       |
| **Exactitude**                   | Les données sont générées par l’utilisateur et validées en temps réel ; aucune erreur persistante possible.       |
| **Limitation de conservation**   | Données effacées chaque jour à 00:00 (UTC+4) ; réinitialisation automatique via tâche planifiée.                  |
| **Intégrité et confidentialité** | Chiffrement TLS, accès restreint à la base, logs sans IP, authentification DB sécurisée.                          |
| **Transparence**                 | Mention explicite dans la documentation interne indiquant que le jeu ne stocke aucune donnée personnelle.         |

---

## 3. Données et durée de vie

| **Type de donnée**               | **Description**                                       | **Durée de conservation** | **Justification**                  |
| :------------------------------- | :---------------------------------------------------- | :-----------------------: | :--------------------------------- |
| `pseudo`                         | Identifiant libre choisi par l’enfant (non nominatif) |           1 jour          | Affichage du classement journalier |
| `score`, `temps_total`, `niveau` | Données de jeu anonymes                               |           1 jour          | Calcul des classements             |
| `date_jour`                      | Clé logique pour le reset quotidien                   |           1 jour          | Gestion de la purge automatique    |

Aucune donnée n’est exportée, transférée ou utilisée à d’autres fins.
Les **logs et statistiques Matomo** sont **anonymisés**, **non corrélables** et **non conservés au-delà de la période d’évaluation interne**.

---

## 4. Résultat attendu

* Application **techniquement conforme** au RGPD par **principe de minimisation**.
* **Aucune donnée personnelle identifiable** traitée ni conservée.
* Protection complète des utilisateurs mineurs par **anonymisation, purge quotidienne et cloisonnement du système**.

---
