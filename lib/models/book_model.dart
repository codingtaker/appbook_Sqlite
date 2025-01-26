// Classe représentant un livre avec ses propriétés
class Book {
  int? id; // Identifiant unique du livre (optionnel)
  final String title; // Titre du livre
  final String author; // Auteur du livre
  final String genre; // Genre littéraire
  final int publicationYear; // Année de publication
  final String summary; // Résumé ou description du livre
  final String image; // URL ou chemin de l'image associée au livre

  // Constructeur de la classe Book
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.publicationYear,
    required this.summary,
    required this.image,
  });

  // Méthode pour convertir une map (issue de la base de données) en objet Book
  static Book fromMap(Map<String, Object?> map) {
    // Conversion des champs de la map en types correspondants
    final id = map['id'] as int;
    final title = map['title'] as String;
    final author = map['author'] as String;
    final genre = map['genre'] as String;
    final publicationYear = map['publicationYear'] as int;
    final summary = map['summary'] as String;
    final image = map['image'] as String;

    // Retourne une instance de Book avec les données extraites
    return Book(
      id: id,
      title: title,
      author: author,
      genre: genre,
      publicationYear: publicationYear,
      summary: summary,
      image: image,
    );
  }
}