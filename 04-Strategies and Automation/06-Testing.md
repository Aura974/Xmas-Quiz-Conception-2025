# TESTING

Les tests constituent un pilier essentiel de la qualité du projet *Quiz de Noël*.
Ils garantissent que la logique métier, l’API, la base de données et la partie visible du quiz fonctionnent correctement à chaque évolution.
La stratégie repose sur trois niveaux : **tests unitaires**, **tests API**, et **tests manuels fonctionnels**.

---

## Objectif

* Vérifier la conformité aux règles métier.
* Prévenir les régressions.
* Assurer que chaque endpoint, chaque composant métier, et chaque partie du quiz fonctionne comme prévu.
* Maintenir un niveau de qualité stable avant chaque déploiement interne.

---

## Outils utilisés

* **pytest** : framework principal de tests.
* **pytest-django** : gestion automatique de la base test.
* **coverage.py** : mesure de couverture des tests.
* **requests** : tests fonctionnels des endpoints REST.

---

## Périmètre des tests

### Tests unitaires (Python)

Portent sur la logique métier pure :

* validation des pseudos (longueur, regex, liste noire),
* calcul du score,
* règles de tri (classement points & temps),
* vérification des bornes (0–10 points, temps > 0),
* utilitaires métier (normalisation, transformations).

Ces tests s’exécutent rapidement et doivent couvrir l’essentiel des règles métier.

---

### Tests d’intégration API (DRF)

Portent sur les endpoints :

* `POST /api/scores` :

  * insertion valide,
  * pseudo déjà utilisé → `409`,
  * pseudo invalide → `400`,
  * temps ou points incorrects → `400`.

* `GET /api/leaderboard` :

  * récupération du classement du jour,
  * tri correct (points puis temps / temps puis points),
  * limite 100 entrées respectée,
  * gestion du champ `type=points|temps`.

* `GET /api/health` :

  * API + DB opérationnelles.

Les tests API valident l’intégration complète Django → ORM → PostgreSQL.

---

### Tests manuels fonctionnels

Avant chaque campagne (ou après un changement significatif), un test manuel complet vérifie le flux utilisateur :

1. Choisir un niveau.
2. Répondre aux 10 questions (bonnes + mauvaises).
3. Vérifier le chrono.
4. Soumettre un pseudo.
5. Vérifier l’apparition dans le classement.
6. Tester l’onglet Points / Temps.
7. Tester le bouton Rejouer.

Objectif : vérifier ce que les tests automatisés ne couvrent pas encore (UX, transitions, affichage des images…).

---

## Couverture de tests

* Objectif de **≥ 80 %** de couverture.
* Les modules critiques (classement, validation pseudo, endpoints) doivent être **100 % testés**.
* Les tests de code trivial (templates, DOM simple) ne sont pas obligatoires.

---

## Pipeline automatique (CI)

Si la CI est activée :

* exécution des tests à chaque push,
* génération d’un rapport coverage,
* échec du pipeline si un test échoue,
* scan de sécurité des dépendances.

---

## Résultat attendu

* Application testée, stable et prévisible.
* Aucune régression fonctionnelle sur les flux critiques.
* Confiance complète avant chaque mise à disposition interne.

---
