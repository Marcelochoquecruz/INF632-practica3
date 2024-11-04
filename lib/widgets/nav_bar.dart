import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grilla/views/binary_converter_view.dart';
import 'package:grilla/views/friendly_numbers_view.dart';
import 'package:grilla/views/main_view.dart';
import 'package:grilla/views/palindrome_view.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NavBar({
    super.key,
    required this.title, required Color backgroundColor, required int elevation, required TextStyle titleStyle, required List<IconButton> actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A00E0), // Morado fuerte
            Color(0xFF8E2DE2), // Morado suave
            Color(0xFF00C9FF), // Azul claro
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Hacemos transparente el AppBar
        elevation: 0, // Sin sombra para que se vea más limpio
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.to(() => const MainView());
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white), // Ícono de menú
            onSelected: (value) {
              // Maneja la selección de la opción
              switch (value) {
                case 'palindrome':
                  Get.to(() =>
                       const PalindromeView()); // Navega a la vista de palíndromos
                  break;
                case 'friendlyNumbers':
                  Get.to(() =>
                       const FriendlyNumbersView()); // Navega a la vista de números amigos
                  break;
                case 'binaryConverter':
                  Get.to(() =>
                       const BinaryConverterView()); // Navega a la vista de convertidor binario
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'palindrome',
                  child: Text('Verificar Palíndromo'),
                ),
                const PopupMenuItem<String>(
                  value: 'friendlyNumbers',
                  child: Text('Números Amigos'),
                ),
                const PopupMenuItem<String>(
                  value: 'binaryConverter',
                  child: Text('Convertir a Binario'),
                ),
              ];
            },
          ),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Colors.white54,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
