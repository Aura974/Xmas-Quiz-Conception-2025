# API/SYSTEM ARCHITECTURE

## Vue logique (couches)

* **API REST (Django + Django REST Framework)**

  * **Rôle :** interface unique entre l’application frontale et la base de données.
  * **Routes principales :**

    * `POST /api/scores` → enregistre un score.
    * `GET /api/leaderboard` → renvoie le classement du jour.
    * `GET /api/health` → test de disponibilité.
  * **Validation :** via les sérializers DRF (`nickname`, `points`, `total_time`, `level`).
  * **Throttling :** limitation de débit pour éviter le spam (ex. 5 soumissions/min/IP).
  * **Réponses :** JSON structuré, avec statuts HTTP cohérents (`200`, `201`, `400`, `409`).

* **Service / Domaine**

  * Règles métier : unicité `(nickname, day_date)`, bornes `points` et `total_time`.
  * Séparation nette entre logique métier et accès aux données.

* **Accès données**

  * ORM Django (`Game`, `Day`) utilisant les index de classement.
  * Gestion automatique des FK et des suppressions en cascade.

* **Persistance**

  * Base **PostgreSQL**.
  * Purge quotidienne des scores : tâche planifiée simple (cron ou commande Django).

* **Infra**

  * **Nginx** (reverse proxy HTTPS)
    → **Gunicorn** (serveur WSGI)
    → **Django REST API**.
  * Certificats HTTPS gérés par **Certbot / Let’s Encrypt**.

---

## Endpoints (contrat API)

| Méthode & URL                     | Entrée attendue                         | Sortie                                     | Règles clés                                 |                            |
| :-------------------------------- | :-------------------------------------- | :----------------------------------------- | :------------------------------------------ | -------------------------- |
| `POST /api/scores`                | `{nickname, level, points, total_time}` | `201 {game_id}` ou `409` si doublon jour | Unicité `(nickname, day_date)`               |                            |
| `GET /api/leaderboard?type=points` | `temps&limit=100`                        | —                                          | `200 [{rang, nickname, points, total_time}]` | Filtre `day_date = today` |
| `GET /api/health`                 | —                                       | `200 {status:'ok'}`                        | Vérifie API + base                          |                            |

---

## Cycle de traitement

1️⃣ Le client appelle une route API via HTTPS.  
2️⃣ Nginx transfère la requête à Gunicorn (serveur Django).  
3️⃣ DRF valide les données, applique les règles métier, écrit ou lit via l’ORM.  
4️⃣ L’API renvoie une réponse JSON formatée.

---

## Sécurité API

* **CORS strict** : seules les origines autorisées peuvent accéder à l’API.
* **Headers HTTP** : CSP, HSTS, Referrer-Policy, X-Frame-Options.
* **Throttling** : limitation de débit sur `/api/scores`.
* **Aucune donnée personnelle** stockée ou transmise.

---

## Observabilité

* **Logs Django & Nginx** : traçabilité des requêtes et erreurs.
* **Endpoint `/api/health`** : supervision simple (API + DB).

---
