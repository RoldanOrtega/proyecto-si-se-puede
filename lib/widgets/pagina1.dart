import 'package:flutter/material.dart';
import 'package:myapp/models/story.dart';
import 'package:myapp/story_service.dart';
import 'package:myapp/widgets/perfil_page.dart';
import 'package:myapp/widgets/pagina7.dart';
import 'package:provider/provider.dart';

class Pagina1 extends StatelessWidget {
  const Pagina1({super.key});

  @override
  Widget build(BuildContext context) {
    final storyService = Provider.of<StoryService>(context);
    final allStories = storyService.publishedStories;

    final writerStories = allStories.take(5).toList();
    final classicStories = allStories.skip(5).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Icon(
          Icons.auto_stories,
          color: Color.fromRGBO(255, 182, 193, 1),
          size: 32,
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withAlpha(100),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Andrea Roldan 6-I',
                style: TextStyle(fontSize: 12, color: Colors.purpleAccent),
              ),
            ),
          ),
          const IconButton(
            icon: Icon(
              Icons.card_giftcard,
              color: Color.fromARGB(255, 243, 147, 203),
            ),
            onPressed: null,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PerfilPage()),
                );
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/PERFIL.JPG'),
              ),
            ),
          ),
        ],
      ),
      body: allStories.isEmpty
          ? const Center(
              child: Text(
                'No hay historias publicadas aún.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pagina7(story: allStories.first)),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      allStories.first.imageUrl,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Historias que te podrían gustar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (writerStories.isNotEmpty) _buildDisenoMosaico(context, writerStories),
                const SizedBox(height: 25),
                const Text(
                  "Éxitos Recientes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (classicStories.isNotEmpty)
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: classicStories.length,
                      itemBuilder: (context, index) =>
                          _buildSquareBook(context, classicStories[index]),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildDisenoMosaico(BuildContext context, List<Story> stories) {
    return SizedBox(
      height: 210,
      child: Row(
        children: [
          if (stories.isNotEmpty) Expanded(child: _capa(context, stories[0])),
          if (stories.length > 1)
            const SizedBox(width: 10),
          if (stories.length > 1)
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (stories.length > 1) Expanded(child: _capa(context, stories[1])),
                        if (stories.length > 2) const SizedBox(width: 8),
                        if (stories.length > 2) Expanded(child: _capa(context, stories[2])),
                      ],
                    ),
                  ),
                   if (stories.length > 3) const SizedBox(height: 10),
                  if (stories.length > 3)
                  Expanded(
                    child: Row(
                      children: [
                        if (stories.length > 3) Expanded(child: _capa(context, stories[3])),
                        if (stories.length > 4) const SizedBox(width: 8),
                        if (stories.length > 4) Expanded(child: _capa(context, stories[4])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _capa(BuildContext context, Story story) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pagina7(story: story)),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(story.imageUrl), fit: BoxFit.cover),
      ),
    ),
  );

  Widget _buildSquareBook(BuildContext context, Story story) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pagina7(story: story)),
      );
    },
    child: Container(
      width: 95,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(story.imageUrl), fit: BoxFit.cover),
      ),
    ),
  );
}
