import 'package:flutter/material.dart';
import 'package:flutter_examen/routes/app_routes.dart';
import 'package:flutter_examen/services/categorias_service.dart';
import 'package:flutter_examen/services/product_service.dart';
import 'package:flutter_examen/services/proveedores_service.dart'; 
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'theme/theme.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => ProveedorService()), 
        ChangeNotifierProvider(create: (_) => CategoriaService()), 
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo clase 07',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}
