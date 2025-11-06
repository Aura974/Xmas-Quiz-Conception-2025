# GLOBAL SECURITY

## Objectif

Protéger un service web interne utilisé par des mineurs, en minimisant les données et la surface d’attaque, tout en restant simple à opérer.

## Périmètre & principes

* **Zéro donnée personnelle** : seule la chaîne `pseudo` (filtrée) et les métriques de jeu (points, temps, niveau, date_jour) sont traitées ; **rétention 1 jour**.
* **Sécurité par défaut** (deny-by-default) : tout ce qui n’est pas nécessaire est désactivé (admin non exposée, pas de comptes, pas de sessions).
* **Intranet sécurisé** : exposition **HTTPS** derrière **reverse-proxy** sur réseau interne + **allowlist IP**.
* **Séparation claire** : UI statique (templates) ≠ API REST (classement) ≠ BDD.

## Transport & réseau

* **TLS** obligatoire (TLS 1.2+), redirection 301 HTTP→HTTPS.
* **HSTS** (includeSubDomains; preload si pertinent intranet).
* **Pare-feu** : n’ouvrir que 443 (proxy) ; BDD non exposée (listen localhost/réseau interne).
* **Rate-limit** au proxy et à l’API (ex. soumission score : 5 req/min/IP).

## Durcissement applicatif (headers & contenu)

* **CSP stricte** : `default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; script-src 'self'; connect-src 'self'; frame-ancestors 'self'; base-uri 'self'`.
* **X-Content-Type-Options: nosniff**, **Referrer-Policy: no-referrer**, **X-Frame-Options: SAMEORIGIN** (ou via `frame-ancestors` CSP), **Permissions-Policy** minimale (désactiver caméra/micro/géoloc).
* **No cookies non essentiels** ; pas de stockage local d’ID utilisateur.

## Validation & logique métier

* **Validation serveur** systématique : pseudo (3–12, charset autorisé, liste noire), bornes `points` [0..10], `temps_total` > 0.
* **Unicité/jour** : contrainte en base (clé composite `(pseudo, date_jour)`).
* **Idempotence** : éviter les doubles insertions (clé unique + gestion d’erreur propre).
* **Messages d’erreur génériques** (pas de détails techniques côté client).

## Journaux & observabilité

* **Logs minimaux** (statut, endpoint, durée, timestamp), **sans IP** ni User-Agent persistés.
* **Rotation** et rétention courte (7 jours max), accès restreint.
* **/api/health** (liveness/readiness) pour supervision interne.

## Gestion des secrets & dépendances

* **Secrets en variables d’environnement** (Docker), jamais en dépôt.
* **Mises à jour régulières** et **verrouillage des versions** (fichiers de lock).
* **Analyse des dépendances** (audit sécurité) dans la CI interne.

## Sauvegarde & continuité

* **Schéma et métadonnées** sauvegardés (dump structurel) ; les **données quotidiennes expirent** à 00:00 UTC+4 (pas de besoin de restauration fonctionnelle au-delà de la journée).
* **Tâche de purge** idempotente, contrôles d’intégrité post-exécution (compte des lignes du jour).

## Conformité mineurs / RGPD (vue globale)

* **Minimisation** (pas de PII), **finalité** = animation interne, **base légale** : intérêt légitime.
* **Analytics** strictement **anonymisés** et **sans cookies** (événements agrégés).

---
