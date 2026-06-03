import 'package:flutter/material.dart';

// --- MODELO DE DATOS INTERNO ---
class Libro {
  final String id;
  final String titulo;
  final String autor;
  final String portadaUrl;
  final double progreso;
  bool estaDescargado;

  Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.portadaUrl,
    required this.progreso,
    this.estaDescargado = true,
  });
}

class Pagina2 extends StatefulWidget {
  const Pagina2({super.key}); // Constructor limpio, sin parámetros (como le gusta a tu main.dart)

  @override
  State<Pagina2> createState() => _Pagina2State();
}

class _Pagina2State extends State<Pagina2> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _estaBuscando = false;
  String _filtroBusqueda = "";

  // Listas de datos dinámicas internas
  final List<Libro> _lecturasActuales = [];
  final List<Libro> _archivo = [];
  final List<String> _listasLectura = ['Favoritos de Terror 💀', 'Novelas Románticas ✨', 'Pendientes por Leer 📚'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Carga inicial de tus portadas de GitHub
    final List<Map<String, String>> datosEjemplo = [
      {'titulo': 'No Es Como Si Me Gustaras', 'autor': 'aazzaaazzssj', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG'},
      {'titulo': 'Spider-Gotham', 'autor': 'Azazel_lector', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro2.JPG'},
      {'titulo': '¡Este necesita un novio!', 'autor': 'Sr_Alucard', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/libro3.JPG'},
      {'titulo': 'Coraline 3.0', 'autor': 'Checock', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/ll.JPG'},
      {'titulo': 'Cumbres Borrascosas', 'autor': 'Emily Brontë', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/cumbres.JPG'},
      {'titulo': 'Bocetos y Secretos', 'autor': 'Anónimo', 'url': 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/lobro4.JPG'},
    ];

    for (int i = 0; i < datosEjemplo.length; i++) {
      _lecturasActuales.add(
        Libro(
          id: 'l_$i',
          titulo: datosEjemplo[i]['titulo']!,
          autor: datosEjemplo[i]['autor']!,
          portadaUrl: datosEjemplo[i]['url']!,
          progreso: (0.2 + (i * 0.15)).clamp(0.0, 1.0),
        ),
      );
    }
    
    _archivo.add(
      Libro(
        id: 'arch_1',
        titulo: 'Historia Antigua',
        autor: 'Clásico Escritor',
        portadaUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/l.JPG',
        progreso: 1.0,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // --- INTERACCIÓN INTERNA INTERACTIVA ---
  void _mostrarOpcionesLibro(Libro libro, bool esDesdeArchivo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  libro.titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
              ListTile(
                leading: const Icon(Icons.chrome_reader_mode, color: Colors.grey),
                title: const Text('Continuar Leyendo', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Abriendo capítulo de "${libro.titulo}"... 📖')),
                  );
                },
              ),
              ListTile(
                leading: Icon(esDesdeArchivo ? Icons.unarchive : Icons.archive, color: Colors.grey),
                title: Text(esDesdeArchivo ? 'Mover a Lecturas Actuales' : 'Mover al Archivo', style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // Mueve los libros dinámicamente de una lista a otra
                  setState(() {
                    if (esDesdeArchivo) {
                      _archivo.remove(libro);
                      _lecturasActuales.add(libro);
                    } else {
                      _lecturasActuales.remove(libro);
                      _archivo.add(libro);
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add, color: Colors.grey),
                title: const Text('Agregar a Lista de Lectura', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _mostrarListasParaAgregar(libro);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                title: const Text('Eliminar de la biblioteca', style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  setState(() {
                    if (esDesdeArchivo) {
                      _archivo.remove(libro);
                    } else {
                      _lecturasActuales.remove(libro);
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarListasParaAgregar(Libro libro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF252525),
        title: const Text('Seleccionar Lista', style: TextStyle(color: Colors.white, fontSize: 16)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _listasLectura.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_listasLectura[index], style: const TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"${libro.titulo}" añadido a ${_listasLectura[index]}')),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Libro> _filtrarLibros(List<Libro> listaOriginal) {
    if (_filtroBusqueda.isEmpty) return listaOriginal;
    return listaOriginal.where((libro) => 
      libro.titulo.toLowerCase().contains(_filtroBusqueda.toLowerCase()) || 
      libro.autor.toLowerCase().contains(_filtroBusqueda.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: _estaBuscando
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Buscar por título o autor...',
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 16),
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  setState(() {
                    _filtroBusqueda = val;
                  });
                },
              )
            : const Text(
                'Biblioteca Andrea Roldan 6-I',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
              ),
        actions: [
          IconButton(
            icon: Icon(_estaBuscando ? Icons.close : Icons.search, size: 22, color: Colors.white),
            onPressed: () {
              setState(() {
                _estaBuscando = !_estaBuscando;
                if (!_estaBuscando) {
                  _searchController.clear();
                  _filtroBusqueda = "";
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 22, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ajustes de sincronización de biblioteca 🔄')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 245, 147, 204),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'LECTURAS ACTUALES'),
            Tab(text: 'ARCHIVO'),
            Tab(text: 'LISTAS DE LECTURA'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLecturasTab(esArchivo: false),
          _buildLecturasTab(esArchivo: true),
          _buildListasTab(),
        ],
      ),
    );
  }

  Widget _buildLecturasTab({required bool esArchivo}) {
    final librosMostrados = _filtrarLibros(esArchivo ? _archivo : _lecturasActuales);

    if (librosMostrados.isEmpty) {
      return Center(
        child: Text(
          _filtroBusqueda.isNotEmpty ? 'No se encontraron resultados' : 'No hay historias aquí.',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                esArchivo ? 'Guardado sin conexión' : 'Otras Historias',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
              ),
              Text(
                '${librosMostrados.length} Historias',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: librosMostrados.length,
            itemBuilder: (context, index) {
              final libro = librosMostrados[index];
              return InkWell(
                onTap: () => _mostrarOpcionesLibro(libro, esArchivo),
                onLongPress: () => _mostrarOpcionesLibro(libro, esArchivo),
                child: _buildLibroGridItem(libro),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListasTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _listasLectura.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            leading: const Icon(Icons.add, color: Color.fromARGB(255, 245, 147, 204)),
            title: const Text('Crear nueva lista', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () {
              setState(() {
                _listasLectura.add('Nueva Lista #${_listasLectura.length + 1}');
              });
            },
          );
        }
        final listaNombre = _listasLectura[index - 1];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.folder_special, color: Colors.grey),
            title: Text(listaNombre, style: const TextStyle(color: Colors.white)),
            subtitle: const Text('0 historias compartidas', style: TextStyle(color: Colors.white38, fontSize: 12)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildLibroGridItem(Libro libro) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double widthProgreso = maxWidth * libro.progreso;

        return Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  libro.portadaUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade300),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.broken_image, color: Colors.grey),
                          SizedBox(height: 4),
                          Icon(Icons.menu_book, color: Colors.white24, size: 16)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 4,
                width: widthProgreso, 
                color: const Color.fromARGB(255, 241, 143, 192),
              ),
            ),
            if (libro.estaDescargado)
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(Icons.cloud_done_rounded, color: Colors.white, size: 14),
                ),
              ),
          ],
        );
      },
    );
  }
}