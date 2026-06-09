import 'package:flutter/material.dart';
import 'models/book.dart';
import 'models/story.dart';
import 'models/chapter.dart';

class StoryService extends ChangeNotifier {
  static final StoryService _instance = StoryService._internal();
  factory StoryService() => _instance;
  StoryService._internal();

  final List<Book> _currentReadings = [];
  final List<Book> _archivedBooks = [];
  final Map<String, List<Book>> _readingLists = {};
  final List<Story> _publishedStories = [];

  List<Book> get currentReadings => _currentReadings;
  List<Book> get archivedBooks => _archivedBooks;
  Map<String, List<Book>> get readingLists => _readingLists;
  List<Story> get publishedStories => _publishedStories;

  void initializeWithSampleData() {
    if (_publishedStories.isNotEmpty) return;

    _publishedStories.clear();

    // Combinamos las historias originales y las nuevas
    _publishedStories.addAll([
      // --- Historias Originales Restauradas ---
      Story(
        id: 's_og_1',
        authorId: 'F. Scott Fitzgerald',
        title: 'El Gran Gatsby',
        synopsis: 'Un retrato de la Era del Jazz en Long Island, donde el millonario Jay Gatsby busca reunirse con su amada Daisy.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/lobro4.JPG',
        chapters: [Chapter(id: 'c_og_1_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_2',
        authorId: 'Jane Austen',
        title: 'Orgullo y Prejuicio',
        synopsis: 'La historia de las cinco hermanas Bennet y sus enredos amorosos en la Inglaterra georgiana.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/orgullo.JPG',
        chapters: [Chapter(id: 'c_og_2_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_3',
        authorId: 'William Shakespeare',
        title: 'El Rey Lear',
        synopsis: 'Una tragedia sobre un rey que destierra a su hija por no halagarlo, desatando el caos en su reino.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/rey.JPG',
        chapters: [Chapter(id: 'c_og_3_1', title: 'Acto 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_4',
        authorId: 'Stephen King',
        title: 'It',
        synopsis: 'Un grupo de niños en Derry, Maine, se enfrenta a una entidad malévola que toma la forma de un payaso.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/sk.JPG',
        chapters: [Chapter(id: 'c_og_4_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_5',
        authorId: 'Neil Gaiman',
        title: 'Coraline',
        synopsis: 'Una niña descubre una puerta a una versión alternativa y siniestra de su propia vida.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/coraline3.0.JPG',
        chapters: [Chapter(id: 'c_og_5_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_6',
        authorId: 'Emily Brontë',
        title: 'Cumbres Borrascosas',
        synopsis: 'Una historia de amor apasionado y venganza en los páramos de Yorkshire.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/cumbres.JPG',
        chapters: [Chapter(id: 'c_og_6_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
       Story(
        id: 's_og_7',
        authorId: 'Autor 1',
        title: 'Libro 1',
        synopsis: 'Descripción del primer libro misterioso.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG',
        chapters: [Chapter(id: 'c_og_7_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_8',
        authorId: 'Autor 2',
        title: 'Libro 2',
        synopsis: 'La secuela que nadie esperaba, llena de giros.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro2.JPG',
        chapters: [Chapter(id: 'c_og_8_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_9',
        authorId: 'Autor 3',
        title: 'Libro 3',
        synopsis: 'El emocionante final de la trilogía.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro3.JPG',
        chapters: [Chapter(id: 'c_og_9_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      Story(
        id: 's_og_10',
        authorId: 'Autor 4',
        title: 'Libro 4',
        synopsis: 'Un nuevo comienzo en un universo familiar.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/ll.JPG',
        chapters: [Chapter(id: 'c_og_10_1', title: 'Capítulo 1', content: '...', isPublished: true)],
      ),
      // --- Nuevas Historias (se mantienen) ---
       Story(
        id: 's_1',
        authorId: 'fantasía_writer',
        title: 'La Aventura de las Sombras',
        synopsis: 'Un viaje épico a través de un mundo de fantasía lleno de magia y peligros.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/fantas.JPG',
        chapters: [
          Chapter(id: 'c_1_1', title: 'El Comienzo', content: '...', isPublished: true),
          Chapter(id: 'c_1_2', title: 'El Bosque Oscuro', content: '...', isPublished: true),
        ],
      ),
       Story(
        id: 's_7',
        authorId: 'fantasía_writer',
        title: 'El Último Dragón',
        synopsis: 'En un reino donde la magia se está extinguiendo, una joven se embarca en un viaje para encontrar al último dragón.',
        imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/lobro4.JPG',
        chapters: [
          Chapter(id: 'c_7_1', title: 'La Leyenda', content: '...', isPublished: true),
           Chapter(id: 'c_7_2', title: 'El Viaje', content: '...', isPublished: true),
        ],
      ),

    ]);

    notifyListeners();
  }

  // ... (el resto de las funciones del servicio se mantienen igual)

  void publishStory(Story story) {
    if (!_publishedStories.any((s) => s.id == story.id)) {
      _publishedStories.add(story);
      notifyListeners();
    }
  }

  List<Story> searchStories(String query) {
    if (query.isEmpty) {
      return _publishedStories;
    }

    final lowerCaseQuery = query.toLowerCase();
    return _publishedStories.where((story) {
      final titleMatch = story.title.toLowerCase().contains(lowerCaseQuery);
      final authorMatch = story.authorId.toLowerCase().contains(lowerCaseQuery);
      final synopsisMatch = story.synopsis.toLowerCase().contains(lowerCaseQuery);
      return titleMatch || authorMatch || synopsisMatch;
    }).toList();
  }

  List<Chapter> getPublicChapters(Story story) {
    return story.chapters.where((chapter) => chapter.isPublished).toList();
  }

  void archiveBook(Book book) {
    _currentReadings.removeWhere((b) => b.id == book.id);
    for (var list in _readingLists.values) {
      list.removeWhere((b) => b.id == book.id);
    }
    if (!_archivedBooks.any((b) => b.id == book.id)) {
      _archivedBooks.add(book);
    }
    notifyListeners();
  }

   void unarchiveBook(Book book) {
    _archivedBooks.removeWhere((b) => b.id == book.id);
    if (!_currentReadings.any((b) => b.id == book.id)) {
      _currentReadings.add(book);
    }
    notifyListeners();
  }

  void updateBookProgress(String bookId, double newProgress) {
    try {
      final book = _currentReadings.firstWhere((b) => b.id == bookId);
      book.progress = newProgress;
    } catch (e) {
      try {
        final book = _archivedBooks.firstWhere((b) => b.id == bookId);
        book.progress = newProgress;
      } catch (e) {
        // Not found
      }
    }
    notifyListeners();
  }

  void addBookToReadingList(Book book, String listName) {
    if (_readingLists.containsKey(listName)) {
      if (!_readingLists[listName]!.any((b) => b.id == book.id)) {
        _readingLists[listName]!.add(book);
        notifyListeners();
      }
    }
  }

  void removeBookFromReadingList(Book book, String listName) {
    if (_readingLists.containsKey(listName)) {
      _readingLists[listName]!.removeWhere((b) => b.id == book.id);
      notifyListeners();
    }
  }

  void createReadingList(String name) {
    if (name.isNotEmpty && !_readingLists.containsKey(name)) {
      _readingLists[name] = [];
      notifyListeners();
    }
  }

  bool isBookArchived(Book book) {
    return _archivedBooks.any((b) => b.id == book.id);
  }
}
