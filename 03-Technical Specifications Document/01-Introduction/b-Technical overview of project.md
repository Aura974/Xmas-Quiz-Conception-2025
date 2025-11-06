# TECHNICAL OVERVIEW

Le **Quiz de Noël** est une **application web ludique et éducative**, conçue pour permettre à des **enfants de 5 à 12 ans** de tester leurs connaissances sur les **traditions de Noël à La Réunion** tout en s’amusant.

Le projet s’inscrit dans le cadre des **activités internes de la Nordev**, dans une démarche de **convivialité et de valorisation du lien social** pendant les fêtes de fin d’année.
L’application est destinée à être utilisée **sur poste totem**, en **mode kiosque**, sans installation ni connexion externe.

## **Périmètre fonctionnel inclus**

* Lancement et déroulement d’une partie avec **10 questions aléatoires** par niveau (facile, intermédiaire, avancé) ;
* Gestion du **score** et du **chrono global** ;
* Saisie d’un **pseudo** pour apparaître dans le **classement journalier** ;
* Consultation du **classement Points / Temps** (reset automatique chaque jour à 00:00 UTC+4) ;
* Interface claire, colorée et accessible (niveau AA) ;
* Collecte d’**analytics anonymisés** (Matomo auto-hébergé).

## **Hors périmètre**

* Aucun **compte utilisateur**, ni stockage de données personnelles ;
* Pas de **mode hors ligne** ;
* Pas d’**interface d’administration** ou d’édition de questions dynamiques ;
* Pas de **fonction vocale** ni d’indices en jeu.

---

Exactement 👌 très bonne remarque — la **1.3** doit donc rester **générique et orientée objectifs**, sans préjuger des choix de stack à venir.
Voici la version **corrigée et neutre** de la sous-partie :

---

## **Objectifs techniques principaux**

Le développement du **Quiz de Noël** vise à mettre en œuvre une **application web légère, stable et sécurisée**, répondant aux exigences fonctionnelles du CdCF tout en restant techniquement simple à déployer et à maintenir.

Les principaux objectifs techniques sont :

* Assurer une **excellente performance** sur navigateur desktop (temps de chargement court, fluidité des transitions).
* Garantir une **expérience utilisateur accessible** à un jeune public (contrastes, lisibilité, réactivité).
* Offrir une **structure logicielle claire et modulaire**, facilitant les mises à jour et la maintenance.
* Mettre en place une **architecture sécurisée**, adaptée à un usage interne et respectueuse des règles RGPD.
* Prévoir une **intégration facilitée** avec un système de base de données et un mécanisme de classement journalier.
* Concevoir une solution **évolutive**, pouvant accueillir ultérieurement de nouveaux jeux, thèmes ou séries de questions.

### **Périmètre technique général**

Le périmètre technique couvre :

* le **front-end** (interface utilisateur et logique de jeu) ;
* le **back-end** (traitement du score, gestion du classement, horodatage serveur) ;
* le **système de stockage** des données (questions, scores, classements) ;
* les **mécanismes de sécurité et d’accès** ;
* et les **outils de conception, test et déploiement** utilisés pendant le cycle de vie du projet.

---
