# INFRASTRUCTURE AND AUTOMATION

## Environnements de développement

L’objectif est de garantir un **environnement reproductible, isolé et simple à relancer**, identique entre le poste local et le serveur Docker.

### Structure du projet et dépôt Git

Le projet est centralisé dans un **seul dépôt GitHub**, contenant :

* le code Django (`quiz_noel/`, `app/`),
* les fichiers de configuration (`docker-compose.yml`, `Dockerfile`, `nginx.conf`, `requirements.txt`),
* les **questions du quiz** au format JSON (`/questions/facile.json`, `intermediaire.json`, `avance.json`),
* la **documentation** (CdCF, CdCT, diagrammes, stratégies) en Markdown dans un dossier `/docs`.

Les branches principales :

* `main` → version stable, déployable.
* `feature/*` → développements ponctuels (ex. `feature/chrono`, `feature/classement`).

---

### Environnement Python

Sur le poste de travail :

* Utilisation de **Python 3.14.x** et d’un **environnement virtuel** (`venv`) dédié au projet.

* Installation des dépendances via :

  ```bash
  pip install -r requirements.txt
  ```

* Le fichier `requirements.txt` contient des **versions figées** pour garantir la reproductibilité (mêmes libs local / CI / production).

Exemple de cycle standard :

1. Cloner le dépôt.
2. Créer/activer le venv.
3. Installer les dépendances.
4. Lancer le serveur Django pour le développement (`manage.py runserver` ou via Docker, voir ci-dessous).

---

### Docker pour harmoniser les environnements

Même si le développement peut se faire en “pur venv”, **Docker est la référence** pour l’environnement cible :

* Un `docker-compose.yml` fournit les services `web` (Django + Gunicorn en mode dev simplifié) et `db` (PostgreSQL).
* En local, il est possible de :

  * développer avec Django en direct (runserver) **tout en pointant sur la DB Docker**,
  * ou lancer toute la stack (`docker compose up`) pour tester un environnement proche de la production.

Objectif : limiter les “chez moi ça marche / sur le serveur non”.

---

### Outils de développement (VS Code, formatage, lint)

L’IDE de référence est **Visual Studio Code**, avec :

* une configuration de base du projet (fichier `.vscode/settings.json`) activant :

  * **Black** pour le formatage Python automatique,
  * **Flake8** pour le linting,
  * l’indentation et l’UTF-8 par défaut ;
* éventuellement, des tâches VS Code pour :

  * lancer les tests (`pytest`),
  * démarrer le serveur Django ou `docker compose up`.

Exemple de pratique attendue :

* avant chaque commit, le code Python est **formaté** (Black) et **vérifié** (Flake8),
* les fichiers générés (`__pycache__`, `.venv`, etc.) sont exclus via `.gitignore`.

---

## Infrastructure serveur

L’infrastructure cible repose sur une **stack Docker homogène**, simple à administrer et adaptée à un usage intranet.
Elle garantit la séparation nette entre **proxy**, **application**, et **base de données**, tout en maintenant un haut niveau de sécurité.

---

### Vue d’ensemble

Les services sont déployés via **Docker Compose** :

```scss
Nginx (reverse proxy HTTPS)
        ↓
Gunicorn (serveur WSGI)
        ↓
Django + DRF (API + templates)
        ↓
PostgreSQL (données 1 jour)
```

Chaque composant est isolé dans son propre conteneur avec un réseau interne dédié.

---

### Reverse proxy – Nginx

Nginx est le point d’entrée unique du système :

* termine le **HTTPS** (TLS 1.2+),
* applique les **en-têtes de sécurité** (CSP, HSTS, Referrer-Policy, etc.),
* effectue le **rate-limiting** sur `POST /api/scores`,
* reverse-proxy vers Gunicorn sur le réseau interne Docker,
* sert les **fichiers statiques** (CSS, JS minifié, images du quiz).

Les ports ouverts :

* **443** : unique port exposé vers l’extérieur/intranet.
* **80** : redirection HTTP → HTTPS.

Les certificats sont gérés via **Certbot** ou fournis par l’infrastructure interne.

---

### Serveur d’application – Gunicorn

Gunicorn joue le rôle de serveur WSGI entre Nginx et Django.

Paramètres recommandés :

* **workers : 2–4** selon CPU disponible,
* **timeout : 30 secondes**,
* désactivation de l’accès root dans le conteneur,
* logging minimal (relais vers stdout).

Gunicorn garantit une exécution stable, sans surcharge pour une application interne à faible trafic.

---

### Application – Django + Django REST Framework

Le conteneur Django contient :

* le **moteur de templates** (UI),
* le **module API** (DRF),
* la **logique métier** (classement, pseudo unique),
* les **fichiers statiques** (collectés via `collectstatic`),
* les commandes internes (purge quotidienne).

Paramètres clés :

* CORS strict,
* CSRF désactivé (pas de cookies, API pure),
* logs applicatifs minifiés,
* variables d’environnement pour gestion des secrets.

---

### Base de données – PostgreSQL

La base PostgreSQL est isolée dans un conteneur non exposé publiquement.

Caractéristiques :

* volume Docker persistant pour `pgdata`,
* écoute uniquement en **interne (`localhost` / réseau docker)**,
* utilisateur dédié à droits restreints,
* connexions chiffrées,
* index `points`, `temps_total`, `date_jour` pour les classements,
* réinitialisation automatique des données (00:00 UTC+4).

Pas de sauvegarde des données — seule la **structure** est exportée en cas de besoin.

---

### Réseau & isolation

Tous les conteneurs communiquent via un **réseau Docker interne**, inaccessible depuis l’extérieur.
La carte réseau publique n’expose que **Nginx (443)**.

Avantages :

* réduction drastique de la surface d’attaque,
* impossibilité d’accès direct à la base de données,
* séparation stricte des rôles.

---

### Déploiement

Le déploiement consiste à :

1. Pousser les images Docker à jour (si CI/CD activée).
2. Se connecter au serveur via SSH.
3. Tirer la dernière version du repository.
4. Relancer la stack :

```bash
docker compose down
docker compose pull
docker compose up -d --build
```

Le service est opérationnel immédiatement grâce à la persistance des volumes et au proxy inverse.

---

## Automatisation du cycle de vie

L’objectif de cette section est d’assurer que certaines opérations essentielles du système s’exécutent **sans intervention humaine**, de manière fiable, reproductible et sécurisée.
Les automatisations se concentrent sur :

* la **gestion quotidienne des données**,
* la **sécurité des dépendances**,
* la **gestion des logs**,
* la **cohérence de la base**.

---

### Purge quotidienne automatique

Le classement est réinitialisé **tous les jours à 00:00 (UTC+4)**.
Cette opération est automatisée via une **commande Django** exécutée par :

* soit un **cron** dans le conteneur Django,
* soit un **scheduler Docker** (plus propre),
* soit une exécution périodique via `supercronic`.

Fonctionnement :

1. Exécution de `python manage.py purge_daily_scores`.
2. Suppression de toutes les entrées `game` liées à `day_date = yesterday`.
3. Vérification du compteur de lignes (contrôle d’intégrité).
4. Log d’une ligne “Purge OK” en rotation courte (max 7 jours).

Résultat : la base reste légère, cohérente, et conforme au RGPD.

---

### Audit automatique des dépendances

Pour maintenir un niveau de sécurité maximal :

* un job automatisé exécute régulièrement (**hebdomadaire conseillé**) :

```bash
pip-audit --output-format=json
```

* rapport analysé manuellement,
* mise à jour éventuelle des versions dans `requirements.txt`.

Avantage : éviter l’introduction de vulnérabilités connues dans Django, DRF ou les libs Python.

---

### Rotation et nettoyage des logs

Les logs Nginx et Django sont soumis à une rotation automatique :

* rotation **hebdomadaire**,
* rétention **7 jours**,
* compression automatique via `logrotate`.

Ce mécanisme :

* évite le remplissage du disque,
* garantit une trace minimale utile,
* respecte la politique RGPD (aucune donnée personnelle stockée durablement).

---

### Vérifications d’intégrité de la base

Une automatisation périodique (cron, 1×/jour) effectue :

* un `VACUUM ANALYZE` sur la table `game`,
* une vérification que les index attendus existent bien,
* une connexion test (supervisée par `/api/health`).

But :
maintenir des temps de réponse rapides pour le classement et éviter l’accumulation de statistiques obsolètes.

---

### Sauvegarde structurelle (schéma uniquement)

Même si les données de score sont **éphémères**, le **schéma** doit être sauvegardé.

Automatisation mensuelle recommandée :

```bash
pg_dump --schema-only -U user dbname > schema_backup.sql
```

Stockage :

* hors volume web,
* dans un dossier sécurisé du serveur,
* rotation trimestrielle.

---

### Mise en cache statique automatique (optionnel)

Au build, l’étape `collectstatic` est déclenchée automatiquement dans le conteneur Django :

* minification CSS/JS,
* regroupement des fichiers statiques,
* purge du cache précédent.

Permet un chargement plus rapide sur le totem.

---

### Reconstruction automatique des images Docker (CI/CD)

À chaque push sur `main` :

* construction automatique des images Docker,
* exécution des tests,
* scan des dépendances,
* push dans le registry Docker personnel (optionnel).

Résultat :
le serveur n’a plus qu’à **pull + restart**, sans risque d’incohérence.

---

## Intégration continue / Déploiement continu (CI/CD) minimaliste

La CI/CD n’est **pas obligatoire** pour un projet interne à développeur unique, mais elle permet d’assurer une **qualité constante**, des **builds reproductibles**, et une **mise à jour sereine** de l’application.

Le pipeline proposé reste volontairement **léger** et centré sur l’essentiel.

---

### Objectifs

* Garantir qu’aucun commit ne casse le projet.
* Automatiser les tests et la validation du code.
* Construire les images Docker de manière homogène.
* Faciliter le déploiement sur le serveur via un simple `docker compose pull`.

---

### Pipeline GitHub Actions

Déclencheur :

* **à chaque push sur `main`**,
* **ou manuellement** si nécessaire.

Étapes :

1. **Checkout du dépôt**

   * Récupération du code dans un runner GitHub.

2. **Installation Python**

   * Version 3.14.x pour cohérence avec le projet.

3. **Installation des dépendances**

   ```bash
   pip install -r requirements.txt
   ```

4. **Analyse statique**

   * exécution de Black (vérification format),
   * exécution de Flake8 (linting).

5. **Tests automatisés**

   ```bash
   pytest --disable-warnings
   ```

6. **Mesure de couverture**

   * `coverage.py` avec seuil minimal (ex. 80%).

7. **Scan de sécurité**

   * audit des dépendances (`pip-audit`).

8. **Build de l’image Docker**

   * construction locale dans le runner,
   * validation de la conformité Dockerfile.

9. **Push optionnel**

   * vers un **Docker registry privé**, uniquement si tu veux automatiser la mise en prod.

---

### Stratégie de déploiement

Le déploiement reste **manuel**, pour éviter les actions involontaires sur le serveur interne :

1. Connexion SSH au serveur.
2. Pull des dernières images (si registry utilisé) :

   ```bash
   docker compose pull
   ```

3. Redémarrage propre :

   ```bash
   docker compose down
   docker compose up -d
   ```

Alternative sans registry :

* simplement `git pull` puis `docker compose up -d --build`.

Cette approche combine **sécurité**, **contrôle humain**, et **simplicité**.

---

### Avantages de cette CI/CD minimaliste

* Détecte les erreurs de code avant déploiement.
* Évite les régressions silencieuses.
* Réduit les risques de fail lors d’une mise à jour.
* Rend le build reproductible localement et sur le serveur.
* Reste suffisamment léger pour ton workflow solo.

---
