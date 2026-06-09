import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/story_service.dart';
import 'package:myapp/models/story.dart';
import 'pagina7.dart';

class Pagina6 extends StatefulWidget {
  const Pagina6({super.key});

  @override
  State<Pagina6> createState() => _Pagina6State();
}

class _Pagina6State extends State<Pagina6> {
  final TextEditingController _searchController = TextEditingController();
  List<Story> _searchResults = [];

  @override
  void initState() {
    super.initState();
    final storyService = Provider.of<StoryService>(context, listen: false);
    // Realizamos una búsqueda inicial para mostrar todas las historias
    _searchResults = storyService.searchStories('');
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final storyService = Provider.of<StoryService>(context, listen: false);
    final query = _searchController.text;
    setState(() {
      _searchResults = storyService.searchStories(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No se encontraron historias que coincidan con tu búsqueda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final story = _searchResults[index];
                    return _buildStoryResultItem(story);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.orange, size: 20),
                  hintText: 'Buscar por título, autor, palabra clave...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryResultItem(Story story) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          story.imageUrl,
          width: 50,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => 
            const Icon(Icons.book, color: Colors.grey, size: 50),
        ),
      ),
      title: Text(story.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            'de ${story.authorId}',
            style: const TextStyle(color: Colors.orange, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            story.synopsis,
            style: const TextStyle(color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pagina7(story: story),
          ),
        );
      },
    );
  }
}
