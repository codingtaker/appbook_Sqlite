import 'dart:io'; // Permet de gérer les fichiers locaux

import 'package:appbook2/db/db_helper.dart'; // Helper pour interagir avec la base de données
import 'package:appbook2/models/book_model.dart'; // Modèle pour représenter un livre
import 'package:appbook2/screens/bookdetail.dart'; // Écran des détails d'un livre
import 'package:flutter/material.dart'; // Bibliothèque Flutter pour les widgets et UI

// Écran permettant de rechercher des livres
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Book> finduser = []; // Liste contenant les résultats filtrés

  @override
  void initState() {
    super.initState();
    // Initialisation de la liste avec tous les livres disponibles
    finduser = bookList.value;
  }

  // Fonction pour filtrer la liste des livres en fonction d'un mot-clé
  void _runFilter(String enteredKeyword) {
    List<Book> result = [];
    if (enteredKeyword.isEmpty) {
      // Si aucun mot-clé n'est saisi, afficher tous les livres
      result = bookList.value;
    } else {
      // Filtrer les livres en fonction du titre ou de l'auteur
      result = bookList.value
          .where((books) =>
              books.title.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              books.author.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      // Mettre à jour la liste affichée avec les résultats du filtre
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Assure que l'interface est affichée dans une zone sûre
        child: ValueListenableBuilder<List<Book>>(
          valueListenable: bookList, // Écoute les modifications de la liste des livres
          builder: (context, bookListValue, child) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Champ de recherche
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      onChanged: (value) => _runFilter(value), // Applique le filtre en temps réel
                      decoration: const InputDecoration(
                        labelText: 'Search', // Libellé du champ de recherche
                        suffixIcon: Icon(Icons.search), // Icône de recherche
                      ),
                    ),
                  ),
                  // Liste des résultats filtrés
                  Expanded(
                    child: ListView.builder(
                      itemCount: finduser.length, // Nombre d'éléments dans la liste filtrée
                      itemBuilder: (context, index) {
                        final finduserItem = finduser[index]; // Livre actuel
                        return Card(
                          elevation: 4, // Ombre sous la carte
                          margin: const EdgeInsets.symmetric(vertical: 10), // Espacement vertical
                          child: ListTile(
                            leading: CircleAvatar(
                              // Image circulaire du livre
                              backgroundImage:
                                  FileImage(File(finduserItem.image)),
                            ),
                            title: Text(finduserItem.title), // Titre du livre
                            subtitle: Text('AUTEUR : ${finduserItem.author}'), // Auteur du livre
                            onTap: () {
                              // Naviguer vers l'écran des détails du livre
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (ctr) =>
                                    BookDetails(bookdetails: finduserItem),
                              ));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
