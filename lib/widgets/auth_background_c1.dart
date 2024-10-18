// archivo: widgets/auth_background_c1.dart

import 'package:flutter/material.dart';

class AuthBackgroundC1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.4, // 40% de la pantalla
      decoration: _orangeDecoration(),
      child: Stack(
        children: [
          Positioned(
            child: _Bubble(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Bubble(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _Bubble(),
            top: -50,
            right: -20,
          ),
          Positioned(
            child: _Bubble(),
            bottom: -50,
            left: -20,
          ),
          Positioned(
            child: _Bubble(),
            bottom: 120,
            right: 20,
          ),
          Positioned(
            child: _Bubble(),
            bottom: 20,
            right: 80,
          ),
        ],
      ),
    );
  }

  BoxDecoration _orangeDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 165, 0, 1),
            Color.fromRGBO(255, 100, 2, 1),
          ],
        ),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.15),
      ),
    );
  }
}
