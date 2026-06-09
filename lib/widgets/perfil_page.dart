import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Estado para manejar el nombre y la URL de la imagen
  String _userName = 'Andrea Roldan';
  String _userImage = 'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/PERFIL.JPG';

  // Lista de imágenes de perfil predefinidas para elegir
  final List<String> _profileImages = [
    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/PERFIL.JPG',
    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/rey.JPG',
    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/spider.JPG',
    'https://raw.githubusercontent.com/RoldanOrtega/Imagenes-Act9/main/orgullo.JPG',
  ];

  // --- 1. Diálogo para editar el nombre ---
  Future<void> _showEditNameDialog() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Cambiar Nombre', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: nameController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Nuevo nombre',
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(nameController.text);
            },
            child: const Text('Guardar', style: TextStyle(color: Color(0xFFBB86FC))),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _userName = newName;
      });
    }
  }

  // --- 2. Diálogo para cambiar la imagen de perfil ---
  Future<void> _showChangeImageDialog() async {
    final selectedImage = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Elige una foto de perfil', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _profileImages
                .map((img) => GestureDetector(
                      onTap: () => Navigator.of(context).pop(img),
                      child: CircleAvatar(radius: 40, backgroundImage: NetworkImage(img)),
                    ))
                .toList(),
          ),
        ),
      ),
    );

    if (selectedImage != null) {
      setState(() {
        _userImage = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- 3. Stack para el botón de cambio de imagen ---
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(_userImage),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Material(
                    color: const Color(0xFFBB86FC),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: _showChangeImageDialog,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.camera_alt, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // --- 4. Fila para el nombre y el botón de edición ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _userName, // Nombre de usuario dinámico
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
                  onPressed: _showEditNameDialog,
                ),
              ],
            ),
            const Text(
              'andrea.roldan@example.com', // El email se mantiene estático
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 241, 57, 165),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
              child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
