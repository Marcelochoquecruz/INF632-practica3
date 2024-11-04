import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';
import 'package:grilla/widgets/back_button.dart';
import 'package:grilla/widgets/back_to_home_button.dart';

class FriendlyNumbersView extends StatefulWidget {
  const FriendlyNumbersView({super.key});

  @override
  _FriendlyNumbersViewState createState() => _FriendlyNumbersViewState();
}

class _FriendlyNumbersViewState extends State<FriendlyNumbersView> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = '';
  List<int> _divisors1 = [];
  List<int> _divisors2 = [];
  bool _showDetails = false;

  List<int> _calculateDivisors(int number) {
    List<int> divisors = [];
    for (int i = 1; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        divisors.add(i);
      }
    }
    return divisors;
  }

  int _sumOfDivisors(List<int> divisors) {
    return divisors.fold(0, (sum, divisor) => sum + divisor);
  }

  void _checkFriendlyNumbers() {
    final num1 = int.tryParse(_num1Controller.text);
    final num2 = int.tryParse(_num2Controller.text);

    if (num1 != null && num2 != null) {
      _divisors1 = _calculateDivisors(num1);
      _divisors2 = _calculateDivisors(num2);

      final sum1 = _sumOfDivisors(_divisors1);
      final sum2 = _sumOfDivisors(_divisors2);

      setState(() {
        if (sum1 == num2 && sum2 == num1) {
          _result = '¡Son números amigos! 🎉';
        } else {
          _result = 'No son números amigos 😕';
        }
        _showDetails = true;
      });
    } else {
      setState(() {
        _result = 'Por favor, ingresa números válidos ⚠️';
        _showDetails = false;
      });
    }
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
              // Título y descripción
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
                          const Icon(Icons.favorite,
                              color: Colors.red, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            'Números Amigos',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      ExpansionTile(
                        title: const Text(
                          '¿Qué son los números amigos?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Definición matemática:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Math.tex(
                                  r'\text{Si } \sum_{d|a, d\neq a} d = b \text{ y } \sum_{d|b, d\neq b} d = a',
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Ejemplo clásico: 220 y 284',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '220: 1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110 = 284',
                                ),
                                const Text(
                                  '284: 1, 2, 4, 71, 142 = 220',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Inputs y botón
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
                        controller: _num1Controller,
                        decoration: InputDecoration(
                          labelText: 'Primer número',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.looks_one),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _num2Controller,
                        decoration: InputDecoration(
                          labelText: 'Segundo número',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.looks_two),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _checkFriendlyNumbers,
                        icon: const Icon(Icons.search),
                        label: const Text('Verificar'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Resultados
              if (_result.isNotEmpty)
                AnimatedOpacity(
                  opacity: _result.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Card(
                    elevation: 4,
                    color: _result.contains('amigos')
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
                          Text(
                            _result,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _result.contains('amigos')
                                  ? Colors.green[800]
                                  : Colors.red[800],
                            ),
                          ),
                          if (_showDetails) ...[
                            const SizedBox(height: 8),
                            const Text('Divisores del primer número:'),
                            Text(_divisors1.join(', ')),
                            Text('Suma: ${_sumOfDivisors(_divisors1)}'),
                            const SizedBox(height: 8),
                            const Text('Divisores del segundo número:'),
                            Text(_divisors2.join(', ')),
                            Text('Suma: ${_sumOfDivisors(_divisors2)}'),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16), // Espacio adicional
            ],
          ),
        ),
      ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BackButtonWidget(
              onPressed: () => Get.toNamed('/home'),
            ),
            BackToHomeButton(
              onPressed: () => Get.toNamed('/'),
            ),
          ],
        ),
      );
  }
}
