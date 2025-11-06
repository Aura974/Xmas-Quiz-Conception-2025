# FRONT-END

## Introduction

Trois approches ont été considérées pour la couche front-end du projet **Quiz de Noël**, selon leur légèreté, leur simplicité d’intégration avec le back-end Django, et leur adéquation à un environnement intranet destiné à un public jeune.

| **Technologie / Approche**              | **Description synthétique**                                                                                                                                                     |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Django Templates + JavaScript natif** | Rendu côté serveur via le moteur de templates Django, enrichi par du JavaScript pur pour la logique du quiz, le chrono et les animations légères.                               |
| **React (avec Vite)**                   | Framework JavaScript moderne pour SPA (Single Page Application). Permet des composants réactifs et une gestion avancée d’état, mais nécessite un environnement Node.js complet. |
| **Alpine.js / HTMX**                    | Bibliothèques front légères ajoutant de l’interactivité sans framework complet. Utilisent des attributs HTML pour gérer les comportements dynamiques.                           |

---

## Évaluation chiffrée (notation sur 5)

| **Critère**                                    | **Django Templates + JS natif** | **React (Vite)** | **Alpine.js / HTMX** |
| :--------------------------------------------- | :-----------------------------: | :--------------: | :------------------: |
| **Adéquation au périmètre fonctionnel**        |                5                |         3        |           4          |
| **Courbe d’apprentissage / complexité**        |                5                |         3        |           4          |
| **Lisibilité / modularité du code**            |                4                |         5        |           4          |
| **Écosystème et documentation**                |                5                |         5        |           4          |
| **Temps de réponse / fluidité**                |                5                |         5        |           5          |
| **Robustesse / tolérance aux erreurs**         |                5                |         4        |           4          |
| **Facilité d’ajout de contenu**                |                5                |         5        |           4          |
| **Adaptabilité du déploiement**                |                5                |         3        |           5          |
| **Accessibilité et compatibilité navigateurs** |                5                |         4        |           5          |
| **Légèreté / empreinte système**               |                5                |         2        |           5          |

**Moyenne pondérée :**

* **Django Templates + JS natif → 4.9 / 5**
* **Alpine.js / HTMX → 4.4 / 5**
* **React (Vite) → 3.9 / 5**

---

## Analyse qualitative

### 🔹 Django Templates + JavaScript natif

* Solution la plus simple et directe : aucune dépendance externe, ni compilation.
* Parfaitement adaptée à un **projet linéaire et non interactif à grande échelle**.
* S’intègre naturellement au moteur de templates du back-end, garantissant **cohérence et rapidité d’exécution**.
* Excellent pour un usage kiosque (stabilité, absence de navigation externe).

### 🔹 React (Vite)

* Très puissant pour des applications complexes et dynamiques.
* Fournit une **expérience moderne** (routing, composants, hooks) mais nécessite une **infrastructure complète** (Node, bundler, CI/CD).
* Inadapté à un projet interne court, sans multi-écran ni interactions persistantes.

### 🔹 Alpine.js / HTMX

* Bon compromis entre légèreté et dynamisme.
* Permet des interactions sans rechargement complet, sans framework lourd.
* Moins mature que React ou Django templates, et documentation parfois lacunaire.

---

## Synthèse et choix recommandé

| **Option**                      | **Avantages clés**                                                  | **Inconvénients**                        | **Adéquation projet** |
| :------------------------------ | :------------------------------------------------------------------ | :--------------------------------------- | :-------------------: |
| **Django Templates + JS natif** | Simplicité, intégration directe, zéro build, très rapide à déployer | Peu adapté à une évolution future en SPA |    ⭐ **Excellent**    |
| **Alpine.js / HTMX**            | Dynamisme léger, interactivité sans lourdeur                        | Moins documenté, écosystème limité       |         ⭐⭐ Bon        |
| **React (Vite)**                | Interface riche, composants modernes                                | Trop complexe pour un MVP interne        |        ⭐ Moyen        |

**➡️ Choix recommandé : [Django Templates + JavaScript natif]**

* Parfaitement cohérent avec le back-end Django choisi.
* Offre une interface fluide, claire et adaptée aux enfants.
* Permet un **développement rapide, léger et maintenable** dans le cadre du MVP.

---
