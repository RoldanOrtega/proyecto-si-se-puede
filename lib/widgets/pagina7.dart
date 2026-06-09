import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/story_service.dart';
import 'package:myapp/models/story.dart';
import 'package:myapp/models/chapter.dart';

class Pagina7 extends StatelessWidget {
  final Story story;

  const Pagina7({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final storyService = Provider.of<StoryService>(context, listen: false);
    final publicChapters = storyService.getPublicChapters(story);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(story.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStoryHeader(),
          const SizedBox(height: 24),
          _buildSynopsisCard(),
          const SizedBox(height: 24),
          _buildChapterList(publicChapters),
        ],
      ),
    );
  }

  Widget _buildStoryHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            story.imageUrl,
            width: 100,
            height: 140,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.book, size: 100, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story.title,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'de ${story.authorId}', // En el futuro, podriamos buscar el nombre del autor con este id
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 12),
              // Podriamos añadir estadisticas aqui (lecturas, votos, etc.)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSynopsisCard() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sinopsis',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              story.synopsis,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterList(List<Chapter> chapters) {
    if (chapters.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'El autor aún no ha publicado ningún capítulo.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Capítulos',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.menu_book, color: Colors.orange),
                title: Text(chapter.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                // Al tocar, en un futuro, navegariamos a la pantalla de lectura del capitulo
                onTap: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Leyendo: ${chapter.title}')),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
