# CHECKLISTS PÉRIODIQUES

Les checklists permettent de garantir que tous les éléments critiques du système sont **prêts**, **fonctionnels**, et **sécurisés** avant l’utilisation publique du quiz.
Elles servent également à assurer un arrêt propre une fois la campagne terminée.

---

## Checklist pré-campagne (avant mise à disposition)

### Application & API

* [ ] Le flux complet fonctionne : Accueil → Quiz → Score → Classement.
* [ ] `/api/health` retourne `status: ok`.
* [ ] Aucun message d’erreur dans les logs Django.
* [ ] Aucune erreur 500/502/503 dans les logs Nginx.

### Base de données

* [ ] La purge quotidienne du jour précédent a été effectuée.
* [ ] Aucun verrou bloquant sur `game`.
* [ ] Index présents et fonctionnels.

### Infrastructure

* [ ] Docker démarre sans erreur (`docker compose up -d`).
* [ ] Les conteneurs `web`, `nginx`, `db` sont *healthy*.
* [ ] Certificat TLS valide (date, renouvellement Certbot OK).
* [ ] Nginx retourne bien en HTTPS uniquement.

### Sécurité

* [ ] CSP et headers de sécurité actifs (test rapide via navigateur devtools).
* [ ] Aucun port autre que 443 n’est exposé.
* [ ] Variables d’environnement correctes (DB, secret key…).

### Totem / Poste utilisateur

* [ ] Navigateur en mode kiosque.
* [ ] Cache vidé.
* [ ] Mise à jour navigateur OK.

---

## Checklist quotidienne pendant la campagne

### Technique

* [ ] `/api/health` répond correctement.
* [ ] Aucun nouveau 500 dans les logs des dernières 24h.
* [ ] Purge de minuit confirmée.
* [ ] Volume DB stable.

### Fonctionnel

* [ ] Une partie test jouée sans anomalie.
* [ ] Le classement s’affiche correctement.

---

## Checklist post-campagne (après utilisation)

### Arrêt propre

* [ ] Arrêt de la stack (`docker compose down`).
* [ ] Sauvegarde du schéma SQL (optionnel).
* [ ] Nettoyage des logs (rotation ou purge si souhaité).

### Documentation

* [ ] Incident(s) éventuels notés dans `/docs/incidents.md`.
* [ ] État final consigné (version déployée, date).

### Préparation pour la prochaine période

* [ ] Mise à jour potentielle des dépendances.
* [ ] Vérification des certificats TLS.
* [ ] Nettoyage du dossier `/static` si re-généré.

---

## Résultat attendu

* Mise en ligne **sans mauvaise surprise**,
* Suivi quotidien simple,
* Arrêt propre et reproductible,
* Application toujours prête pour une nouvelle utilisation.

---
