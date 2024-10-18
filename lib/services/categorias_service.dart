import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_examen/models/categorias.dart';

class CategoriaService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListadoCategoria> categorias = [];
  ListadoCategoria? selectedCategoria;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoriaService() {
    loadCategorias(); 
  }

  Future<void> loadCategorias() async {
    isLoading = true; 
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final categoriasMap = categoriasDartFromJson(response.body);
      categorias = categoriasMap.listadoCategorias; 
    } else {
      print('Error al cargar categorías: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> editOrCreateCategoria(ListadoCategoria categoria) async {
    isEditCreate = true; 
    notifyListeners();

    if (categoria.categoryId == 0) {
      await createCategoria(categoria);
    } else {
      await updateCategoria(categoria);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateCategoria(ListadoCategoria categoria) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    
    final response = await http.post(
      url,
      body: json.encode(categoria.toJson()),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = response.body;
    print(decodeResp);

    final index = categorias.indexWhere((element) => element.categoryId == categoria.categoryId);
    if (index != -1) {
      categorias[index] = categoria; 
    }

    return '';
  }


  Future<String> createCategoria(ListadoCategoria categoria) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    
    final response = await http.post(
      url,
      body: json.encode(categoria.toJson()), 
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = response.body; 
    print(decodeResp);

    categorias.add(categoria);
    return '';
  }

  Future<bool> deleteCategoria(ListadoCategoria categoria, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    
    final response = await http.post(
      url,
      body: json.encode(categoria.toJson()), 
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      categorias.removeWhere((element) => element.categoryId == categoria.categoryId);
      await loadCategorias();
      return true;
    } else {
      print('Error al eliminar la categoría: ${response.statusCode}');
      return false;
    }
  }
}
