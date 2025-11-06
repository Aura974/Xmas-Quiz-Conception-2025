# FRONT SECURITY

## Objectif

Mettre en œuvre une **sécurité préventive côté interface utilisateur**, en limitant les risques de manipulation du code, d’injection ou de collecte indue, tout en conservant une expérience fluide pour les enfants.

---

## 1. Sécurisation du code client

* **Code JavaScript minifié et non modifiable** (read-only sur serveur).
* **Aucun stockage persistant local** (`localStorage`, `sessionStorage`, cookies) n’est utilisé.
* **Protection du code source** : désactivation du debug et des messages console en production.
* **Désactivation du clic droit** et des raccourcis d’inspection sur le totem (niveau OS).

## 2. Isolation du contenu

* Politique **CSP stricte** empêchant tout chargement de scripts, images ou iframes externes.
* Aucun contenu dynamique (iframe, intégration vidéo, CDN) n’est autorisé.
* Les images et ressources statiques proviennent **exclusivement du serveur interne**.

## 3. Validation et gestion des entrées

* **Filtrage en double niveau (front + back)** :
  * côté front : vérification de la **longueur et syntaxe du pseudo**,
  * côté serveur : validation stricte (regex + liste noire).
* Messages d’erreur **génériques** et bienveillants, sans fuite d’information technique.

## 4. Accessibilité & sécurité UX

* Interface conçue selon les **principes WCAG niveau AA** :
  * contrastes conformes,
  * tailles de clic adaptées,
  * focus visible,
  * textes lisibles (police dyslexie-friendly).
* **Aucune publicité, redirection ou lien externe**.
* **Interactions limitées** au strict nécessaire (boutons quiz, pseudo, classement, rejouer).

## 5. Sécurité du navigateur

* L’application fonctionne uniquement sur **navigateurs desktop récents** : Chrome, Edge, Firefox.
* Mode **plein écran kiosque** pour éviter l’accès à la barre d’adresse et aux extensions.
* **Mise à jour automatique** du navigateur sur le poste totem avant chaque période d’utilisation.

---

## Résultat attendu

* Aucune donnée locale exploitable ou persistante.
* Aucun script externe ni ressource tierce chargée.
* Comportement prévisible, stable et sûr, même en cas d’usage non supervisé par un adulte.

---
