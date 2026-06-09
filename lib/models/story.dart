import './chapter.dart';

class Story {
  final String id;
  final String authorId;
  String title;
  String synopsis;
  String imageUrl;
  List<Chapter> chapters;

  Story({
    required this.id,
    required this.authorId,
    required this.title,
    this.synopsis = '',
    this.imageUrl = '',
    List<Chapter>? chapters,
  }) : chapters = chapters ?? [];
}
