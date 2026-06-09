import 'package:flutter/material.dart';
import 'package:myapp/data/chapter_data.dart';
import 'package:myapp/models/book.dart';
import 'package:myapp/reading_list_service.dart';
import 'package:provider/provider.dart';

class BookReaderPage extends StatefulWidget {
  final Book book;
  final int? initialChapterIndex;

  const BookReaderPage({super.key, required this.book, this.initialChapterIndex});

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final _scrollController = ScrollController();
  late int _currentChapterIndex;

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.initialChapterIndex ?? (widget.book.progress * (writingGuideChapters.length - 1)).round();
  }

  void _changeChapter(int newIndex, BuildContext context) {
    if (newIndex >= 0 && newIndex < writingGuideChapters.length) {
      setState(() {
        _currentChapterIndex = newIndex;
      });

      _scrollController.jumpTo(0);

      final libraryService = Provider.of<LibraryService>(context, listen: false);
      double newProgress = _currentChapterIndex / (writingGuideChapters.length - 1);
      libraryService.updateBookProgress(widget.book.id, newProgress);
    }
  }

  @override
  Widget build(BuildContext context) {
    final libraryService = Provider.of<LibraryService>(context);
    final currentBook = libraryService.findBookById(widget.book.id) ?? widget.book;
    final double currentProgress = currentBook.progress;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.book.title,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              writingGuideChapters[_currentChapterIndex]['title']!,
              style: const TextStyle(
                color: Color.fromARGB(255, 245, 147, 204),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              writingGuideChapters[_currentChapterIndex]['content']!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 18, 
                height: 1.6, 
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 40),
            if (_currentChapterIndex < writingGuideChapters.length - 1)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  label: const Text('Siguiente Capítulo'),
                  onPressed: () => _changeChapter(_currentChapterIndex + 1, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 147, 204),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            if (_currentChapterIndex == writingGuideChapters.length - 1)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'FIN',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(context, currentProgress),
    );
  }

  Widget _buildNavigationBar(BuildContext context, double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        border: Border(top: BorderSide(color: Colors.black, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Capítulo ${_currentChapterIndex + 1}/${writingGuideChapters.length}', style: const TextStyle(color: Colors.grey)),
              Text('${(progress * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[800],
            color: const Color.fromARGB(255, 245, 147, 204),
            minHeight: 2,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text('Anterior', style: TextStyle(color: Colors.white)),
                onPressed: _currentChapterIndex > 0 ? () => _changeChapter(_currentChapterIndex - 1, context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text('Siguiente', style: TextStyle(color: Colors.white)),
                onPressed: _currentChapterIndex < writingGuideChapters.length - 1 ? () => _changeChapter(_currentChapterIndex + 1, context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on LibraryService {
  Book? findBookById(String id) {
    try {
      return currentReadings.firstWhere((book) => book.id == id);
    } catch (e) {
      try {
        return archivedBooks.firstWhere((book) => book.id == id);
      } catch (e) {
        for (var list in readingLists.values) {
          try {
            return list.firstWhere((book) => book.id == id);
          } catch (e) {
            // El libro no está en esta lista, continuar buscando.
          }
        }
        return null;
      }
    }
  }
}