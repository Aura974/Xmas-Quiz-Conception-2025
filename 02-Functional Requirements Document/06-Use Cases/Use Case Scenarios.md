# USE CASE SCENARIOS

Ci-dessous, les scénarios principaux, concis et opérationnels, alignés sur les diagrammes de cas d'utilisation.

---

## UC-A — Jouer une partie

* **Acteur principal** : Enfant (Joueur)
* **Préconditions** : Application chargée ; connexion réseau OK ; questions disponibles pour le niveau.
* **Déclencheur** : Le joueur clique sur « Jouer ».

### Flux principal (succès)

1. Le joueur **sélectionne un niveau** (facile / intermédiaire / avancé).
2. Le système **initialise la partie** (chrono global, seed aléatoire, compteur question=1).
3. Le système **tire 10 questions** aléatoires du niveau.
4. Pour chaque question (1 → 10) :
   4.1. Le système **affiche l’énoncé** (format selon niveau : image/texte ; V/F ou QCM 3/4 choix).
   4.2. Le joueur **sélectionne une réponse**.
   4.3. Le système **évalue** la réponse (barème 1 point / bonne).
   4.4. Le système **affiche la correction** et un **feedback immédiat** (succès/échec).
   4.5. Passage à la question suivante.
5. À la fin, le système **arrête le chrono**, **calcule le score final** et **affiche l’écran de fin** (score, temps, CTA « Saisir pseudo » / « Rejouer »).

### Flux alternes / exceptions

* A1. **Déconnexion temporaire** pendant la partie : la partie continue ; un bandeau d’info s’affiche ; aucune soumission serveur n’est tentée avant la fin.
* A2. **Rafraîchissement ou fermeture** de l’onglet : la partie en cours est **perdue** (pas de sauvegarde intermédiaire).
* A3. **Asset image manquant** (niveau facile) : fallback en **texte** de la réponse ; la question reste jouable.

**Postconditions** : Score et temps prêts pour la soumission ; l’utilisateur peut rejouer sans recharger la page.

---

## UC-B1 — Saisir pseudo & soumettre score

* **Acteur principal** : Enfant (Joueur)
* **Partenaires** : Service Classement (API)
* **Préconditions** : Une partie terminée (score, temps disponibles) ; réseau OK (sinon flux exception).
* **Déclencheur** : L’utilisateur clique « Saisir pseudo » sur l’écran de fin.

### Flux principal (succès)

1. Le joueur **saisit un pseudo**.
2. Le système applique le **filtrage** (longueur 3–12 ; caractères autorisés ; liste interdits ; normalisation).
3. Le système **vérifie l’unicité/jour** via l’API (UTC+4).
4. Si valide, le système **soumet score + temps + pseudo** à l’API.
5. L’API **enregistre** et **retourne confirmation**.
6. Le système **confirme l’envoi** et propose **« Voir le classement »**.

### Flux alternes / exceptions

* B1-E1. **Pseudo invalide** (filtrage) → message d’erreur ; retour champ pseudo.
* B1-E2. **Pseudo déjà pris (jour courant)** → message d’erreur ; proposer variantes (ex. suffixe chiffré).
* B1-E3. **Erreur réseau / API** → message **« Échec d’envoi »** + bouton **« Réessayer »** (re-tentatives manuelles, pas de boucle auto).
* B1-E4. **Timeout API** → message d’erreur ; le joueur peut **réessayer** ou **annuler** (le score n’est pas enregistré).

**Postconditions** : Si succès, le score du joueur est présent dans le classement du jour (points ou temps, selon vue consultée ensuite).

---

## UC-B2 — Consulter le classement (Points / Temps)

* **Acteurs** : Enfant (Joueur), Parent/Encadrant
* **Partenaire** : Service Classement (API)
* **Préconditions** : Accès à l’écran « Classement » ; réseau OK préféré.
* **Déclencheur** : L’utilisateur ouvre la page « Classement ».

### Flux principal (succès)

1. Le système **demande à l’API** le **classement Points (Top 100)** ou **Temps (Top 100)** selon l’onglet actif.
2. L’API **retourne la liste du jour** (réinitialisée à 00:00 UTC+4).
3. Le système **affiche** : rang, pseudo, score/temps, éventuellement niveau.
4. L’utilisateur peut ensuite cliquer sur “Rejouer”, ce qui le ramène à l’écran d’accueil.

### Flux alternes / exceptions

* B2-A1. **Aucune donnée du jour** → message « Aucun score pour l’instant ».
* B2-E1. **Erreur réseau / API** → message non bloquant + bouton **« Réessayer »**.
* B2-A2. **Changement d’onglet Points/Temps** → nouvelle requête API, même logique.

**Postconditions** : Classement du jour visible ; l’utilisateur peut relancer une partie.

---

## UC-C — Rejouer une partie (raccourci)

* **Acteur** : Enfant (Joueur)
* **Préconditions** : Une partie terminée ou l’écran d’accueil ouvert.
* **Déclencheur** : Clic sur « Rejouer ».

### Flux principal

1. Le système **réinitialise l’état** (chrono, sélection de niveau, seed).
2. Retour au **flux UC-A** étape 1.

**Exceptions** : N/A (action locale, pas d’appel API).
**Postconditions** : Nouvelle partie lancée.

---
