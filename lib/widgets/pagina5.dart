import 'package:flutter/material.dart';
import 'package:myapp/widgets/pagina6.dart'; // Importamos la página 6 para la navegación

// --- ¡LISTA DEFINITIVA Y COMPLETA DE HISTORIAS! ---
// He recopilado todos los libros de tus otros archivos, como me pediste.
final List<Map<String, String>> _stories = [
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/lobro4.JPG', 'title': 'Historia Archivada'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/orgullo.JPG', 'title': 'Orgullo y Prejuicio'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/rey.JPG', 'title': 'El Rey León'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/sk.JPG', 'title': 'It (Eso)'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/coraline3.0.JPG', 'title': 'Coraline'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/cumbres.JPG', 'title': 'Cumbres Borrascosas'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG', 'title': 'No Es Como Si Me Gustaras'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro2.JPG', 'title': 'Spider-Gotham'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro3.JPG', 'title': 'Un Beso de Invierno'},
  {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/ll.JPG', 'title': 'El Arte de Engañar al Karma'},
];

// --- DATOS PARA LA LISTA VERTICAL ---
final List<Map<String, String>> _popularStories = [
    {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro2.JPG', 'title': 'Spider-Gotham', 'author': 'Azazel_lector'},
    {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG', 'title': 'No Es Como Si Me Gustaras', 'author': 'aazzaaazzssj'},
    {'imageUrl': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro3.JPG', 'title': 'Un Beso de Invierno', 'author': 'Darlis Stefany'},
];

class Pagina5 extends StatelessWidget {
  const Pagina5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Pagina6()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 20),
                SizedBox(width: 10),
                Text(
                  'Buscar en Wattpad',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSectionTitle('Historias que te podrían gustar'),
          _buildHorizontalStoryList(),
          _buildSectionTitle('Búsquedas populares'),
          _buildPopularSearches(),
          const SizedBox(height: 20),
          _buildVerticalStoryList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHorizontalStoryList() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return _buildStoryCard(story['imageUrl']!, story['title']!);
        },
      ),
    );
  }

  Widget _buildStoryCard(String imageUrl, String title) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, height: 180, width: 140, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSearches() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildSearchChip('#romance'),
          _buildSearchChip('#vampiros'),
          _buildSearchChip('#fanfic'),
          _buildSearchChip('#misterio'),
          _buildSearchChip('#badboy'),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[800],
    );
  }

  Widget _buildVerticalStoryList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: _popularStories.map((story) {
          return _buildVerticalStoryItem(story['imageUrl']!, story['title']!, story['author']!);
        }).toList(),
      ),
    );
  }

  Widget _buildVerticalStoryItem(String imageUrl, String title, String author) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, width: 70, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'de $author',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                 Row(
                  children: [
                    _statIcon(Icons.remove_red_eye, '1.2M'),
                    const SizedBox(width: 12),
                    _statIcon(Icons.star, '89K'),
                    const SizedBox(width: 12),
                    _statIcon(Icons.list, '35'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 14),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
