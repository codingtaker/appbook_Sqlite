import 'dart:io';

import 'package:appbook2/db/db_helper.dart';
import 'package:appbook2/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  File? image25; // Variable pour stocker l'image sélectionnée
  String? imagepath; // Chemin de l'image sélectionnée
  final _formKey = GlobalKey<FormState>(); // Clé pour gérer et valider le formulaire

  // Contrôleurs pour récupérer les données des champs de saisie
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _dateController = TextEditingController();
  final _summaryController = TextEditingController();
  
  String? selectedGenre; // Genre sélectionné par l'utilisateur

  // Liste des genres disponibles pour le Dropdown
  final List<Map<String, dynamic>> genresData = [
    {'nom': 'Romans (Fiction)'},
    {'nom': 'Non-fiction'},
    {'nom': 'Littérature Jeunesse'},
    {'nom': 'Autres Formats'},
  ];

  // Fonction pour sélectionner une date via un widget de sélection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Date par défaut
      firstDate: DateTime(1900), // Date minimale
      lastDate: DateTime(2101), // Date maximale
    );
    if (picked != null) {
      setState(() {
        // Formatage de la date sélectionnée
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book 📚'), // Titre de la page
        actions: [
          IconButton(
            onPressed: () {
              addbookclicked(context); // Sauvegarde du livre lors du clic
            },
            icon: const Icon(Icons.save_rounded),
          )
        ],
        centerTitle: true, // Centrage du titre dans l'AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey, // Association du formulaire à la clé de validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Widget pour afficher ou ajouter une photo de couverture
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: image25 != null
                          ? FileImage(image25!) // Affichage de l'image sélectionnée
                          : const AssetImage('assets/bookprofil.png')
                              as ImageProvider,
                      radius: 99,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          addphoto(context); // Ajouter une image via caméra ou galerie
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                        color: const Color.fromARGB(255, 0, 0, 0),
                        iconSize: 40,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Champ de saisie pour le titre du livre
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Titre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.abc_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrez un titre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Champ de saisie pour l'auteur
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _authorController,
                  decoration: InputDecoration(
                    labelText: "Auteur",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrez un auteur';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              
                // Liste déroulante pour sélectionner un genre
                DropdownButtonFormField<String>(
                  value: selectedGenre,
                  items: genresData.map((genre) {
                    return DropdownMenuItem<String>(
                      value: genre['nom'],
                      child: Text(genre['nom']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGenre = value; // Mise à jour du genre sélectionné
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Genre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner un genre.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Champ de saisie pour la date de publication
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Année de publication',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () => _selectDate(context), // Ouvre le sélecteur de date
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une année de publication.';
                    }
                    if (int.tryParse(value) == null || value.length != 4) {
                      return 'Veuillez entrer une année valide (ex. : 1900 - 2101).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
          
                // Champ de saisie pour le résumé
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _summaryController,
                  decoration: InputDecoration(
                    labelText: "Résumé",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.class_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrez le résumé du livre';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addbookclicked(mtx) async {
    if (_formKey.currentState!.validate() && image25 != null) {
      final title = _titleController.text.toUpperCase();
      final author = _authorController.text.toString();
      final genre = selectedGenre ?? '';

    // Vérification du genre
    if (genre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner un genre.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
        ),
      );
      return;
    }

      final date = _dateController.text.trim();
      final summary = _summaryController.text.toString();
      
      // Création de l'objet Book
      final bookData = Book(
        id: DateTime.now().millisecondsSinceEpoch, // Add a unique id
        title: title,
        author: author,
        genre: genre,
        publicationYear: int.parse(date),
        summary: summary,
        image: imagepath!,
      );

      // Ajout du livre à la base de données
      await addBook(bookData); // Use the correct function name addBook.

      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Livre ajouté avec succès"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );

    // Réinitialisation des champs
      setState(() {
        image25 = null;
        _titleController.clear();
        _authorController.clear();
        _dateController.clear();
        _summaryController.clear();
        selectedGenre = null;

      });
    } else {
      // Si l'image n'est pas sélectionnée
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une image.'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      image25 = File(image.path);
      imagepath = image.path.toString();
    });
  }

  void addphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Choisissez une image'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
