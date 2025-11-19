# CODE REVIEW

Même dans un projet développé par une seule personne, la *code review* sert de garde-fou pour garantir la **qualité**, la **cohérence** et la **maintenabilité** du code.
Elle définit des critères objectifs pour valider qu’une modification est propre, testée et prête à être fusionnée.

---

## Objectif

* Assurer un **niveau de qualité constant** sur l’ensemble du projet.
* Prévenir les erreurs régressives, les oublis et les incohérences.
* Appliquer systématiquement les standards définis (stylistiques, techniques, documentation).
* Servir de checklist personnelle avant chaque merge ou déploiement.

---

## Standards de qualité

### Formatage et style Python

* Code formaté avec **Black**.
* Vérification de la conformité **Flake8**.
* Respect global de PEP8 (noms de variables, imports, structures).
* Aucune ligne inutile, aucun code mort.

### Lisibilité

* Fonctions courtes, lisibles.
* Pas de logique “magique” non expliquée.
* Noms explicites (pseudo, temps_total, niveau…).
* Organisation claire par modules (services, API, utils…).

### Documentation associée

* Docstrings ajoutées ou mises à jour quand nécessaire.
* Documentation API mise à jour si un endpoint change.
* Aucun morceau de code modifié sans doc correspondante.

---

## Critères fonctionnels

### Respect des règles métier

* Validation pseudo (longueur, caractères, liste noire).
* Unicité `(pseudo, date_jour)`.
* Barème 1 point / bonne réponse.
* Temps total positif unitaire.
* Réponses backend cohérentes (`400`, `409`, `201`).

### Non-régression

* Le flux principal reste fonctionnel :

  * Accueil → Quiz → Score → Classement → Rejouer.
* Les classements retournent 100 entrées max.
* La purge quotidienne reste opérationnelle.

---

## Tests associés

Chaque modification doit être accompagnée :

* de **tests unitaires** (pytest) si logique métier modifiée,
* de **tests API** pour chaque endpoint touché,
* de la vérification de la **couverture** (objectif : ≥ 80 %).

Aucune PR / merge vers `main` sans tests associés pour toute fonctionnalité non triviale.

---

## Workflow Git

### Branches

* Travail sur `feature/<nom>`.
* Merge vers `main` uniquement si :

  * tests OK,
  * lint OK,
  * documentation à jour.

### Commits

* Commits **simples, atomiques**.
* Nom normalisé (*style Angular*) :

  * `feat: add leaderboard sorting`
  * `fix: correct pseudo validation`
  * `docs: update API doc`

### Pull Requests (même solo)

Même si tu travailles seul, ouvrir une **PR interne** avant merge permet :

* de relire le code “à tête reposée”,
* de vérifier la checklist de code review,
* de déclencher la CI facilement.

---

## Checklist Code Review

Une checklist simple, à vérifier avant chaque merge :

* [ ] Code lisible et structuré
* [ ] Aucun code mort, aucune duplication
* [ ] Black + Flake8 OK
* [ ] Docstrings à jour
* [ ] Logique métier respectée
* [ ] Tests unitaires + API OK
* [ ] Régression fonctionnelle testée
* [ ] Documentation API mise à jour si nécessaire
* [ ] Commit messages propres
* [ ] PR validée (automatiquement ou manuellement)

---

## Résultat attendu

* Un code propre, stable, homogène dans tout le projet.
* Une qualité constante malgré un développement solo.
* Une fusion vers `main` toujours fiable et maîtrisée.

---
