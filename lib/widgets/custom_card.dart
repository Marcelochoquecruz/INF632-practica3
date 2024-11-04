import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              'Docente:',
              'M. Sc. Huascar Fedor Gonzales Guzman',
              context,
            ),
            const SizedBox(height: 15),
            _buildInfoRow(
              'Auxiliar:',
              'Univ.',
              context,
            ),
            const SizedBox(height: 15),
            _buildInfoRow(
              'Estudiante:',
              'Univ. Marcelo Choque Cruz',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black, // Color cambiado a negro
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Color cambiado a negro para consistencia
            ),
          ),
        ),
      ],
    );
  }
}
