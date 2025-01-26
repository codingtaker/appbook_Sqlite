import 'dart:io'; // Permet de manipuler les fichiers locaux
import 'package:appbook2/models/book_model.dart'; // Modèle de données pour un livre
import 'package:appbook2/screens/edit_book.dart'; // Écran pour éditer un livre
import 'package:flutter/material.dart'; // Bibliothèque Flutter pour les widgets UI

// Classe représentant les détails d'un livre
class BookDetails extends StatelessWidget {
  const BookDetails({Key? key, required this.bookdetails}) : super(key: key);

  final Book bookdetails; // Objet contenant les informations du livre

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Barre d'en-tête avec le titre
        title: const Text('Détails du Livre'),
        centerTitle: true, // Centrer le titre dans la barre
        backgroundColor: Color.fromARGB(255, 255, 145, 0), // Couleur de l'en-tête
      ),
      body: SingleChildScrollView(
        // Permet le défilement si le contenu dépasse la taille de l'écran
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espacement autour du contenu
          child: Card(
            elevation: 5, // Ajoute une ombre pour mettre en relief la carte
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Coins arrondis
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0), // Marges internes de la carte
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centrage horizontal
                children: [
                  // Affichage de l'image du livre
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Coins arrondis de l'image
                    child: Image.file(
                      File(bookdetails.image), // Chemin de l'image depuis le fichier
                      width: 200, // Largeur de l'image
                      height: 200, // Hauteur de l'image
                      fit: BoxFit.cover, // Remplir le conteneur en conservant les proportions
                    ),
                  ),
                  const SizedBox(height: 20), // Espacement vertical

                  // Affichage du titre du livre
                  Text(
                    bookdetails.title,
                    style: const TextStyle(
                      fontSize: 28, // Taille de la police
                      fontWeight: FontWeight.bold, // Mettre en gras
                      color: Color.fromARGB(255, 255, 145, 0), // Couleur orange
                    ),
                    textAlign: TextAlign.center, // Texte centré
                  ),
                  const SizedBox(height: 10), // Espacement vertical

                  // Affichage du nom de l'auteur
                  Text(
                    'par ${bookdetails.author}', // Auteur du livre
                    style: const TextStyle(
                      fontSize: 20, // Taille de la police
                      fontStyle: FontStyle.italic, // Style en italique
                      color: Colors.black87, // Couleur noire atténuée
                    ),
                    textAlign: TextAlign.center, // Texte centré
                  ),
                  const Divider(
                    height: 40, // Espacement vertical pour la ligne
                    thickness: 1, // Épaisseur de la ligne
                    color: Color.fromARGB(255, 160, 160, 160), // Couleur de la ligne
                  ),

                  // Affichage du genre du livre
                  Row(
                    children: [
                      const Icon(Icons.category, color: Color.fromARGB(255, 255, 145, 0)), // Icône
                      const SizedBox(width: 10), // Espacement horizontal
                      Text(
                        'Genre : ${bookdetails.genre}', // Genre du livre
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15), // Espacement vertical

                  // Affichage de l'année de publication
                  Row(
                    children: [
                      const Icon(Icons.date_range, color: Color.fromARGB(255, 255, 145, 0)), // Icône
                      const SizedBox(width: 10), // Espacement horizontal
                      Text(
                        'Année de publication : ${bookdetails.publicationYear}', // Année de publication
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15), // Espacement vertical

                  // Affichage du résumé du livre
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alignement vertical
                    children: [
                      const Icon(Icons.book, color: Color.fromARGB(255, 255, 145, 0)), // Icône
                      const SizedBox(width: 10), // Espacement horizontal
                      Expanded(
                        // Permet d'éviter le dépassement du texte
                        child: Text(
                          'Résumé : ${bookdetails.summary}', // Résumé du livre
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Espacement vertical

                  // Bouton pour modifier les détails du livre
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigue vers l'écran d'édition
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditBook(books: bookdetails), // Passe les données du livre
                      ));
                    },
                    icon: const Icon(Icons.edit), // Icône de modification
                    label: const Text('Modifier'), // Libellé du bouton
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 212, 133, 14), // Couleur du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Coins arrondis
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
