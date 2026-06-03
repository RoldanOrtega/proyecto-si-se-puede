import 'package:flutter/material.dart';

// --- MODELOS DE DATOS ---
class Capitulo {
  String id;
  String titulo;
  String contenido;
  bool esBorrador;
  DateTime fechaModificacion;

  Capitulo({
    required this.id,
    required this.titulo,
    required this.contenido,
    this.esBorrador = true,
    required this.fechaModificacion,
  });
}

class Historia {
  String id;
  String titulo;
  String portadaUrl;
  String sinopsis;
  List<String> etiquetas;
  List<Capitulo> capitulos;

  Historia({
    required this.id,
    required this.titulo,
    required this.portadaUrl,
    required this.sinopsis,
    required this.etiquetas,
    required this.capitulos,
  });

  int get totalPublicados => capitulos.where((c) => !c.esBorrador).length;
  int get totalBorradores => capitulos.where((c) => c.esBorrador).length;
}

// --- PÁGINA PRINCIPAL ---
class Pagina3 extends StatefulWidget {
  const Pagina3({super.key});

  @override
  State<Pagina3> createState() => _Pagina3State();
}

class _Pagina3State extends State<Pagina3> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _filtroBusqueda = '';
  
  final List<Historia> _misHistorias = [
    Historia(
      id: '1',
      titulo: 'Hasta volver a encontrarte',
      portadaUrl: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/spider.JPG',
      sinopsis: 'Dos almas separadas por el destino intentan desafiar las leyes del tiempo y el espacio para unirse una última vez en un frío otoño.',
      etiquetas: ['romance', 'drama', 'fantasia', 'wattpad'],
      capitulos: [
        Capitulo(id: 'c1', titulo: 'Capítulo 1: El Inicio', contenido: 'Todo comenzó una noche lluviosa...', esBorrador: false, fechaModificacion: DateTime.now()),
        Capitulo(id: 'c2', titulo: 'Capítulo 2: El Encuentro', contenido: 'Caminando por la calle, lo vi de nuevo...', esBorrador: false, fechaModificacion: DateTime.now()),
        Capitulo(id: 'c3', titulo: 'Capítulo 3: Un Secreto', contenido: 'No podía decirle a nadie lo que descubrí.', esBorrador: false, fechaModificacion: DateTime.now()),
        Capitulo(id: 'c4', titulo: 'Idea para el final de la obra', contenido: '¿Qué pasa si despierta y todo fue un sueño?', esBorrador: true, fechaModificacion: DateTime.now()),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _filtroBusqueda = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _mostrarRecuadroAyuda(String titulo, String descripcion, List<String> consejos) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.auto_stories, color: Color.fromARGB(255, 241, 57, 165), size: 28),
                      const SizedBox(width: 12),
                      Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(descripcion, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const Divider(color: Colors.white12, height: 30),
                  ...consejos.map((consejo) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFF252525), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: Color.fromARGB(255, 241, 57, 165), size: 20),
                        const SizedBox(width: 12),
                        Expanded(child: Text(consejo, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 57, 165),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Estructura de ayuda copiada al portapapeles! 📋')),
                      );
                    },
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text('COPIAR PLANTILLA DE TRABAJO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _pantallaCrearHistoria() {
    final tituloController = TextEditingController();
    final portadaController = TextEditingController();
    final sinopsisController = TextEditingController();
    final etiquetasController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 24, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Crear Nueva Obra', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Completa los campos para tu próximo éxito literario.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 20),
                TextField(
                  controller: tituloController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Título de la obra',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color.fromARGB(255, 241, 57, 165))),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: portadaController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'URL de la Imagen de Portada',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color.fromARGB(255, 241, 57, 165))),
                    hintText: 'https://ejemplo.com/imagen.jpg',
                    hintStyle: const TextStyle(color: Colors.white24),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: sinopsisController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Sinopsis / Resumen de la obra',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color.fromARGB(255, 241, 57, 165))),
                    hintText: 'Cuéntale a tus lectores de qué trata tu libro...',
                    hintStyle: const TextStyle(color: Colors.white24),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: etiquetasController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Etiquetas (separadas por comas)',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color.fromARGB(255, 241, 57, 165))),
                    hintText: 'romance, terror, misterio',
                    hintStyle: const TextStyle(color: Colors.white24),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 57, 165),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (tituloController.text.trim().isNotEmpty) {
                        String urlFinal = portadaController.text.trim();
                        if (urlFinal.isEmpty) {
                          urlFinal = 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?q=80&w=200';
                        }
                        
                        List<String> listaEtiquetas = etiquetasController.text
                            .split(',')
                            .map((e) => e.trim().toLowerCase())
                            .where((e) => e.isNotEmpty)
                            .toList();

                        setState(() {
                          _misHistorias.add(Historia(
                            id: DateTime.now().toString(),
                            titulo: tituloController.text.trim(),
                            portadaUrl: urlFinal,
                            sinopsis: sinopsisController.text.trim().isEmpty ? 'Sin sinopsis disponible.' : sinopsisController.text.trim(),
                            etiquetas: listaEtiquetas,
                            capitulos: [],
                          ));
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('EMPEZAR A ESCRIBIR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pantallaDetalleHistoria(Historia historia) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaginaDetalleHistoriaInteractive(
          historia: historia,
          onEstadoCambiado: () => setState(() {}),
          onBorrarHistoria: () {
            setState(() {
              _misHistorias.removeWhere((h) => h.id == historia.id);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text('Crear', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 241, 57, 165),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: 'MIS HISTORIAS'),
            Tab(text: 'ANALÍTICAS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMisHistoriasTab(),
          _buildAnaliticasTab(),
        ],
      ),
    );
  }

  Widget _buildMisHistoriasTab() {
    final historiasFiltradas = _misHistorias.where((historia) {
      final coincideTitulo = historia.titulo.toLowerCase().contains(_filtroBusqueda);
      final coincideEtiqueta = historia.etiquetas.any((tag) => tag.contains(_filtroBusqueda));
      return coincideTitulo || coincideEtiqueta;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Buscar por nombre o etiqueta...',
              hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        if (historiasFiltradas.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(child: Text('No se encontraron obras coincidentes.', style: TextStyle(color: Colors.grey))),
          ),
        
        ...historiasFiltradas.map((historia) => Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: InkWell(
            onTap: () => _pantallaDetalleHistoria(historia),
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'portada-${historia.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        historia.portadaUrl, 
                        width: 75, 
                        height: 105, 
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 75, height: 105, color: Colors.white12,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.edit, color: Colors.grey, size: 12),
                            SizedBox(width: 4),
                            Text('Proyecto activo', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(historia.titulo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        
                        if (historia.etiquetas.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            historia.etiquetas.map((t) => '#$t').join(' '),
                            style: const TextStyle(color: Color.fromARGB(255, 241, 57, 165), fontSize: 11, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],

                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _Badge(text: '${historia.totalPublicados} Publicados', color: Colors.green.withValues(alpha: 0.15), textColor: Colors.greenAccent),
                            const SizedBox(width: 8),
                            _Badge(text: '${historia.totalBorradores} Borradores', color: Colors.orange.withValues(alpha: 0.15), textColor: Colors.orangeAccent),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
                ],
              ),
            ),
          ),
        )),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 241, 57, 165),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 4,
          ),
          onPressed: _pantallaCrearHistoria,
          icon: const Icon(Icons.add, size: 20),
          label: const Text('CREAR UNA NUEVA HISTORIA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        ),
        const SizedBox(height: 30),
        const Text('Aprende a escribir en Wattpad', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _buildLearningCard(
          '¡Escribe tu historia!',
          'Consulta la guía rápida para escribir en Wattpad y estructurar tus mundos.',
          Icons.lightbulb_outline,
          Colors.amber,
          () => _mostrarRecuadroAyuda(
            'Guía de Escritura',
            'Consejos esenciales para organizar tus capítulos y mantener atrapado al lector.',
            [
              'Define el gancho principal de tu protagonista en las primeras 500 palabras.',
              'Mantén los capítulos entre 1,500 y 2,500 palabras: es la medida ideal para móviles.',
              'Termina los capítulos en un punto de alta tensión para incitar al voto.'
            ]
          ),
        ),
        _buildLearningCard(
          'Kit de herramientas del escritor',
          'Descubre recursos interactivos para llevar tu escritura al siguiente nivel.',
          Icons.construction,
          Colors.blue,
          () => _mostrarRecuadroAyuda(
            'Kit del Escritor',
            'Metodologías prácticas para planificar tramas complejas sin perder el rumbo.',
            [
              'Estructura de 3 actos: Planteamiento (25%), Nudo (50%) y Desenlace (25%).',
              'Crea fichas de personajes con sus debilidades y secretos ocultos.',
              'Alterna los ritmos: combina escenas de acción rápida con diálogos profundos.'
            ]
          ),
        ),
      ],
    );
  }

  Widget _buildAnaliticasTab() {
    int totalLibros = _misHistorias.length;
    int totalPub = _misHistorias.fold(0, (sum, h) => sum + h.totalPublicados);
    int totalBorr = _misHistorias.fold(0, (sum, h) => sum + h.totalBorradores);
    int totalCapitulos = totalPub + totalBorr;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Rendimiento Global', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildMetricCard('Historias', '$totalLibros', Icons.book, Colors.purple)),
            const SizedBox(width: 15),
            Expanded(child: _buildMetricCard('Partes Publicadas', '$totalPub', Icons.assignment_turned_in, Colors.green)),
          ],
        ),
        const SizedBox(height: 15),
        _buildMetricCard('Borradores en Escritorio', '$totalBorr', Icons.edit_note, Colors.orange),
        const SizedBox(height: 30),
        const Text('Progreso de Production', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        
        _buildProgressBar('Tasa de Publicación', totalCapitulos == 0 ? 0 : totalPub / totalCapitulos, Colors.greenAccent),
        const SizedBox(height: 12),
        _buildProgressBar('Capítulos en Reserva (Borradores)', totalCapitulos == 0 ? 0 : totalBorr / totalCapitulos, Colors.orangeAccent),
      ],
    );
  }

  Widget _buildProgressBar(String titulo, double porcentaje, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(titulo, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              Text('${(porcentaje * 100).toStringAsFixed(0)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: porcentaje,
              backgroundColor: Colors.white10,
              color: color,
              minHeight: 8,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLearningCard(String title, String subtitle, IconData icon, Color color, VoidCallback accion) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Colors.white10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.3)),
        trailing: const Icon(Icons.bolt, color: Color.fromARGB(255, 241, 57, 165), size: 18),
        onTap: accion,
      ),
    );
  }
}

// --- SUB-PÁGINA DINÁMICA ---
class PaginaDetalleHistoriaInteractive extends StatefulWidget {
  final Historia historia;
  final VoidCallback onEstadoCambiado;
  final VoidCallback onBorrarHistoria;

  const PaginaDetalleHistoriaInteractive({
    super.key, 
    required this.historia, 
    required this.onEstadoCambiado,
    required this.onBorrarHistoria,
  });

  @override
  State<PaginaDetalleHistoriaInteractive> createState() => _PaginaDetalleHistoriaInteractiveState();
}

class _PaginaDetalleHistoriaInteractiveState extends State<PaginaDetalleHistoriaInteractive> {
  bool _mostrarSoloBorradores = false;

  void _editarDatosHistoria() {
    final tituloController = TextEditingController(text: widget.historia.titulo);
    final sinopsisController = TextEditingController(text: widget.historia.sinopsis);
    final etiquetasController = TextEditingController(text: widget.historia.etiquetas.join(', '));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 24, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Editar Detalles de la Obra', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: tituloController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Título de la obra',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: sinopsisController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Sinopsis / Resumen',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: etiquetasController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Etiquetas (separadas por comas)',
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF252525),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 57, 165),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (tituloController.text.trim().isNotEmpty) {
                        List<String> nuevaListaEtiquetas = etiquetasController.text
                            .split(',')
                            .map((e) => e.trim().toLowerCase())
                            .where((e) => e.isNotEmpty)
                            .toList();

                        setState(() {
                          widget.historia.titulo = tituloController.text.trim();
                          widget.historia.sinopsis = sinopsisController.text.trim().isEmpty ? 'Sin sinopsis disponible.' : sinopsisController.text.trim();
                          widget.historia.etiquetas = nuevaListaEtiquetas;
                        });
                        
                        widget.onEstadoCambiado();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('GUARDAR CAMBIOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editarPortadaUrl() {
    final urlController = TextEditingController(text: widget.historia.portadaUrl);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Editar URL de Portada', style: TextStyle(color: Colors.white, fontSize: 18)),
        content: TextField(
          controller: urlController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Nueva URL de la imagen',
            labelStyle: TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 241, 57, 165))),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              if (urlController.text.trim().isNotEmpty) {
                setState(() {
                  widget.historia.portadaUrl = urlController.text.trim();
                });
                widget.onEstadoCambiado();
              }
              Navigator.pop(context);
            },
            child: const Text('ACTUALIZAR', style: TextStyle(color: Color.fromARGB(255, 241, 57, 165), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _confirmarBorrarHistoria() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('¿Eliminar esta historia?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Esta acción eliminará permanentemente la obra "${widget.historia.titulo}" junto con todos sus capítulos publicados y borradores.', style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              widget.onBorrarHistoria();
              widget.onEstadoCambiado();
              Navigator.pop(context);
              Navigator.pop(context);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Historia eliminada de tus registros.')));
              }
            },
            child: const Text('ELIMINAR TODO', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _pantallaEscribirEditarCapitulo(Capitulo capitulo, {bool esNuevo = false}) {
    final tituloCapController = TextEditingController(text: esNuevo ? '' : capitulo.titulo);
    final contenidoController = TextEditingController(text: capitulo.contenido);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1A1A1A),
            title: Text(esNuevo ? 'Nuevo Capítulo' : 'Editando escrito', style: const TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: tituloCapController,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: 'Título del capítulo...',
                    hintStyle: TextStyle(color: Colors.white24),
                    border: InputBorder.none,
                  ),
                ),
                const Divider(color: Colors.white12, height: 20),
                Expanded(
                  child: TextField(
                    controller: contenidoController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                    decoration: const InputDecoration(
                      hintText: 'Escribe el siguiente hito de tu historia aquí...',
                      hintStyle: TextStyle(color: Colors.white12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orangeAccent),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            capitulo.titulo = tituloCapController.text.isEmpty ? 'Capítulo sin título' : tituloCapController.text;
                            capitulo.contenido = contenidoController.text;
                            capitulo.esBorrador = true;
                            capitulo.fechaModificacion = DateTime.now();
                            if (esNuevo) widget.historia.capitulos.add(capitulo);
                          });
                          widget.onEstadoCambiado();
                          Navigator.pop(context);
                        },
                        child: const Text('GUARDAR BORRADOR', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            capitulo.titulo = tituloCapController.text.isEmpty ? 'Capítulo sin título' : tituloCapController.text;
                            capitulo.contenido = contenidoController.text;
                            capitulo.esBorrador = false;
                            capitulo.fechaModificacion = DateTime.now();
                            if (esNuevo) widget.historia.capitulos.add(capitulo);
                          });
                          widget.onEstadoCambiado();
                          Navigator.pop(context);
                        },
                        child: const Text('PUBLICAR YA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _dialogoConfirmarCapitulo(Capitulo capitulo) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('¿Eliminar capítulo?', style: TextStyle(color: Colors.white)),
        content: Text('Esta acción borrará permanentemente "${capitulo.titulo}".', style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCELAR', style: TextStyle(color: Colors.grey))),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('BORRAR', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listaFiltrada = widget.historia.capitulos.where((c) => !_mostrarSoloBorradores || c.esBorrador).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(widget.historia.titulo, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note, color: Color.fromARGB(255, 241, 57, 165)),
            tooltip: 'Editar información básica',
            onPressed: _editarDatosHistoria,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            tooltip: 'Eliminar esta historia',
            onPressed: _confirmarBorrarHistoria,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'portada-${widget.historia.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.historia.portadaUrl, 
                        width: 85, 
                        height: 125, 
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 85, height: 125, color: Colors.white12,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _editarPortadaUrl,
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Color.fromARGB(255, 241, 57, 165),
                        child: Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.historia.totalPublicados} Publicados', style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text('${widget.historia.totalBorradores} Borradores activos', style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    
                    if (widget.historia.etiquetas.isEmpty)
                      const Text('Sin etiquetas', style: TextStyle(color: Colors.white24, fontSize: 12))
                    else
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: widget.historia.etiquetas.map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 57, 165).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color.fromARGB(50, 241, 57, 165)),
                          ),
                          child: Text('#$tag', style: const TextStyle(color: Color.fromARGB(255, 241, 57, 165), fontSize: 11, fontWeight: FontWeight.bold)),
                        )).toList(),
                      ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          
          const Text('Sinopsis', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              widget.historia.sinopsis,
              style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
          ),
          
          const SizedBox(height: 25),
          
          Row(
            children: [
              ChoiceChip(
                label: const Text('Todos los capítulos'),
                selected: !_mostrarSoloBorradores,
                selectedColor: const Color.fromARGB(255, 241, 57, 165),
                backgroundColor: const Color(0xFF1E1E1E),
                labelStyle: TextStyle(color: _mostrarSoloBorradores ? Colors.grey : Colors.white, fontWeight: FontWeight.bold),
                onSelected: (val) => setState(() => _mostrarSoloBorradores = false),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Solo Borradores 📝'),
                selected: _mostrarSoloBorradores,
                selectedColor: Colors.orange,
                backgroundColor: const Color(0xFF1E1E1E),
                labelStyle: TextStyle(color: _mostrarSoloBorradores ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
                onSelected: (val) => setState(() => _mostrarSoloBorradores = true),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          if (listaFiltrada.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No se encontraron capítulos en esta categoría.', style: TextStyle(color: Colors.grey))),
            ),

          ...listaFiltrada.map((capitulo) => Dismissible(
            key: Key(capitulo.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: Colors.redAccent.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(12)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Eliminar escrito ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.delete_sweep, color: Colors.white),
                ],
              ),
            ),
            confirmDismiss: (direction) => _dialogoConfirmarCapitulo(capitulo),
            onDismissed: (direction) {
              setState(() {
                widget.historia.capitulos.remove(capitulo);
              });
              widget.onEstadoCambiado();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${capitulo.titulo}" eliminado correctamente.')));
            },
            child: Card(
              color: const Color(0xFF1E1E1E),
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(capitulo.titulo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  capitulo.esBorrador ? 'Borrador guardado' : 'Capítulo publicado con éxito',
                  style: TextStyle(color: capitulo.esBorrador ? Colors.orangeAccent : Colors.greenAccent, fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                      onPressed: () => _pantallaEscribirEditarCapitulo(capitulo),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                      onPressed: () async {
                        bool? confirmar = await _dialogoConfirmarCapitulo(capitulo);
                        if (confirmar == true) {
                          setState(() {
                            widget.historia.capitulos.remove(capitulo);
                          });
                          widget.onEstadoCambiado();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${capitulo.titulo}" eliminado correctamente.')));
                          }
                        }
                      },
                    ),
                  ],
                ),
                onTap: () => _pantallaEscribirEditarCapitulo(capitulo),
              ),
            ),
          )),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 241, 57, 165),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Capitulo nuevoCap = Capitulo(id: DateTime.now().toString(), titulo: '', contenido: '', esBorrador: true, fechaModificacion: DateTime.now());
              _pantallaEscribirEditarCapitulo(nuevoCap, esNuevo: true);
            },
            icon: const Icon(Icons.create, color: Colors.white, size: 18),
            label: const Text('ESCRIBIR UN NUEVO CAPÍTULO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _Badge({required this.text, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}