class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  double progress; // No es final para poder actualizarlo
  final bool isDownloaded;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    this.progress = 0.0,
    this.isDownloaded = false,
  });

  // El método copyWith ya no es necesario si mutamos el estado directamente,
  // pero lo dejamos por si es útil en el futuro para otras propiedades.
  Book copyWith({
    bool? isDownloaded,
  }) {
    return Book(
      id: id,
      title: title,
      author: author,
      imageUrl: imageUrl,
      progress: progress,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
