# REQUIREMENTS ANALYSIS

Cette section recense et hiérarchise les **besoins exprimés** ou **implicites** des utilisateurs, ainsi que les **besoins fonctionnels et non fonctionnels** nécessaires à la réussite du projet.

---

## Besoins utilisateurs

| **ID** | **Profil concerné**  | **Besoin exprimé**                                          | **Objectif associé**                                          |
| :----: | :------------------- | :---------------------------------------------------------- | :------------------------------------------------------------ |
|   U1   | Enfant (5–7 ans)     | Pouvoir jouer à un quiz simple avec des images              | Découvrir et s’amuser sans difficulté de lecture              |
|   U2   | Enfant (8–10 ans)    | Répondre à des questions un peu plus complexes              | Stimuler la réflexion et la curiosité                         |
|   U3   | Enfant (11 ans et +) | Se confronter à un vrai défi avec un chrono                 | Créer un sentiment de challenge                               |
|   U4   | Tous niveaux         | Obtenir un score et voir la bonne réponse à chaque question | Comprendre ses erreurs et progresser                          |
|   U5   | Tous niveaux         | Entrer un pseudo pour apparaître au classement              | Favoriser la compétition ludique                              |
|   U6   | Parent/encadrant     | Superviser le jeu en toute sécurité                         | Garantir un environnement sans risque ni données personnelles |
|   U7   | Tous                 | Rejouer facilement une nouvelle partie                      | Encourager la répétition et la persévérance                   |

---

## Besoins fonctionnels

| **ID** | **Besoins fonctionnels**                                     | **Priorité** |
| :----: | :----------------------------------------------------------- | :----------: |
|   F1   | Permettre de sélectionner un niveau de difficulté            |   🔴 Haute   |
|   F2   | Afficher 10 questions aléatoires par partie                  |   🔴 Haute   |
|   F3   | Gérer un chrono global pendant la partie                     |   🔴 Haute   |
|   F4   | Afficher les bonnes réponses et messages de feedback         |  🟠 Moyenne  |
|   F5   | Calculer et afficher le score final                          |   🔴 Haute   |
|   F6   | Enregistrer le pseudo et le score pour le classement du jour |   🔴 Haute   |
|   F7   | Gérer deux classements distincts (points et temps)           |   🔴 Haute   |
|   F8   | Réinitialiser les classements chaque jour (UTC+4)            |  🟠 Moyenne  |
|   F9   | Permettre de relancer une partie sans recharger la page      |   🟢 Basse   |
|   F10  | Garantir la compatibilité sur navigateurs desktop récents    |   🔴 Haute   |

---

## Besoins non fonctionnels

| **ID** | **Besoins non fonctionnels** | **Critère / Objectif**                                 |
| :----: | :--------------------------- | :----------------------------------------------------- |
|   NF1  | Accessibilité                | Contrastes AA, police dys-friendly                     |
|   NF2  | Performance                  | Temps de chargement < 3 s                              |
|   NF3  | Sécurité                     | Aucune donnée personnelle stockée                      |
|   NF4  | Fiabilité                    | Aucun blocage possible pendant le quiz                 |
|   NF5  | Ergonomie                    | Navigation intuitive, boutons grands et explicites     |
|   NF6  | Identité visuelle            | Univers “Noël à La Réunion” cohérent et festif         |
|   NF7  | Maintenabilité               | Code clair, fichiers JSON faciles à mettre à jour      |
|   NF8  | Conformité                   | Respect du public mineur (pas de cookies ni publicité) |

---
