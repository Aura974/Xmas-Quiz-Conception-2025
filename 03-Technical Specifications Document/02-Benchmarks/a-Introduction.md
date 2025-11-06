# Introduction

Cette section présente la **méthodologie d’analyse** utilisée pour évaluer et sélectionner la **stack technologique** la plus adaptée au projet **Quiz de Noël**.
Elle repose sur une **approche comparative structurée**, visant à identifier les technologies offrant le meilleur équilibre entre **simplicité, fiabilité, accessibilité et sécurité**, dans un **contexte de développement individuel** et une **infrastructure interne**.

L’objectif est de garantir des **choix cohérents, justifiés et traçables**, en tenant compte :

* du **caractère éducatif et festif** de l’application,
* du **public jeune** et des impératifs d’accessibilité,
* des **contraintes techniques** liées à un usage intranet (sécurité, maintenance, performances suffisantes),
* et du **calendrier court** (livraison d’un MVP en un mois).

Chaque technologie envisagée sera évaluée selon une **grille de critères** notés de **1 à 5**, où :

* **1** correspond à une inadéquation marquée ou un frein significatif,
* **3** à une conformité correcte mais perfectible,
* **5** à une excellente adéquation au besoin et au contexte du projet.

---

## **Critères d’évaluation**

| **Catégorie**                   | **Critère**                                | **Description / Objectif**                                                                 |
| ------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------------ |
| **Cohérence projet**            | Adéquation au périmètre fonctionnel        | Compatibilité avec les besoins du CdCF : quiz à 10 questions, score, chrono, classement.   |
|                                 | Courbe d’apprentissage / complexité        | Facilité d’usage dans un contexte de développement solo avec délai court.                  |
| **Maintenabilité et structure** | Lisibilité / modularité du code            | Clarté de l’architecture, séparation logique (front/back, API, données).                   |
|                                 | Écosystème et documentation                | Qualité du support, communauté active, ressources à jour.                                  |
| **Performance et fiabilité**    | Temps de réponse / fluidité                | Rapidité des interactions quiz–API–classement, stabilité du système.                       |
|                                 | Robustesse / tolérance aux erreurs         | Capacité à éviter les crashs ou blocages pendant le jeu.                                   |
| **Évolutivité**                 | Facilité d’ajout de contenu                | Possibilité d’intégrer facilement de nouvelles questions ou modes.                         |
|                                 | Adaptabilité du déploiement                | Simplicité de mise à jour et compatibilité avec une infra standard (Docker + VPS interne). |
| **Sécurité et conformité**      | Validation et protection des données       | Respect du RGPD, absence de stockage nominatif, filtrage pseudo, sécurisation des flux.    |
| **Coût et contraintes**         | Licence et dépendances                     | Utilisation libre, sans coût de licence ni dépendance commerciale.                         |
|                                 | Légèreté et compatibilité environnementale | Exigences matérielles faibles, compatibilité navigateur et réseau interne.                 |

Chaque benchmark (Back-end, Base de données, ORM, Front-end) sera donc présenté sous le même format :

1. **Présentation des options candidates**
2. **Notation selon la grille ci-dessus**
3. **Analyse qualitative** pour chaque critère
4. **Synthèse comparative** et **choix recommandé**

---
