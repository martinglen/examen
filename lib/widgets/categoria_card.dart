import 'package:flutter/material.dart';
import 'package:flutter_examen/models/categorias.dart'; 

class CategoriaCard extends StatelessWidget { 
  final ListadoCategoria categoria;

  const CategoriaCard({Key? key, required this.categoria}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(categoria.categoryName), 
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${categoria.categoryName}'), 
            Text('ID: ${categoria.categoryId}'), 
            Text(
              'Estado: ${_handleCategoriaState(categoria.categoryState)}',
              style: TextStyle(
                color: _getCategoriaStateColor(categoria.categoryState),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  
  Color _getCategoriaStateColor(String state) {
    if (state == "Activa") {
      return Colors.green; 
    } else {
      return Colors.red; 
    }
  }

  
  String _handleCategoriaState(String state) {
    return state; 
  }
}
