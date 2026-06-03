import 'package:flutter/material.dart';
import 'pagina6.dart';

class Pagina5 extends StatelessWidget {
  const Pagina5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Buscador
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina6()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        'Buscar historias o personas',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Categorías
            _buildCategorias(),

            // 3. Contenido Principal
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // --- SECCIÓN ORIGINALS ---
                  const Text(
                    'Wattpad Originals más populares',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Fila de libros con scroll horizontal (Más recuadros)
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _cardOriginal('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG'),
                        _cardOriginal('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG'),
                        _cardOriginal('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro3.JPG'),
                        _cardOriginal('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/ll.JPG'),
                        _cardOriginal(
                          'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG',
                        ), // Repetido para llenar
                        _cardOriginal('https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- SECCIÓN RANKING (1.29 K Historias) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '1.29 K Historias',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      _botonFiltro(),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _itemRanking(
                    '1',
                    'LUJURIA',
                    'EvaMuozBenitez',
                    '225 M',
                    '107',
                    ['18', '21', 'engaños'],
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG',
                  ),
                  _itemRanking(
                    '2',
                    'Deseo [+21]',
                    'karla_cipriano17',
                    '43.6 M',
                    '97',
                    ['18', 'deseo', 'erotico'],
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG',
                  ),
                  _itemRanking(
                    '3',
                    'Antes de diciembre',
                    'JoanaMarcus',
                    '179 M',
                    '55',
                    ['romance', 'juvenil'],
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro3.JPG',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorias() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: ['Romance', 'Fanfic', 'Novela Juvenil', 'Fantasía']
            .map(
              (cat) => Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: cat == 'Romance' ? Colors.white : Colors.grey,
                    fontWeight: cat == 'Romance'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget para las portadas con el logo "W"
  Widget _cardOriginal(String url) {
    return Container(
      width: 115,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(url, fit: BoxFit.cover, height: 170, width: 115),
          ),
          // El pequeño logo naranja de la esquina (W)
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 154, 233),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'W',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonFiltro() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: const Row(
        children: [
          Icon(Icons.tune, size: 16, color: Colors.white),
          SizedBox(width: 5),
          Text('Filtro', style: TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _itemRanking(
    String n,
    String t,
    String a,
    String v,
    String c,
    List<String> tags,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(url, width: 75, height: 110, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$n $t',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(
                  a,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      v,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.list, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      c,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
