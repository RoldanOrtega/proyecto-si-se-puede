import 'package:flutter/material.dart';

// --- MODELOS DE DATOS ---
class Notificacion {
  final String id;
  final String usuario;
  final String accion;
  final String tiempo;
  final String libroImg;
  final String usuarioImg;
  final String? comentarioOriginal;
  final IconData icono;

  Notificacion({
    required this.id,
    required this.usuario,
    required this.accion,
    required this.tiempo,
    required this.libroImg,
    required this.usuarioImg,
    this.comentarioOriginal,
    required this.icono,
  });
}

class MensajeChat {
  final String remitente;
  final String texto;
  final DateTime fecha;
  final bool esMio;

  MensajeChat({
    required this.remitente,
    required this.texto,
    required this.fecha,
    required this.esMio,
  });
}

class ChatPreview {
  final String id;
  final String usuario;
  final String usuarioImg;
  final List<MensajeChat> conversacion;

  ChatPreview({
    required this.id,
    required this.usuario,
    required this.usuarioImg,
    required this.conversacion,
  });

  String get ultimoMensaje => conversacion.isNotEmpty ? conversacion.last.texto : 'No hay mensajes';
  String get horaUltimoMensaje => '10:42 p. m.';
}

// --- PÁGINA PRINCIPAL DE ACTUALIZACIONES ---
class Pagina4 extends StatefulWidget {
  const Pagina4({super.key});

  @override
  State<Pagina4> createState() => _Pagina4State();
}

class _Pagina4State extends State<Pagina4> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Notificacion> _notificaciones = [
    Notificacion(
      id: 'n1',
      usuario: 'aazzaaazzssj',
      accion: 'publicó una nueva parte Bocetos y secretos en No Es Como Si Me Gustaras (Jondami)',
      tiempo: '7:33 a. m.',
      libroImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG',
      usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/PERFIL.JPG',
      icono: Icons.menu_book,
    ),
    Notificacion(
      id: 'n2',
      usuario: 'Azazel_lector',
      accion: 'publicó una nueva parte cap-10 anomalía en ☆ Spider-Gotham ☆',
      tiempo: 'Ayer a las 5:18 p. m.',
      libroImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro2.JPG',
      usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG',
      icono: Icons.menu_book,
    ),
    Notificacion(
      id: 'n3',
      usuario: 'Checock',
      accion: 'votó por Cap 1.',
      tiempo: 'Ayer a las 2:45 p. m.',
      libroImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/coraline3.0.JPG',
      usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/PERFIL.JPG',
      icono: Icons.star,
    ),
    Notificacion(
      id: 'n4',
      usuario: 'Sr_Alucard',
      accion: 'respondió un comentario en ¡Este necesita un novio! - Capítulo V.',
      tiempo: 'Ayer a las 2:27 p. m.',
      libroImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/libro3.JPG',
      usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/ll.JPG',
      comentarioOriginal: 'literal sjsjjs',
      icono: Icons.chat_bubble_outline,
    ),
  ];

  late List<ChatPreview> _chats;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    _chats = [
      ChatPreview(
        id: 'c1',
        usuario: 'Azazel_lector',
        usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/l.JPG',
        conversacion: [
          MensajeChat(remitente: 'Azazel_lector', texto: '¡Hola! Me encantó el último capítulo que subiste.', fecha: DateTime.now(), esMio: false),
          MensajeChat(remitente: 'Yo', texto: '¡Muchas gracias! Estuve trabajando toda la semana en él.', fecha: DateTime.now(), esMio: true),
          MensajeChat(remitente: 'Azazel_lector', texto: '¿Cuándo actualizas de nuevo?', fecha: DateTime.now(), esMio: false),
        ],
      ),
      ChatPreview(
        id: 'c2',
        usuario: 'Sr_Alucard',
        usuarioImg: 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/refs/heads/main/ll.JPG',
        conversacion: [
          MensajeChat(remitente: 'Sr_Alucard', texto: 'Oye, terminaste el dibujo del banner?', fecha: DateTime.now(), esMio: false),
        ],
      )
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _interactuarNotificacion(Notificacion notif) {
    final replyController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white12,
                  child: ClipOval(
                    child: Image.network(
                      notif.usuarioImg,
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey, size: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(notif.usuario, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Text(notif.accion, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            if (notif.comentarioOriginal != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
                child: Text('"${notif.comentarioOriginal}"', style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
              ),
            ],
            const Divider(color: Colors.white12, height: 25),
            TextField(
              controller: replyController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: notif.icono == Icons.star ? 'Escribe un message de agradecimiento...' : 'Escribe tu respuesta...',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                filled: true,
                fillColor: const Color(0xFF252525),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 241, 57, 165)),
                onPressed: () {
                  if (replyController.text.trim().isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Respuesta enviada a ${notif.usuario} ✨')),
                    );
                  }
                },
                child: const Text('ENVIAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _abrirChat(ChatPreview chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaChatIndividual(
          chat: chat,
          onMensajeEnviado: () => setState(() {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Actualizaciones',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscar nuevos amigos y escritores... 🔍')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 255, 159, 234),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('NOTIFICACIONES'),
                  const SizedBox(width: 6),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: Color.fromARGB(255, 241, 57, 165), shape: BoxShape.circle),
                  )
                ],
              ),
            ),
            const Tab(text: 'MENSAJES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificacionesTab(),
          _buildMensajesTab(),
        ],
      ),
    );
  }

  Widget _buildNotificacionesTab() {
    return ListView.builder(
      itemCount: _notificaciones.length,
      itemBuilder: (context, index) {
        final notif = _notificaciones[index];
        return InkWell(
          onTap: () => _interactuarNotificacion(notif),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white12,
                  child: ClipOval(
                    child: Image.network(
                      notif.usuarioImg,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          children: [
                            TextSpan(text: '${notif.usuario} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: notif.accion, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(notif.icono, size: 14, color: const Color.fromARGB(255, 241, 57, 165)),
                          const SizedBox(width: 6),
                          Text(notif.tiempo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      if (notif.comentarioOriginal != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          notif.comentarioOriginal!,
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    notif.libroImg, 
                    width: 40, 
                    height: 60, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40, 
                      height: 60, 
                      color: Colors.white12,
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMensajesTab() {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];
        return ListTile(
          onTap: () => _abrirChat(chat),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white12,
            child: ClipOval(
              child: Image.network(
                chat.usuarioImg,
                fit: BoxFit.cover,
                width: 44,
                height: 44,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey),
              ),
            ),
          ),
          title: Text(chat.usuario, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(
            chat.ultimoMensaje,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          trailing: Text(chat.horaUltimoMensaje, style: const TextStyle(color: Colors.white30, fontSize: 11)),
          shape: const Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
        );
      },
    );
  }
}

// --- PÁGINA DEL CHAT INDIVIDUAL ---
class PantallaChatIndividual extends StatefulWidget {
  final ChatPreview chat;
  final VoidCallback onMensajeEnviado;

  const PantallaChatIndividual({super.key, required this.chat, required this.onMensajeEnviado});

  @override
  State<PantallaChatIndividual> createState() => _PantallaChatIndividualState();
}

class _PantallaChatIndividualState extends State<PantallaChatIndividual> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _enviarMensaje() {
    final texto = _msgController.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        widget.chat.conversacion.add(
          MensajeChat(remitente: 'Yo', texto: texto, fecha: DateTime.now(), esMio: true),
        );
      });
      _msgController.clear();
      widget.onMensajeEnviado();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16, 
              backgroundColor: Colors.white12,
              child: ClipOval(
                child: Image.network(
                  widget.chat.usuarioImg,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey, size: 16),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.chat.usuario, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: widget.chat.conversacion.length,
              itemBuilder: (context, index) {
                final msg = widget.chat.conversacion[index];
                return Align(
                  alignment: msg.esMio ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg.esMio ? const Color.fromARGB(255, 241, 57, 165) : const Color(0xFF252525),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(msg.esMio ? 16 : 0),
                        bottomRight: Radius.circular(msg.esMio ? 0 : 16),
                      ),
                    ),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Text(
                      msg.texto,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1A1A1A),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje privado...',
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFF252525),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _enviarMensaje(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color.fromARGB(255, 241, 57, 165)),
                    onPressed: _enviarMensaje,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 