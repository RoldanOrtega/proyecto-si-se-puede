import 'package:flutter/material.dart';

class Pagina7 extends StatelessWidget {
  const Pagina7({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey, size: 18),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Azazel_lector',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'HISTORIAS'),
              Tab(text: 'PERFILES'),
              Tab(text: 'LISTAS DE LECTURA'),
              Tab(text: 'ETIQUETAS'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Fila de Filtros (Extensión, Actualizado)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  _botonFiltro(Icons.tune),
                  const SizedBox(width: 8),
                  _botonFiltroTexto('Extensión'),
                  const SizedBox(width: 8),
                  _botonFiltroTexto('Actualizadas por última vez'),
                ],
              ),
            ),

            // Lista de Historias
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _cardHistoria(
                    '☆ Spider-Gotham ☆',
                    'En curso',
                    '19.2 K',
                    '2.61 K',
                    '12',
                    'Después de casi destruir su universo, Peter Parker/Spider-man es enviado a Gotham...',
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/spider.JPG',
                  ),
                  const SizedBox(height: 15),
                  _cardHistoria(
                    'The Amazing Oregairu',
                    'Completa',
                    '9.21 K',
                    '873',
                    '42',
                    'Tras la muerte de Gwen Stacy en su batalla contra el Duende Verde, Peter Parker consigue una beca...',
                    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botonFiltro(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _botonFiltroTexto(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            texto,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _cardHistoria(
    String titulo,
    String estado,
    String lecturas,
    String votos,
    String partes,
    String desc,
    String url,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(url, width: 80, height: 110, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      241,
                      85,
                      163,
                    ).withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    estado,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 241, 33, 179),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _statIcon(Icons.remove_red_eye, lecturas),
                    const SizedBox(width: 10),
                    _statIcon(Icons.star, votos),
                    const SizedBox(width: 10),
                    _statIcon(Icons.list, partes),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statIcon(IconData icon, String valor) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(valor, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}
