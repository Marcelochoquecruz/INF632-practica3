import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grilla/widgets/back_to_home_button.dart';
import 'package:grilla/widgets/back_button.dart'; // Importar el nuevo widget

class PalindromeView extends StatefulWidget {
  const PalindromeView({super.key});

  @override
  _PalindromeViewState createState() => _PalindromeViewState();
}

class _PalindromeViewState extends State<PalindromeView> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _reversedText = '';
  bool _showAnimation = false;
  final List<String> _examples = [
    'reconocer',
    'anilina',
    'oso',
    'somos o no somos',
    'Anita lava la tina',
  ];

  void _checkPalindrome() {
    final text =
        _controller.text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    final reversed = text.split('').reversed.join('');
    final isPalindrome = text == reversed;

    setState(() {
      _result =
          isPalindrome ? '¡Es un palíndromo! 🎉' : 'No es un palíndromo 😕';
      _reversedText = reversed;
      _showAnimation = true;
    });
  }

  void _useExample(String example) {
    _controller.text = example;
    _checkPalindrome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card de información
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome,
                              color: Colors.purple, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            'Verificador de Palíndromos',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 10),
                      const ExpansionTile(
                        title: Text('¿Qué es un palíndromo?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Un palíndromo es una palabra o frase que se lee igual de izquierda a derecha que de derecha a izquierda, ignorando espacios, signos de puntuación y mayúsculas.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Card de ejemplos
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ejemplos:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _examples
                            .map((example) => ActionChip(
                                  label: Text(example),
                                  onPressed: () => _useExample(example),
                                  backgroundColor: Colors.purple[100],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Card de entrada
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Ingrese una palabra o frase',
                          hintText: 'Ejemplo: reconocer',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.text_fields),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _checkPalindrome,
                        icon: const Icon(Icons.search),
                        label: const Text('Verificar'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Resultados
              if (_result.isNotEmpty)
                AnimatedOpacity(
                  opacity: _showAnimation ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Card(
                    elevation: 4,
                    color: _result.contains('Es')
                        ? Colors.green[50]
                        : Colors.red[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _result.contains('Es')
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: _result.contains('Es')
                                    ? Colors.green
                                    : Colors.red,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _result,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _result.contains('Es')
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                ),
                              ),
                            ],
                          ),
                          if (_result.contains('No')) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Al revés se lee: $_reversedText',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),

          // O si quieres especificar una navegación personalizada:
              BackButtonWidget(
                onPressed: () => Get.toNamed('/home'),
              ),
              BackToHomeButton(
                onPressed: () => Get.toNamed('/'),
              ),            ],
          ),
        ),
      ),
    );
  }
}
