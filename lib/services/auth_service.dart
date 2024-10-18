import 'package:flutter/material.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAiD1lJoB5Y_AgRivCwrzlbdZM1QCP_uLE';
  
  String? _token = ''; 
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    
    try {
      final response = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      
      if (decodeResponse.containsKey('idToken')) {
        _token = decodeResponse['idToken']; 
     
        return null; 
      } else {
        return decodeResponse['error']['message']; 
      }
    } catch (e) {
      return 'Error de conexión: $e'; 
    }
  }

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    
    try {
      final response = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      
      if (decodeResponse.containsKey('idToken')) {
        _token = decodeResponse['idToken']; 
        return null; 
      } else {
        return decodeResponse['error']['message']; 
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); 
  }
}
