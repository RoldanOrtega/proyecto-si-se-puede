import 'package:flutter/material.dart';
import 'package:myapp/models/book.dart';
import 'package:myapp/reading_list_service.dart';
import 'package:myapp/widgets/book_reader_page.dart';
import 'package:myapp/widgets/reading_list_detail_page.dart';
import 'package:provider/provider.dart';

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});

  void _openBook(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookReaderPage(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryService>(
      builder: (context, libraryService, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: AppBar(
              backgroundColor: const Color(0xFF121212),
              elevation: 0,
              title: const Text('Biblioteca', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              actions: [
                IconButton(icon: const Icon(Icons.search, size: 22, color: Colors.white), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert, size: 22, color: Colors.white), onPressed: () {}),
              ],
              bottom: const TabBar(
                indicatorColor: Color.fromARGB(255, 245, 147, 204),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'LECTURAS ACTUALES'),
                  Tab(text: 'ARCHIVO'),
                  Tab(text: 'LISTAS DE LECTURA'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildLecturasTab(context, libraryService, libros: libraryService.currentReadings, esArchivo: false),
                _buildLecturasTab(context, libraryService, libros: libraryService.archivedBooks, esArchivo: true),
                _buildListasTab(context, libraryService),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLecturasTab(BuildContext context, LibraryService service, {required List<Book> libros, required bool esArchivo}) {
    if (libros.isEmpty) {
      return Center(
        child: Text(
          esArchivo ? 'No tienes historias archivadas.' : 'Tus lecturas actuales aparecerán aquí.',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.6, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: libros.length,
      itemBuilder: (context, index) {
        final libro = libros[index];
        return InkWell(
          onTap: () => _openBook(context, libro),
          onLongPress: () => _mostrarOpciones(context, service, libro, esArchivo),
          child: _buildLibroGridItem(libro),
        );
      },
    );
  }

  Widget _buildListasTab(BuildContext context, LibraryService service) {
    final listEntries = service.readingLists.entries.toList();
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: listEntries.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            leading: const Icon(Icons.add, color: Color.fromARGB(255, 245, 147, 204)),
            title: const Text('Crear nueva lista', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () => _mostrarDialogoCrearLista(context, service),
          );
        }
        final entry = listEntries[index - 1];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.folder_special, color: Colors.grey),
            title: Text(entry.key, style: const TextStyle(color: Colors.white)),
            subtitle: Text('${entry.value.length} historias', style: const TextStyle(color: Colors.white38, fontSize: 12)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadingListDetailPage(listName: entry.key)),
              );
            },
          ),
        );
      },
    );
  }

  void _mostrarDialogoCrearLista(BuildContext context, LibraryService service) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Crear Nueva Lista', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Nombre de la lista',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  service.createReadingList(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Crear', style: TextStyle(color: Color.fromARGB(255, 245, 147, 204))),
            ),
          ],
        );
      },
    );
  }

  void _mostrarOpciones(BuildContext context, LibraryService service, Book libro, bool esDesdeArchivo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(esDesdeArchivo ? Icons.unarchive : Icons.archive, color: Colors.white70),
              title: Text(esDesdeArchivo ? 'Mover a Lecturas' : 'Mover a Archivo', style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                if (esDesdeArchivo) {
                  service.unarchiveBook(libro);
                } else {
                  service.archiveBook(libro);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLibroGridItem(Book libro) {
    return LayoutBuilder(builder: (context, constraints) {
      final double widthProgreso = constraints.maxWidth * libro.progress;
      return Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(libro.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Positioned(bottom: 0, left: 0, child: Container(height: 4, width: widthProgreso, color: const Color.fromARGB(255, 241, 143, 192))),
          if (libro.isDownloaded)
            Positioned(bottom: 6, right: 6, child: Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.black.withAlpha((255 * 0.5).round()), shape: BoxShape.circle), child: const Icon(Icons.cloud_done_rounded, color: Colors.white, size: 14))),
        ],
      );
    });
  }
}
