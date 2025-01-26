import 'dart:io';


import 'package:appbook2/db/db_helper.dart';
import 'package:appbook2/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditBook extends StatefulWidget {
  final books;

  const EditBook({super.key, required this.books});

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  String? updatedImagepath;


  final _formKey = GlobalKey<FormState>(); //  form key for the validation

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _dateController = TextEditingController();
  final _summaryController = TextEditingController();

  String? selectedGenre;


  final genresData = [
    {
      'nom': 'Romans (Fiction)',
    },
    {
      'nom': 'Non-fiction',
    },
    {
      'nom': 'Littérature Jeunesse',
    },
    {
      'nom': 'Autres Formats',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit book✍️'),
        actions: [
          IconButton(
            onPressed: () {
              EditBookclicked(
                context,
                widget.books,
              );
            },
            icon: const Icon(Icons.cloud_upload),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () => editphoto(context),
                        child: CircleAvatar(
                          backgroundImage: updatedImagepath != null
                              ? FileImage(File(updatedImagepath!))
                              : FileImage(File(widget.books.image)),
                          radius: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // title input field with validation
                  Row(
                    children: [
                      const Icon(Icons.abc_outlined),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: "Titre",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veillez entrer un titre';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // author input field with validation
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _authorController,
                          decoration: InputDecoration(
                            labelText: "Autheur",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veillez entrer un auteur';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // genre input field with validation
                  Row(
                    children: [
                      const Icon(Icons.category),
                      const SizedBox(width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: selectedGenre,
                              items: genresData.map((genre) {
                                return DropdownMenuItem<String>(
                                  value: genre['nom'] as String,
                                  child: Text(genre['nom'] as String),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGenre = value;
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                // Date input field with validation
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: "Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer une date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                //  Summary input field with validation
                  Row(
                    children: [
                      const Icon(Icons.class_outlined),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _summaryController,
                          decoration: InputDecoration(
                            labelText: "Résumé",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le résumé du livre';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.books.title;
    _authorController.text = widget.books.author;
    selectedGenre = widget.books.genre;
    _dateController.text = widget.books.publicationYear.toString();
    _summaryController.text = widget.books.summary;
    updatedImagepath = widget.books.image;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> geterimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      updatedImagepath = image.path.toString();
    });
  }

  Future<void> EditBookclicked(
      BuildContext context, Book books) async {
    if (_formKey.currentState!.validate()) {
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

      final publicationYear = int.tryParse(_dateController.text.trim());
        if (publicationYear == null) {
          // Gérer une erreur si la conversion échoue
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez entrer une année valide.')),
          );
          return;
        }

      final summary = _summaryController.text.toString();

      final updatedbooks = Book(
        id: books.id,
        title: title,
        author: author,
        genre: genre,
        publicationYear: publicationYear,
        summary: summary,
        image: updatedImagepath ?? books.image,
      );

      await editBook(
        books.id!,
        updatedbooks.title,
        updatedbooks.author,
        updatedbooks.genre,
        updatedbooks.publicationYear,
        updatedbooks.summary,
        updatedbooks.image,
      );

      // Refresh the data in the booksList widget.
      getBook();

      Navigator.of(context).pop();
    }
  }

  void editphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          title: const Text('Mettre à jour la photo'),
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    const Text('Choisir une photo '),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Choisir une image '),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.image,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
