# API/SYSTEM SECURITY

## Objectif

Garantir la **sécurité du back-end et des communications API**, en prévenant les abus, les injections, les accès non autorisés et la fuite d’informations, tout en conservant un fonctionnement fluide pour un usage interne.

---

## 1. Authentification et accès

* Aucune authentification utilisateur (public mineur), mais :
  * **CORS strictement limité** au domaine de l’application.
  * **Endpoints publics restreints** (`POST /scores`, `GET /leaderboard`, `GET /health`).
* **Endpoints d’administration Django désactivés** en production (`/admin` non exposé).
* Accès **intranet uniquement** (via pare-feu + allowlist IP).
* **Rate limiting** :
  * sur le proxy (Nginx : 5 requêtes/min/IP pour `/scores`),
  * sur Django REST Framework (`ScopedRateThrottle`).

---

## 2. Validation et intégrité des données

* **Sérialisation et validation DRF** sur toutes les requêtes :
  * `pseudo` : longueur 3–12, caractères `[a-z0-9_-]`, liste noire, normalisation.
  * `points` : entier entre 0 et 10.
  * `temps_total` : valeur positive < 600 s.
  * `niveau` : parmi `facile`, `intermédiaire`, `avancé`.
* **Contrainte d’unicité** `(pseudo, date_jour)` en base de données.
* Requêtes idempotentes : un score donné ne peut être soumis qu’une seule fois par pseudo et jour.
* **Retour JSON uniforme** : code, message utilisateur, message technique (log interne seulement).

---

## 3. Sécurité applicative

* **Protection XSS et CSRF** :
  * endpoints REST uniquement, donc **CSRF désactivé** (pas de cookies/session),
  * **CSP** et **encodage systématique** des réponses JSON.
* **Protection contre injections SQL** assurée par le **Django ORM**.
* **Suppression automatique** des données à 00:00 UTC+4 (purge quotidienne).
* **Gestion d’erreurs sécurisée** :
  * logs internes sans détails techniques,
  * réponse standardisée (`500` → message générique “Erreur interne, réessayez plus tard”).

---

## 4. Communication et chiffrement

* Toutes les communications client-serveur se font en **HTTPS/TLS 1.2+**.
* Certificats gérés via **Nginx** (Let’s Encrypt ou certificat interne Nordev).
* Aucun trafic non chiffré n’est autorisé ; redirection automatique HTTP → HTTPS.
* **Pas d’appel externe** depuis le serveur (aucune dépendance à une API tierce).

---

## 5. Journalisation et supervision

* **Logs d’accès et d’erreurs** :
  * stockés localement, rotation 7 jours max, lecture restreinte.
  * pas d’adresse IP, pas d’User-Agent complet.
* **Endpoint `/api/health`** : vérifie connectivité DB + latence API.
* **Monitoring basique** via logs ou tableau interne (tableur de supervision).
* **Alertes manuelles** en cas d’erreur récurrente sur la soumission de score.

---

## 6. Gestion des dépendances et du déploiement

* **Verrouillage des versions** (`requirements.txt` + hash).
* **Audit sécurité périodique** : `pip-audit` ou équivalent local.
* **Images Docker minimales** (basées sur `python:slim`).
* **Secrets** (clés, mots de passe DB) injectés via **variables d’environnement**, non stockés en clair.
* **Serveur d’application Gunicorn** :
  * timeout 30 s max,
  * workers limités (2–4 selon charge),
  * accès root interdit à Django.

---

## Résultat attendu

* API hermétique à toute tentative d’exploitation externe.
* Aucune fuite de donnée, aucun stockage nominatif.
* Réponses stables et cohérentes même en cas d’erreur réseau.
* Architecture robuste et sécurisée, conforme à un usage éducatif interne.

---
