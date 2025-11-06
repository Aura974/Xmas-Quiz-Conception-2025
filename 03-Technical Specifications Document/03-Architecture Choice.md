# CHOSEN ARCHITECTURE

Le projet **Quiz de Noël** adopte une **architecture 3-tiers classique (Three-Tier Architecture)**, parfaitement adaptée à une application web interne légère :

| **Couche**                            | **Rôle**                                                                                        | **Implémentation prévue**                                         |
| :------------------------------------ | :---------------------------------------------------------------------------------------------- | :---------------------------------------------------------------- |
| **1. Présentation (Front-End)**       | Gère l’interface utilisateur, le quiz, le chrono, les feedbacks et le classement.               | **Templates Django + JavaScript natif** exécutés côté navigateur. |
| **2. Logique applicative (Back-End)** | Fournit les API REST, valide les scores et gère les règles métier (classement, unicité, reset). | **Django + Django REST Framework**, exposé via HTTPS.             |
| **3. Données (Persistence)**          | Stocke les scores, les pseudos et la configuration des questions.                               | **PostgreSQL**, administré via le **Django ORM**.                 |

➡️ Cette architecture sépare clairement la **présentation**, la **logique métier** et la **persistance**, tout en restant **monolithique** (une seule application Django contenant à la fois les templates et les endpoints API).
Elle privilégie la **simplicité, la maintenabilité et la sécurité** dans un contexte à utilisateur unique ou faible trafic interne.

---

## 🖼️ Vue physique (schéma d’architecture déployée)

Voici une version graphique moderne de la **vue de déploiement physique**, telle qu’elle sera mise en place sur le réseau interne Nordev :

![alt text](<03-Architecture image.png>)

---
