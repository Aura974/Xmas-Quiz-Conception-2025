# INTRODUCTION

Le présent document définit les **stratégies de développement, d’automatisation et de maintien opérationnel** du projet *Quiz de Noël*.
Il complète le CdCF et le CdCT en détaillant **comment** l’application sera réellement construite, testée, déployée et entretenue dans le temps.

L’objectif est de garantir :

* un **processus de développement stable et reproductible**,
* une **infrastructure simple mais fiable**,
* des **tâches automatisées** limitant les risques d’erreur humaine,
* une **qualité constante du code** même dans un contexte de développement individuel,
* une **maintenance durable**, sécurisée et facile à opérer.

Ces stratégies s’appuient sur les choix techniques validés (Django, PostgreSQL, Docker, Nginx) et sur les contraintes spécifiques du projet : **public mineur, anonymat total, environnement interne, faible charge, délai court**.

---
