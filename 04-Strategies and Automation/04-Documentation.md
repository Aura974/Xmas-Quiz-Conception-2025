# DOCUMENTATION

## Objectif

La documentation du code vise à garantir une **lisibilité durable** et une **compréhension immédiate** des éléments essentiels de l’application.
Elle permet de retrouver rapidement la logique métier, d’identifier les responsabilités de chaque module et de faciliter toute évolution future sans risque d’erreur ou de régression.

La documentation doit rester **concise, utile et cohérente**, en se concentrant sur ce qui apporte une réelle valeur technique, sans alourdir le code ou répéter des évidences.

---

## Conventions de documentation

Les conventions suivantes définissent la manière dont le code doit être documenté pour garantir une compréhension homogène et durable de l’ensemble de l’application.
Elles s’appliquent aux modules Python, aux endpoints Django REST Framework et aux scripts JavaScript du front.

---

### Docstrings Python

Les docstrings constituent la forme principale de documentation du code.

#### Style utilisé

Le projet adopte un **style Google**, simple et lisible.

#### Contenu attendu

Chaque fonction, classe ou module non trivial doit comporter une docstring indiquant :

* le rôle général du composant,
* les paramètres (nom + type attendu),
* la valeur de retour,
* les exceptions éventuelles (si pertinent).

#### Exemple

```python
def compute_score(points: int, total_time: int) -> int:
    """
    Calcule le score final en appliquant les règles définies.

    Args:
        points (int): Nombre de bonnes réponses (0 à 10).
        total_time (int): Durée totale en secondes.

    Returns:
        int: Score final.
    """
```

---

### Commentaires dans le code

Les commentaires doivent rester **exceptionnels**.

#### Autorisé

* Expliquer une **logique complexe**,
* Justifier un choix technique non évident,
* Décrire un comportement volontairement différent des standards.

#### Interdit

* Commentaires triviaux (“# boucle sur la liste”),
* Répéter ce que dit déjà le code,
* Expliquer ligne par ligne.

---

### Documentation des endpoints API

Chaque endpoint DRF doit être documenté via une **docstring au niveau de la vue** (APIView / ViewSet).

Elle indique :

* la méthode (`GET`, `POST`),
* les paramètres attendus (ex. `pseudo`, `points`, `temps_total`),
* les réponses possibles (`200`, `201`, `400`, `409`),
* une brève description de la logique métier.

Une version condensée des endpoints est également centralisée dans :
`/docs/api.md`

---

### Documentation JavaScript

La logique front étant simple, la documentation est légère :

* une courte description dans un fichier `README.md` du dossier JS,
* un commentaire en tête de chaque fichier JS expliquant :

  * le rôle du fichier,
  * les grandes fonctions (chrono, affichage question, feedback).

Le JS n’étant pas modulaire, aucune documentation détaillée n’est requise.

---

### Conventions globales

* la documentation doit rester **synchronisée** avec le code (pas de doc obsolète),
* pas d’explication excessive : priorité au **code lisible**,
* homogénéité des docstrings dans tout le projet,
* mise à jour obligatoire en cas de modification du comportement d’une API ou d’un service métier.

---

## Périmètre de la documentation

La documentation du code doit se concentrer uniquement sur les **éléments importants pour la compréhension ou la maintenance**.

### À documenter

* Logique métier (classement, validation, règles).
* API DRF (endpoints, serializers).
* Commandes Django.
* Composants JS structurants (chrono, transitions).

### À ne pas documenter

* Code trivial ou explicite par lui-même.
* Descriptions ligne par ligne.
* Commentaires redondants avec le code.
* Parties visuelles ou esthétiques (CSS, DOM simple).

---

## Mise à jour de la documentation

La documentation du code doit rester **synchronisée** avec le comportement réel de l’application.
Elle est mise à jour chaque fois qu’une modification affecte la logique métier, l’API, les commandes Django ou la structure des modules.

### Principes

* La documentation doit être **mise à jour dans le même commit** que la modification du code concerné.
* Aucune évolution fonctionnelle ou technique ne doit être mergée si la documentation associée n’est pas corrigée.
* Une doc obsolète est considérée comme une **anomalie** au même titre qu’un bug.

### Cas nécessitant une mise à jour immédiate

* modification d’un endpoint API (paramètres, réponses, codes HTTP),
* ajout ou modification d’une règle métier,
* ajout d’un module ou d’un service Python,
* ajout ou refactor d’une commande Django,
* évolution de la logique JS côté quiz (chrono, feedback, navigation),
* tout changement d’interface entre deux composants (services → vues API, JS → templates).

### Processus

1. Mettre à jour les docstrings concernées.
2. Actualiser le fichier `/docs/api.md` si l’API a évolué.
3. Vérifier que la documentation reste cohérente dans l’ensemble du projet.
4. Commit dédié ou partiel avec un libellé clair :

   * `docs: update API documentation`
   * `docs: update command docstring`

### Résultat attendu

* Documentation **à jour, homogène et fiable**.
* Code facilement compréhensible même longtemps après une période d’inactivité.

---
