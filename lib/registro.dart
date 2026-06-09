import 'package:flutter/material.dart';
import 'user_storage.dart';
import 'insesion.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        title: const Text("Crear Cuenta Lectora", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Icon(Icons.menu_book, color: Color(0xFFBB86FC), size: 60),
            const SizedBox(height: 20),
            _inputField("Nombre de usuario", Icons.person, TextEditingController()),
            _inputField("Correo electrónico", Icons.email, emailController),
            _inputField("Contraseña", Icons.lock, passController, isPass: true),
            _inputField("Confirmar contraseña", Icons.lock, confirmPassController, isPass: true),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB86FC),
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                if (passController.text == confirmPassController.text && emailController.text.isNotEmpty) {
                  UserStorage.saveUser(emailController.text, passController.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("¡Registro exitoso!")));
                  Navigator.pop(context);
                }
              },
              child: const Text("Registrarse", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
              child: const Text("¿Ya tienes cuenta? Inicia Sesión", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, IconData icon, TextEditingController controller, {bool isPass = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPass,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: const Color(0xFF6A1B9A)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFBB86FC))),
        ),
      ),
    );
  }
}