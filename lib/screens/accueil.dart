// Importation des packages nécessaires
import 'package:appbook2/db/db_helper.dart';
import 'package:appbook2/screens/add_book.dart';
import 'package:appbook2/screens/booklist.dart';
import 'package:appbook2/screens/gridscreen.dart';
import 'package:appbook2/screens/searchscreen.dart';
import 'package:flutter/material.dart';

// Classe principale pour l'écran d'accueil
class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  int _selectedIndex = 0; // Index de l'élément sélectionné dans la barre de navigation
  int _viewMode = 0; // Mode d'affichage : 0 pour la grille, 1 pour la liste

  @override
  Widget build(BuildContext context) {
    getBook(); // Récupère les données des livres depuis la base de données
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 145, 0), // Couleur d'arrière-plan de l'AppBar
        elevation: 0, // Supprime l'ombre sous l'AppBar
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/profile.png'), // Image de profil par défaut
            backgroundColor: Colors.white,
          ),
        ),
        title: const Text(
          'Ma bibliothèque', // Titre de l'AppBar
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          // Bouton pour accéder à l'écran de recherche
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctxs) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search_rounded, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre pour basculer entre la vue grille et la vue liste
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton pour passer à la vue "grille"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _viewMode = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _viewMode == 0
                          ? const Color.fromARGB(255, 255, 145, 0) // Couleur active
                          : Colors.grey[200], // Couleur inactive
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: _viewMode == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Bouton pour passer à la vue "liste"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _viewMode = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _viewMode == 1
                          ? const Color.fromARGB(255, 255, 145, 0)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Bibliothèque',
                      style: TextStyle(
                        color: _viewMode == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contenu principal (grille ou liste en fonction du mode sélectionné)
          Expanded(
            child: _viewMode == 0
                ? const bookListGridView() // Vue en grille
                : const BookList(), // Vue en liste
          ),
        ],
      ),
      // Bouton flottant pour ajouter un nouveau livre
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 255, 145, 0),
        elevation: 0,
        onPressed: () {
          addBook(context); // Ouvre l'écran pour ajouter un livre
        },
        child: const Icon(Icons.add, size: 30),
      ),
      // Barre de navigation inférieure
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library_outlined),
            label: 'Bibliothèque',
          ),
        ],
        currentIndex: _selectedIndex, // Met en surbrillance l'élément sélectionné
        selectedItemColor: const Color.fromARGB(255, 255, 145, 0),
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index; // Met à jour l'index sélectionné
            _viewMode = index; // Met à jour le mode d'affichage
          });
        },
      ),
    );
  }

  // Ouvre l'écran pour ajouter un livre
  void addBook(BuildContext gtx) {
    Navigator.of(gtx).push(
      MaterialPageRoute(builder: (gtx) => const AddBook()),
    );
  }
}
