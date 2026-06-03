import 'package:flutter/material.dart';
import 'pagina7.dart'; // Importante para la navegación

class Pagina6 extends StatelessWidget {
  const Pagina6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Barra de búsqueda con botón Cancelar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            255,
                            162,
                            243,
                          ).withValues(alpha: 0.5),
                        ),
                      ),
                      child: TextField(
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        // CONEXIÓN 1: Al presionar "Enter" o "Buscar" en el teclado
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Pagina7(),
                            ),
                          );
                        },
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.orange,
                            size: 20,
                          ),
                          hintText: 'Buscar historias o personas',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Filtros: Título, Etiqueta, Perfil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _filtroCapsula('Título'),
                  _filtroCapsula('Etiqueta'),
                  _filtroCapsula('Perfil'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BÚSQUEDAS RECIENTES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Lista de búsquedas
            Expanded(
              child: ListView(
                children: [
                  // CONEXIÓN 2: Al tocar un elemento de la lista
                  _itemBusqueda(context, 'Azazel_lector'),
                  _itemBusqueda(context, 'anomalías en spaider-ghotam'),
                  _itemBusqueda(context, 'Peter Parker y batfamily'),
                  _itemBusqueda(context, 'peterxstiles'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filtroCapsula(String texto) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  // Se añadió 'context' para poder navegar
  Widget _itemBusqueda(BuildContext context, String texto) {
    return ListTile(
      leading: const Icon(Icons.search, color: Colors.grey, size: 22),
      title: Text(
        texto,
        style: const TextStyle(color: Colors.grey, fontSize: 15),
      ),
      trailing: const Icon(Icons.close, color: Colors.grey, size: 20),
      onTap: () {
        // Navega a la Página 7 al tocar el historial
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Pagina7()),
        );
      },
    );
  }
}
