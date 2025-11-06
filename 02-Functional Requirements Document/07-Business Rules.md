# BUSINESS RULES

**BR-01 — Niveaux & parties.** Une partie = 10 questions ; niveau choisi parmi *Facile / Intermédiaire / Avancé*.  
**BR-02 — Tirage aléatoire.** 10 questions tirées au sort dans le pool du niveau choisi, sans répétition dans la partie.  
**BR-03 — Formats par niveau.**

* Facile : QCM **3** choix **en images** + Vrai/Faux (visuels quand pertinent).
* Intermédiaire : QCM **4** choix (texte).
* Avancé : QCM **4** choix (texte) + Vrai/Faux (texte).

**BR-04 — Barème.** +1 point par bonne réponse ; pas de malus.  
**BR-05 — Chrono.** Chronomètre **global** du début à la fin de la partie (affiché en continu).  
**BR-06 — Feedback.** Après chaque réponse, affichage **immédiat** de la bonne réponse + message réussite/échec.  
**BR-07 — Score final.** À la fin : affichage du **score total** et du **temps total**.  
**BR-08 — Pseudo.** Longueur **3–12** ; caractères autorisés `a–z 0–9 _ -` (accents tolérés) ; **filtrage mots interdits** ; **unicité par jour** (heure locale Réunion).  
**BR-09 — Soumission.** Un envoi score/temps/pseudo par partie ; validation **serveur** du chrono (jeton de début/fin, horodatage).  
**BR-10 — Classements journaliers.** Deux classements **distincts** (Points / Temps), **reset à 00:00** heure locale Réunion ; affichage **Top 100**.  
**BR-11 — Règles de tri.**

* Classement **Points** : tri décroissant points, puis **temps croissant** (tie-break).
* Classement **Temps** : tri par **temps croissant**, puis points décroissants (tie-break).

**BR-12 — Consultation.** L’écran « Classement » interroge l’API à l’ouverture et **à chaque changement d’onglet** Points/Temps.  
**BR-13 — Données & rétention.** Les scores/pseudos sont **conservés uniquement pour la journée courante**, puis purgés au reset.  
**BR-14 — Accessibilité.** Contrastes **AA**, police **dyslexia-friendly**, boutons larges ; animations actives (non désactivables).  
**BR-15 — Conformité enfant.** Pas de compte, pas d’email, **aucun cookie non essentiel**, analytics **anonymisés** (événements agrégés).  
**BR-16 — Périmètre technique.** Desktop navigateur (totem/PC) ; jeu **en ligne** uniquement.  
**BR-17 — Résilience.** En cas d’erreur API au moment de la soumission, message d’échec + **réessai manuel** ; la partie reste terminée localement.  
**BR-18 — Contenu.** Questions fixes stockées en **JSON** (texte, options, réponses, références d’images, niveau, type), assets dans `/assets`.

---
