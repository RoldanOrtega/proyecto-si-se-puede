import 'package:flutter/material.dart';
import 'package:myapp/models/book.dart';
import 'package:myapp/reading_list_service.dart';
import 'package:myapp/widgets/book_reader_page.dart';
import 'package:provider/provider.dart';

class ReadingListDetailPage extends StatelessWidget {
  final String listName;

  const ReadingListDetailPage({super.key, required this.listName});

  void _openBook(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookReaderPage(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(listName),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Consumer<LibraryService>(
        builder: (context, libraryService, child) {
          final books = libraryService.readingLists[listName] ?? [];

          if (books.isEmpty) {
            return const Center(
              child: Text(
                'Aún no has añadido historias a esta lista.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return _buildBookListItem(book, context, libraryService);
            },
          );
        },
      ),
    );
  }

  Widget _buildBookListItem(Book book, BuildContext context, LibraryService service) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () => _openBook(context, book),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(book.imageUrl, width: 50, height: 80, fit: BoxFit.cover),
        ),
        title: Text(book.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(book.author, style: const TextStyle(color: Colors.grey)),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
          tooltip: 'Quitar de la lista',
          onPressed: () {
            service.removeBookFromReadingList(book, listName);
          },
        ),
      ),
    );
  }
}
