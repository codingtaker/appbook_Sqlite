import 'dart:io';

import 'package:appbook2/db/db_helper.dart';
import 'package:appbook2/models/book_model.dart';
import 'package:appbook2/screens/bookdetail.dart';
import 'package:appbook2/screens/edit_book.dart';
import 'package:flutter/material.dart';


class BookList extends StatelessWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bookList,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final books = value[index];

            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 1,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(books.image),
                  ),
                ),
                title: Text(books.title),
                subtitle: Text(books.author),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Color.fromARGB(255, 0, 26, 255)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditBook(books: books),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 236, 16, 0)),
                      onPressed: () {
                        deletebooks(context, books);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctr) => BookDetails(bookdetails: books),
                  ));
                },
              ),
            );
          },
        );
      },
    );
  }

  void deletebooks(rtx, Book books) {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Supprimer le livre'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ce livre ?'),
          actions: [
            TextButton(
              onPressed: () {
                delectYes(context, books);
              },
              child: const Text('Oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(rtx);
              },
              child: const Text('Non'),
            ),
          ],
        );
      },
    );
  }

  void delectYes(BuildContext ctx, Book books) {
    deleteBook(books.id!); // Suppression basée sur l'ID du livre
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Le livre a été supprimé avec succès"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(ctx).pop(); // Ferme le dialogue
  }

}
