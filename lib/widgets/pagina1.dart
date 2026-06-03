import 'package:flutter/material.dart';

class Pagina1 extends StatelessWidget {
  const Pagina1({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> misImagenesAbajo = const [
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/lobro4.JPG',
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/orgullo.JPG',
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/rey.JPG',
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/sk.JPG',
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/coraline3.0.JPG',
      'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/cumbres.JPG',
    ];

    return Scaffold(
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
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/PERFIL.JPG'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/coraline2.0.JPG',
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Historias de los escritores que te gustan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comic Sans MS',
            ),
          ),
          const SizedBox(height: 10),
          _buildDisenoMosaico(),
          const SizedBox(height: 25),
          const Text(
            "Éxitos Clasicos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comic Sans MS',
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: misImagenesAbajo.length,
              itemBuilder: (context, index) =>
                  _buildSquareBook(misImagenesAbajo[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisenoMosaico() {
    return SizedBox(
      height: 210,
      child: Row(
        children: [
          Expanded(child: _capa('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/cumbres.JPG')),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: _capa('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG')),
                      const SizedBox(width: 8),
                      Expanded(child: _capa('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG')),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: _capa('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro3.JPG')),
                      const SizedBox(width: 8),
                      Expanded(child: _capa('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/ll.JPG')),
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

  Widget _capa(String url) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
    ),
  );
  Widget _buildSquareBook(String url) => Container(
    width: 95,
    margin: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
    ),
  );
}
