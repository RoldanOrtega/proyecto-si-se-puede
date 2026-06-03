import 'package:flutter/material.dart';
import 'widgets/pagina1.dart';
import 'widgets/pagina2.dart';
import 'widgets/pagina3.dart';
import 'widgets/pagina4.dart';
import 'widgets/pagina5.dart';

void main() => runApp(const LecturasRoldanApp());

class LecturasRoldanApp extends StatelessWidget {
  const LecturasRoldanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // El orden de las páginas debe coincidir con los iconos del BottomNav
  final List<Widget> _paginas = [
    const Pagina1(), // Inicio (Icono Home)
    const Pagina5(), // Buscador (Icono Lupa)
    const Pagina2(), // Biblioteca (Icono Libros)
    const Pagina3(), // Escribir (Icono Lápiz)
    const Pagina4(), // Notificaciones (Icono Campana)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _paginas),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 255, 155, 225),
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 26),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('4'),
              child: Icon(Icons.notifications_none),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
