import 'package:flutter/material.dart';

class OriginalPage extends StatelessWidget {
  const OriginalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // --- 1. Botones de acción fijos en la parte inferior ---
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 147, 204),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Continuar Leyenda',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  shape: const CircleBorder(),
                  side: const BorderSide(color: Colors.white54),
                ),
                onPressed: () {},
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),
      ),
      // --- 2. Contenido con la imagen que se encoge ---
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0, // Altura de la imagen
            backgroundColor: Colors.black,
            pinned: true, // La barra se queda visible al hacer scroll
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/cain.JPG',
                    fit: BoxFit.cover,
                  ),
                  // Gradiente para que el texto y los botones se vean bien
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // --- 3. Contenido principal de la página ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'La marca de Caín',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Por AlexMirez',
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.grey), SizedBox(width: 5),
                      Text('4.1M', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.star_border, size: 16, color: Colors.grey), SizedBox(width: 5),
                      Text('194K', style: TextStyle(color: Colors.grey)),
                       SizedBox(width: 16),
                      Icon(Icons.format_list_bulleted, size: 16, color: Colors.grey), SizedBox(width: 5),
                      Text('40 partes', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['#demonios', '#ángeles', '#romance', '#fantasía']
                        .map((tag) => Chip(label: Text(tag), backgroundColor: Colors.grey[800], labelStyle: const TextStyle(color: Colors.white70)))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '-Yo no soy una santa, soy la tentación en persona. Él es un demonio que desertó del infierno para vivir entre los humanos como un mortal más. Ella es la reencarnación de un ángel que tiene como misión...',
                    style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 10),
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tabla de contenido', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('40 partes', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // --- 4. Lista de Capítulos ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  // Un capítulo especial "PREFACIO"
                  return const ListTile(
                    title: Text('PREFACIO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.play_circle_outline, color: Colors.grey),
                  );
                }
                return ListTile(
                  title: Text('Capítulo $index', style: const TextStyle(color: Colors.white70)),
                  subtitle: const Text('Publicado el 15/05/24', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  trailing: const Icon(Icons.play_circle_outline, color: Colors.grey),
                );
              },
              childCount: 40, // 39 capítulos + prefacio
            ),
          ),
        ],
      ),
    );
  }
}
