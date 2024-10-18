import 'package:flutter/material.dart';
import 'package:flutter_examen/widgets/custom_button.dart'; // Importa el widget

class PantallaPrincipalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXAMEN...'),        
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BIENVENIDOS!!!...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
    
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  CustomButton(
                    title: 'PROVEEDORES',
                    icon: Icons.account_box,
                    onPressed: () {
                         Navigator.pushReplacementNamed(context, 'listpro');
                    },
                  ),
                  CustomButton(
                    title: 'CATEGORIAS',
                    icon: Icons.category,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'listcat');
                    },
                  ),
                  CustomButton(
                    title: 'PRODUCTOS',
                    icon: Icons.production_quantity_limits,
                    onPressed: () {
                        Navigator.pushReplacementNamed(context, 'list');
                    },
                  ),
                  CustomButton(
                    title: 'CERRAR SESIÓN',
                    icon: Icons.disabled_by_default_rounded,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
