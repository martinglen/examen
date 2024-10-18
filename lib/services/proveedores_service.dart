import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_examen/models/proveedores.dart'; 
class ProveedorService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListadoProveedor> proveedores = [];
  ListadoProveedor? selectedProveedor;
  bool isLoading = true;
  bool isEditCreate = true;

  ProveedorService() {
    loadProveedores(); 
  }

  
  Future<void> loadProveedores() async {
    isLoading = true; 
    notifyListeners();

    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});

    
    if (response.statusCode == 200) {
      final proveedoresMap = proveedoresDartFromJson(response.body);
      proveedores = proveedoresMap.listadoProveedores; 
    } else {
      print('Error al cargar proveedores: ${response.statusCode}');
    }

    isLoading = false; 
    notifyListeners(); 
  }

  
Future<void> editOrCreateProveedor(ListadoProveedor proveedor) async {
  isEditCreate = true; 
  notifyListeners();

  
  print('El providerId es: ${proveedor.providerId}');

  if (proveedor.providerId == 0) {
    await createProveedor(proveedor); 
  } else {
    await updateProveedor(proveedor); 
  }

  isEditCreate = false; 
  notifyListeners();
}

  
  Future<String> updateProveedor(ListadoProveedor proveedor) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    

     final jsonBody = json.encode(proveedor.toJson());
      print('JSON Body: $jsonBody'); 

    final response = await http.post(
      url,
      body: json.encode(proveedor.toJson()), 
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = response.body; 
    print(decodeResp);

    
    final index = proveedores.indexWhere((element) => element.providerId == proveedor.providerId);
    if (index != -1) {
      proveedores[index] = proveedor;
    }

    return '';
  }

  
  Future<String> createProveedor(ListadoProveedor proveedor) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    
    final response = await http.post(
      url,
      body: json.encode(proveedor.toJson()), 
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final decodeResp = response.body; 
    print(decodeResp);

    proveedores.add(proveedor); 
    return '';
  }

  Future<bool> deleteProveedor(ListadoProveedor proveedor, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    
    final response = await http.post(
      url,
      body: json.encode(proveedor.toJson()), 
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    
    if (response.statusCode == 200) {
      proveedores.removeWhere((element) => element.providerId == proveedor.providerId); 
      await loadProveedores(); 
      return true;
    } else {
      print('Error al eliminar el proveedor: ${response.statusCode}');
      return false;
    }
  }
}
