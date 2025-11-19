# MAINTENANCE

## Objectif et périmètre de la maintenance

La maintenance vise à garantir le **bon fonctionnement continu**, la **sécurité** et la **stabilité** du projet *Quiz de Noël* lors de son utilisation et entre chaque période de déploiement interne.
Elle couvre l’ensemble des éléments techniques nécessaires au fonctionnement du système, dans une logique de **prévention**, de **surveillance** et de **réaction rapide** en cas d’incident.

### **Objectifs principaux**

* Assurer une application **disponible**, **performante** et **prévisible**.
* Prévenir les défaillances par des vérifications régulières.
* Détecter et corriger rapidement les erreurs (logs, comportements anormaux).
* Maintenir un environnement sécurisé (mises à jour, dépendances, certificats).
* Documenter les interventions majeures pour faciliter les opérations futures.

---

### **Périmètre inclus**

La maintenance couvre :

* **L’application Django** (API, logique du quiz, templates).
* **La base de données PostgreSQL** (structure, index, purge, intégrité).
* **L’infrastructure Docker** (conteneurs, volumes, réseau interne).
* **Le reverse proxy Nginx** (HTTPS, headers, certificats).
* **Les logs applicatifs et système** (Django, Nginx, purge).
* **Les dépendances Python et système** (Django, DRF, libs).
* **La supervision technique** (endpoint `/api/health`, erreurs 4xx/5xx).

---

### **Hors périmètre**

Ne sont **pas** considérés comme maintenance technique :

* la création ou mise à jour des **questions du quiz** (contenu éditorial),
* la gestion du **poste totem** (système Windows/Linux, écrans, réseau),
* les retours d’usage non techniques (préférences graphiques, ergonomie),
* les évolutions fonctionnelles (nouvelles règles, nouveaux niveaux).

---

## Supervision & monitoring

L’objectif de la supervision est de détecter rapidement tout comportement anormal du système afin de garantir une **disponibilité maximale** et une **expérience de jeu sans interruption**.
Le dispositif reste volontairement **léger**, adapté à un projet interne mais suffisamment complet pour réagir vite.

---

### Ce qui est surveillé

#### Disponibilité du service

* Endpoint **`/api/health`** : vérifie que Django répond et que PostgreSQL est accessible.
* Réponse attendue : `{"status": "ok"}` en < 200 ms.

#### Erreurs applicatives

* Erreurs **4xx** et **5xx** dans :
  * `nginx/error.log`
  * logs Django (handlers tournants)
* Points critiques : `/api/scores` (soumission), `/api/leaderboard`.

#### Performances

* Temps de réponse :
  * sur le classement (tri DB),
  * sur la soumission (validation + insert).
* Volume des fichiers statiques (images, scripts).

#### Base de données

* Taille du volume PostgreSQL,
* Vérification que la purge quotidienne a bien exécuté,
* Absence de verrouillage anormal.

---

### Outils et sources d’information

* **Logs Nginx** (access + error) : détection erreurs HTTP, anomalie de trafic.
* **Logs Django** (format JSON minimal) : erreurs métier, exceptions non capturées.
* **Logs de purge** : une ligne par jour confirmant la suppression.
* **Matomo** *(optionnel, anonymisé)* : permet de repérer les pages ouvertes et les éventuels comportements bloqués.
* **Console Docker** :

  * `docker compose logs -f web`
  * `docker compose logs -f db`

Ces outils suffisent pour diagnostiquer 99 % des incidents possibles dans une architecture simple et isolée.

---

### Fréquence de supervision

#### Pendant l’utilisation active du quiz (événement ou campagne interne)

* Vérification rapide **quotidienne** :

  * `/api/health`,
  * absence d’erreurs 500,
  * purge de la veille OK.

#### En dehors des périodes d’usage

* Vérification **hebdomadaire légère** :

  * statut du serveur,
  * absence de volumes qui gonflent.

#### Avant chaque mise à disposition

* Test complet du flux : Accueil → Quiz → Score → Classement.
* Vérification des certificats TLS (date d’expiration).
* Vérification que Docker démarre sans erreurs.

---

### Résultat attendu

* Détection rapide de toute panne.
* Logs faciles à consulter et à comprendre.
* Supervision suffisante pour une application interne à faible charge.
* Prévention proactive plutôt que réaction tardive.

---

## Gestion des incidents

La gestion des incidents vise à rétablir rapidement le fonctionnement normal de l’application en cas de panne, d’erreur critique ou de comportement inattendu.
Le processus est simple, efficace et adapté à une exploitation interne.

---

### Typologie des incidents possibles

#### Incidents applicatifs

* Django retourne des erreurs **500** lors de `/api/scores` ou `/api/leaderboard`.
* Comportement incorrect dans le quiz (ex : chrono bloqué, feedback absent).

#### Incidents réseau / serveur

* Le reverse proxy ou HTTPS ne répond plus.
* Certificat expiré ou mal chargé.
* Docker ne démarre plus.

#### Incidents base de données

* PostgreSQL inaccessible.
* Problème d’intégrité (index manquant, table verrouillée).
* Purge quotidienne non exécutée.

#### Incidents liés au poste totem

##### *(non techniques côté backend)*

* Navigateur figé, mode kiosque sorti, cache corrompu.

---

### Processus standard de gestion

#### 1. Détection

Repérée via :

* logs (Nginx, Django, Docker),
* `/api/health`,
* comportement de l’UI,
* retour utilisateur (enfants, encadrants).

#### 2. Diagnostic rapide

Objectif : identifier *où* ça bloque.

Checklist :

* API répond-elle ? → `/api/health`
* Y a-t-il des erreurs 500 ? → `docker compose logs web`
* Base de données up ? → `docker compose logs db`
* Certificat valide ? → `curl -v https://...`

Astuce :
souvent, **80 %** des problèmes viennent :

* d’une purge non exécutée,
* d’une mauvaise variable d’environnement,
* d’un conteneur PostgreSQL stoppé.

#### 3. Correction

Actions typiques :

* **Redémarrage propre de la stack**

  ```bash
  docker compose down
  docker compose up -d
  ```

* Reconstruction de l’image en cas de bug de code.
* Re-création du conteneur DB (sans perte de données durables, puisque les scores sont volatiles).
* Correction d’un bug Django / DRF suivie d’un redéploiement.

#### 4. Vérification post-correction

* Test complet du flux (Accueil → Quiz → Score → Classement).
* Vérification de la purge du jour.
* Vérification du reverse proxy (`nginx -t` si besoin).

#### 5. Journalisation minimale

Une note rapide (fichier `/docs/incidents.md`) :

* date,
* cause,
* action corrective,
* solution durable éventuelle.

But : éviter de revivre le même incident 6 mois plus tard.

---

### Critères de résolution

Un incident est considéré comme résolu lorsque :

* l’API répond correctement,
* la base est accessible,
* aucune erreur critique ne réapparaît dans les logs,
* une partie complète peut être jouée sans anomalie.

---

### Résultat attendu

* Rétablissement du service en quelques minutes.
* Processus simple, reproductible, sans risque pour les données.
* Historique minimal des problèmes pour améliorer la prévention.

---

## Mises à jour & sécurité

La mise à jour régulière des composants applicatifs et de l’infrastructure garantit la **stabilité**, la **compatibilité** et la **sécurité** du projet.
Étant donné que l’application est utilisée ponctuellement (campagnes internes), la stratégie repose sur un entretien **avant chaque période d’utilisation** + une **revue annuelle**.

---

### Principes généraux

* Ne jamais mettre à jour directement en production.
* Toujours tester en local ou sur un environnement isolé Docker.
* Mettre à jour **peu, mais bien**, uniquement ce qui est utile ou sécurisé.
* Documenter succinctement les mises à jour importantes.

---

### Mises à jour applicatives (Django, DRF, Python)

#### Fréquence

* **Avant chaque campagne** → vérifier s’il existe des patchs critiques.
* **Annuellement** → mise à niveau globale (Python, Django, DRF).

#### Processus

1. Pull du dépôt.
2. Mise à jour des dépendances dans `requirements.txt`.
3. Lancement des tests (`pytest`).
4. Vérification visuelle du flux complet (Accueil → Quiz → Score → Classement).
5. Reconstruction Docker → déploiement.

#### Critères d’acceptation

* Aucun avertissement critique dans les logs.
* Compatibilité Django/DRF confirmée.
* Tests automatisés OK.

---

### Mises à jour serveur (OS, Docker, Nginx, certifs)

#### Système & conteneurs

* Mise à jour **OS + Docker Engine + Docker Compose** :
  → **1 fois/an**, ou avant usage si la version est trop ancienne.

#### Nginx

* Mise à jour au besoin uniquement (failles de sécurité).

#### Certificats TLS

* Vérification systématique avant chaque campagne :

  * expiration,
  * renouvellement automatique Certbot,
  * absence d’erreur dans `nginx -t`.

---

### Base de données PostgreSQL

Même si les données sont volatiles, la DB nécessite un entretien minimal :

* Mise à jour mineure PostgreSQL : **annuelle**.
* Vérification des index : **avant chaque campagne**.
* Reconstruction possible à tout moment via les migrations Django (structure uniquement).

---

### Mises à jour de sécurité des dépendances

Automatisation recommandée (via CI ou manuel) :

```bash
pip-audit
```

Fréquence :

* **mensuelle** ou **avant campagne**.

Critères :

* priorité aux patches critiques (failles RCE, vulnérabilités réseau).
* mise à jour immédiate si une CVE concerne Django ou DRF.

---

### Procédure de mise à jour sécurisée

1. Mettre à jour en local.
2. Exécuter tests + lint.
3. Lancer l’application dans Docker local.
4. Tester tout le flux du quiz.
5. Déployer sur serveur :

   ```bash
   docker compose pull
   docker compose up -d --build
   ```

6. Vérifier `/api/health` + logs Nginx/Django.

---

### Résultat attendu

* Un environnement sécurisé, sans faille connue.
* Des versions maîtrisées, cohérentes et testées.
* Un système stable avant chaque utilisation publique.

---

## Entretien de la base de données

La base PostgreSQL stocke uniquement des données **volatiles** (scores du jour).
L’entretien porte donc principalement sur la **structure**, la **performance des index**, et la **bonne exécution des tâches quotidiennes**.

---

### Objectifs

* Garantir une base **saine, rapide et légère**.
* Vérifier l’intégrité des contraintes (unicité, bornes, FK).
* Assurer la bonne exécution de la **purge quotidienne**.
* Prévenir les blocages éventuels (verrous, tables gonflées).

---

### Entretien régulier

#### 1. Vérification quotidienne (automatisée)

* Contrôle que la purge du jour précédent a bien été effectuée.
* Journalisation d’une ligne « Purge OK » dans les logs.

#### 2. Entretien mensuel

* Exécution d’un **`VACUUM ANALYZE`** sur la table `game` :

  ```bash
  docker exec db psql -U user -c "VACUUM ANALYZE game;"
  ```

* Vérification de la présence et du fonctionnement des index :

  * `idx_game_ranking_points`
  * `idx_game_ranking_time`
* Monitoring de la taille du volume PostgreSQL.

#### 3. Entretien annuel

* Mise à jour PostgreSQL (version mineure).
* Réanalyse complète du schéma via `ANALYZE`.

---

### Gestion de la purge quotidienne

La purge supprime toutes les données dont `day_date` ≠ aujourd’hui :

* exécutée automatiquement à **00:00 UTC+4**,
* via une commande Django dédiée,
* idempotente : exécutable plusieurs fois sans risque.

Vérifications associées :

* nombre de lignes supprimées,
* absence de verrouillage sur la table,
* présence d’une entrée `day(day_date)` pour la nouvelle journée.

---

### Reconstruction de la base en cas d’incident

En cas de corruption, crash ou migration impossible :

1. Suppression du volume DB :

   ```bash
   docker compose down -v
   ```

2. Recréation du conteneur PostgreSQL.
3. Application des migrations Django :

   ```bash
   python manage.py migrate
   ```

4. Vérification du schéma (types ENUM, unique constraint, index).

💡 Aucun risque de perte fonctionnelle :
la base **ne stocke rien de durable**.

---

### Sauvegarde structurelle

Même si les données ne doivent pas être sauvegardées, le **schéma** l’est :

* dump structurel mensuel :

  ```bash
  pg_dump --schema-only -U user dbname > schema_backup.sql
  ```

* stocké dans un dossier sécurisé non exposé.

---

### Résultat attendu

* Base propre, indexée, performante.
* Purge fiable et traçable.
* Structure facilement reconstruite sans impact fonctionnel.

---
