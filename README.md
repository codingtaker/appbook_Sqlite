# appbook2

# Application de Gestion de Bibliothèque Personnelle

## 🎯Description du Projet

Cette application mobile permet de gérer une bibliothèque personnelle de manière intuitive et efficace. Développée avec Flutter et SQLite, elle offre les fonctionnalités nécessaires pour organiser, consulter et maintenir une collection de livres.

---

## ✨ Fonctionnalités Principales

1. **Ajouter un Livre**

   - Permet de saisir les informations d'un livre (titre, auteur, genre, année de publication, résumé).
   - Une image est obligatoire pour représenter la couverture du livre.

2. **Consulter les Livres**

   - Affiche les livres enregistrés sous forme de liste ou de grille.
   - Accéder aux détails d'un livre (titre, auteur, genre, année de publication, résumé, couverture).

3. **Mettre à Jour un Livre**

   - Modifier les informations d'un livre existant.

4. **Supprimer un Livre**

   - Supprimer un livre de la base de données.

---

## 🧱Structure du Projet

Voici la structure du répertoire du projet :

```
lib/
├── db/
│   ├── db_helper.dart      # Gestion de la base de données SQLite.
├── models/
│   ├── book_model.dart     # Modèle de données pour les livres.
├── screens/
│   ├── accueil.dart        # Écran d'accueil de l'application.
│   ├── add_book.dart       # Écran pour ajouter un nouveau livre.
│   ├── bookdetail.dart     # Écran des détails d'un livre.
│   ├── edit_book.dart      # Écran pour modifier les informations d'un livre.
│   ├── gridscreen.dart     # Affichage des livres sous forme de grille.
│   ├── searchscreen.dart   # Écran pour rechercher des livres.
│   ├── splash_home.dart    # Écran de démarrage (Splash Screen).
├── main.dart               # Point d'entrée principal de l'application.
```

---

## Détails des Composants

### 1. **Base de Données (SQLite)**

- Gérée dans `db/db_helper.dart`.
- Création de la table `books` avec les colonnes suivantes :
  - **id** : Identifiant unique du livre (généré automatiquement).
  - **title** : Titre du livre.
  - **author** : Auteur du livre.
  - **genre** : Genre du livre.
  - **publicationYear** : Année de publication.
  - **summary** : Résumé du livre.
  - **image** : Chemin de l'image de couverture.

### 2. **Modèle de Données**

- Situé dans `models/book_model.dart`.
- Représente un livre avec ses propriétés et fournit une méthode `fromMap` pour convertir les données de la base en objet `Book`.

### 3. **Interfaces Utilisateur**

#### **accueil.dart**

- Écran principal qui affiche les options pour naviguer entre les fonctionnalités (liste des livres, ajout de livre, etc.).

#### **add\_book.dart**

- Formulaire pour ajouter un nouveau livre.

#### **bookdetail.dart**

- Affiche les détails d'un livre sélectionné.

#### **edit\_book.dart**

- Permet de modifier les informations d'un livre.

#### **gridscreen.dart**

- Affiche les livres sous forme de grille pour une meilleure visualisation.

#### **searchscreen.dart**

- Recherche de livres par titre ou auteur.

#### **splash\_home.dart**

- Affiche un écran de démarrage pendant que l'application se charge.

---

## Installation et Utilisation

### Prérequis

- Flutter SDK installé.
- Un émulateur ou un appareil physique configuré pour exécuter l'application.

### Instructions

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/codingtaker/appbook_Sqlite.git
   ```
2. Naviguez dans le répertoire du projet :
   ```bash
   cd appbook_Sqlite
   ```
3. Installez les dépendances :
   ```bash
   flutter pub get
   ```
4. Lancez l'application :
   ```bash
   flutter run
   ```

---

## Améliorations Futures Possible

- Ajouter une fonctionnalité pour classer les livres par genre ou année de publication.
- Intégrer une API pour rechercher et ajouter des livres depuis une base de données en ligne.
- Ajouter un thème sombre pour l'application.
- Permettre l'exportation et l'importation de la base de données pour sauvegarder ou partager la bibliothèque.

---

## 🎞️Captures vidéo


![DemoappBook1](https://github.com/user-attachments/assets/74a587dd-91dc-4efe-8086-77b0b0be1369)

![DemoappBook2](https://github.com/codingtaker/appBook/issues/2#issue-2811638577)

---

## 💡 Contribuer

Les contributions sont les bienvenues ! Si vous souhaitez améliorer l'application ou signaler des problèmes :
1. Forkez ce dépôt.
2. Créez une branche pour vos modifications :
   ```bash
   git checkout -b feature/amélioration
   ```
3. Soumettez une Pull Request avec une description claire de vos modifications.

---

## Auteur

Ce projet a été développé par ALLAGLO Benicio. N'hésitez pas à me contacter pour toute question ou suggestion !

Contact : [benicioallaglo@gmail.com](mailto:benicioallaglo@gmail.com)

---

## Licence
Ce projet est sous licence [MIT](LICENSE). Vous êtes libre de l'utiliser, le modifier et le distribuer avec attribution.

# appBook_Sqlite

# appbook_Sqlite
