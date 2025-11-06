# ORM

L’application **Quiz de Noël** repose sur le framework **Django**, qui intègre nativement un **ORM complet et mature**.
Ce composant fait partie du cœur du framework et assure la **gestion automatique des modèles de données**, des **migrations** et des **opérations CRUD** sans nécessiter de bibliothèque tierce.

## Fonctionnalités principales

* **Définition des modèles** sous forme de classes Python, avec génération automatique des tables SQL correspondantes.
* **Migrations intégrées** : création et modification du schéma via commandes (`makemigrations`, `migrate`).
* **Requêtes de haut niveau** : filtres, agrégations, tris, jointures et annotations gérés en Python, convertis en SQL optimisé.
* **Validation et sécurité** : prévention des injections SQL, gestion des contraintes d’unicité et des relations.
* **Compatibilité PostgreSQL** : support natif des index, des contraintes composites et des types spécifiques (date, JSON, etc.).

## Justification du choix

L’ORM intégré de Django répond **pleinement aux besoins du projet**, notamment :

* Le **classement journalier** peut être géré via un modèle `Score` avec contrainte d’unicité (`pseudo`, `date_jour`), facilement manipulable via des filtres ORM.
* Les **purges quotidiennes** sont simples à implémenter (commande de gestion `flush_daily_scores` filtrant sur la date).
* Le **volume de données** étant faible et limité à une journée, les performances du Django ORM sont **largement suffisantes**.
* Son intégration native assure une **parfaite cohérence** entre la logique applicative, les migrations et la base de données PostgreSQL.

## Conclusion

Aucun ORM externe (SQLAlchemy, Tortoise ORM, etc.) n’est requis.
L’**ORM Django intégré** est **robuste, sécurisé et adapté** au périmètre du projet.
Il constitue donc le **choix unique et définitif** pour la gestion des données de l’application **Quiz de Noël**.

---
