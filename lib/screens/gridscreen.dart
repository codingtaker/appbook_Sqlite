import 'dart:io'; // Permet d'accéder aux fichiers locaux

import 'package:appbook2/db/db_helper.dart'; // Helper pour interagir avec la base de données
import 'package:appbook2/screens/bookdetail.dart'; // Écran des détails d'un livre
import 'package:flutter/material.dart'; // Bibliothèque Flutter pour créer des interfaces utilisateur

// Widget affichant une grille de livres
class bookListGridView extends StatelessWidget {
  const bookListGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // Écoute les modifications de la liste des livres
      valueListenable: bookList,
      builder: (context, value, child) {
        return GridView.builder(
          // Définit les propriétés de la grille
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Nombre de colonnes dans la grille
          ),
          itemCount: value.length, // Nombre total d'éléments dans la grille
          itemBuilder: (context, index) {
            final book = value[index]; // Récupère les données d'un livre à l'index donné

            // Affichage de chaque carte représentant un livre
            return Card(
              margin: const EdgeInsets.all(4), // Espacement autour de la carte
              elevation: 1, // Hauteur de l'ombre sous la carte
              child: InkWell(
                // Permet d'ajouter une action au clic
                onTap: () {
                  // Navigue vers l'écran des détails d'un livre
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctr) => BookDetails(bookdetails: book), // Passe les détails du livre
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrage vertical des éléments
                  children: [
                    // Affichage de l'image du livre dans un avatar circulaire
                    CircleAvatar(
                      backgroundImage: FileImage(
                        File(book.image), // Récupère l'image du fichier
                      ),
                      radius: 40, // Taille du cercle
                    ),
                    const SizedBox(height: 12), // Espacement sous l'image

                    // Affichage du titre du livre
                    Text(book.title),
                    const SizedBox(height: 4), // Espacement entre les textes

                    // Affichage de l'auteur du livre
                    Text(book.author),
                    const SizedBox(height: 4), // Espacement entre les textes

                    // Affichage du genre du livre
                    Text(book.genre),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
