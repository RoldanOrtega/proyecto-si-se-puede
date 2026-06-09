import 'package:flutter/material.dart';
import 'models/book.dart';

class LibraryService extends ChangeNotifier {
  static final LibraryService _instance = LibraryService._internal();
  factory LibraryService() => _instance;
  LibraryService._internal();

  final List<Book> _currentReadings = [];
  final List<Book> _archivedBooks = [];
  final Map<String, List<Book>> _readingLists = {};

  List<Book> get currentReadings => _currentReadings;
  List<Book> get archivedBooks => _archivedBooks;
  Map<String, List<Book>> get readingLists => _readingLists;

  void initializeWithSampleData() {
    if (_currentReadings.isNotEmpty && _archivedBooks.isNotEmpty) return;

    _currentReadings.clear();
    _archivedBooks.clear();
    _readingLists.clear();

    _currentReadings.addAll([
      Book(id: 'l_1', title: 'No Es Como Si Me Gustaras', author: 'aazzaaazzssj', imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG', progress: 0.3),
      Book(id: 'l_2', title: 'Spider-Gotham', author: 'Azazel_lector', imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro2.JPG', progress: 0.8),
      Book(id: 'l_3', title: 'Cumbres Borrascosas', author: 'Emily Brontë', imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/cumbres.JPG', progress: 0.5),
    ]);
    _archivedBooks.add(
      Book(id: 'arch_1', title: 'Historia Archivada', author: 'Escritor Clásico', imageUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/lobro4.JPG', progress: 1.0),
    );
    _readingLists['Favoritos de Terror 💀'] = [];
    _readingLists['Novelas Románticas ✨'] = [];
    notifyListeners();
  }

  void archiveBook(Book book) {
    // Eliminar de lecturas actuales
    _currentReadings.removeWhere((b) => b.id == book.id);

    // Eliminar de todas las listas de lectura
    for (var list in _readingLists.values) {
      list.removeWhere((b) => b.id == book.id);
    }

    // Añadir a archivados si no está ya
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
        // El libro no se encontró en ninguna lista.
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
