import 'package:flutter/material.dart';
import 'package:flutter_examen/screen/login_screen.dart';
import 'package:flutter_examen/screen/register_user_screen.dart';
import 'package:flutter_examen/screen/pantalla_principal_screen.dart';
import 'package:flutter_examen/screen/list_product_screen.dart'; 
import 'package:flutter_examen/screen/edit_product_screen.dart'; 
import 'package:flutter_examen/screen/list_proveedor_screen.dart'; 
import 'package:flutter_examen/screen/edit_proveedor_screen.dart'; 
import 'package:flutter_examen/screen/edit_categoria_screen.dart';  
import 'package:flutter_examen/screen/list_categoria_screen.dart'; 

class AppRoutes {
  static const initialRoute = 'login'; // paginea de inciio'
  
  static final routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const RegisterUserScreen(),
    'principal': (BuildContext context) => PantallaPrincipalScreen(),
    'list': (BuildContext context) => const ListProductScreen(), 
    'edit': (BuildContext context) => const EditProductScreen(), 
    'listpro': (BuildContext context) => const ListProveedorScreen(), 
    'editpro': (BuildContext context) => const EditProveedorScreen(), 
    'listcat': (BuildContext context) => const ListCategoriaScreen(), 
    'editcat': (BuildContext context) => const EditCategoriaScreen(), 
    
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );
  }
}
