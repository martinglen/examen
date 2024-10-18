// archivo: widgets/auth_background.dart

import 'package:flutter/material.dart';
import 'package:flutter_examen/widgets/widgets.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          AuthBackgroundC1(), // Corrección del nombre de la clase
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              child: const Icon(
                Icons.person_pin_circle_rounded,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          child, // El widget hijo que se pasa como argumento
        ],
      ),
    );
  }
}
