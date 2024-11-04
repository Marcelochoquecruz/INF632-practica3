import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';
import 'package:grilla/widgets/back_button.dart';
import 'package:grilla/widgets/back_to_home_button.dart';

class BinaryConverterView extends StatefulWidget {
  const BinaryConverterView({super.key});

  @override
  _BinaryConverterViewState createState() => _BinaryConverterViewState();
}

class _BinaryConverterViewState extends State<BinaryConverterView> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _steps = '';
  bool _showSteps = false;

  void _generateConversionSteps(int number) {
    List<String> steps = [];
    int temp = number;
    List<int> remainders = [];

    while (temp > 0) {
      remainders.add(temp % 2);
      temp = temp ~/ 2;
    }

    for (int i = 0; i < remainders.length; i++) {
      steps.add(
          '${number ~/ _pow(2, i)} ÷ 2 = ${number ~/ _pow(2, i + 1)} resto ${remainders[i]}');
    }

    setState(() {
      _steps = steps.join('\n');
    });
  }

  int _pow(int base, int exponent) {
    int result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  void _convertToBinary() {
    final number = int.tryParse(_controller.text);
    if (number != null) {
      final binary = number.toRadixString(2);
      setState(() {
        _result = binary;
        _generateConversionSteps(number);
        _showSteps = true;
      });
    } else {
      setState(() {
        _result = 'Error';
        _steps = '';
        _showSteps = false;
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
              // Tarjeta de información
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
                          const Icon(Icons.computer,
                              color: Colors.blue, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            'Convertidor Binario',
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
                        title: const Text('¿Qué es el sistema binario?'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'El sistema binario es fundamental en la computación:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Math.tex(
                                  r'2^n + 2^{n-1} + ... + 2^1 + 2^0',
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                const Text('Ejemplo: 9 en binario'),
                                const Text(
                                    '9 = 1001₂ = 1×2³ + 0×2² + 0×2¹ + 1×2⁰'),
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

              // Tarjeta de conversión
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
                          labelText: 'Número decimal',
                          hintText: 'Ejemplo: 42',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.numbers),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _convertToBinary,
                        icon: const Icon(Icons.transform),
                        label: const Text('Convertir'),
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
                    color:
                        _result != 'Error' ? Colors.green[50] : Colors.red[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resultado:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _result != 'Error'
                              ? Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      _result,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800],
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Icon(Icons.error,
                                        color: Colors.red, size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Por favor, ingresa un número válido',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red[800],
                                      ),
                                    ),
                                  ],
                                ),
                          if (_showSteps && _result != 'Error') ...[
                            const Divider(height: 20),
                            const Text(
                              'Pasos de la conversión:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(_steps),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
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
