import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargando...'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Indicador de carga
            SizedBox(height: 20), // Espacio entre el indicador y el texto
            Text(
              'Por favor, espera mientras se cargan los datos...',
              style: TextStyle(fontSize: 16), // Estilo del texto
            ),
          ],
        ),
      ),
    );
  }
}