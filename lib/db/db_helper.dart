import 'package:appbook2/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// Liste observable des livres (notifie les changements)
ValueNotifier<List<Book>> bookList = ValueNotifier([]);

// Instance de la base de données
late Database _db;

// Initialisation de la base de données SQLite
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'appbook2_db', // Nom de la base de données
    version: 1, // Version de la base de données
    onCreate: (Database db, version) async {
      // Création de la table "books" avec les colonnes spécifiées
      await db.execute('CREATE TABLE books('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,' // Clé primaire auto-incrémentée
          'title TEXT,' // Colonne pour le titre
          'author TEXT,' // Colonne pour l'auteur
          'genre TEXT,' // Colonne pour le genre
          'publicationYear INTEGER,' // Colonne pour l'année de publication
          'summary TEXT,' // Colonne pour le résumé
          'image TEXT' // Colonne pour l'image
          ')');
    },
  );
  print("Database initialized successfully"); // Message de succès
}

// Récupère tous les livres depuis la base de données
Future<void> getBook() async {
  final result = await _db.rawQuery("SELECT * FROM books"); // Exécution de la requête SQL
  print('All Books data: $result'); // Affiche les données récupérées
  bookList.value.clear(); // Vide la liste actuelle
  for (var map in result) {
    final books = Book.fromMap(map); // Convertit chaque map en objet Book
    bookList.value.add(books); // Ajoute le livre à la liste
  }
  bookList.notifyListeners(); // Notifie les observateurs
}

// Ajoute un nouveau livre dans la base de données
Future<void> addBook(Book value) async {
  try {
    await _db.rawInsert(
      'INSERT INTO books(title, author, genre, publicationYear, summary, image) VALUES(?, ?, ?, ?, ?, ?)', // Requête d'insertion
      [
        value.title,
        value.author,
        value.genre,
        value.publicationYear,
        value.summary,
        value.image
      ],
    );
    getBook(); // Met à jour la liste après l'insertion
  } catch (e) {
    print('Error inserting data: $e'); // Affiche une erreur si l'insertion échoue
  }
}

// Modifie les informations d'un livre existant
Future<void> editBook(
    id, title, author, genre, publicationYear, summary, image) async {
  final dataflow = {
    'title': title,
    'author': author,
    'genre': genre,
    'publicationYear': publicationYear,
    'summary': summary,
    'image': image
  }; // Données mises à jour
  await _db.update('books', dataflow, where: 'id = ?', whereArgs: [id]); // Mise à jour dans la base
  getBook(); // Met à jour la liste après modification
}

// Supprime un livre de la base de données
Future<void> deleteBook(id) async {
  await _db.delete('books', where: 'id = ?', whereArgs: [id]); // Suppression selon l'identifiant
  getBook(); // Met à jour la liste après suppression
}