
class Chapter {
  final String id;
  String title;
  String content;
  bool isPublished;

  Chapter({
    required this.id,
    required this.title,
    this.content = '',
    this.isPublished = false,
  });
}
