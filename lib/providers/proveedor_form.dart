import 'package:flutter/material.dart';
import 'package:flutter_examen/models/proveedores.dart'; 

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); 
  ListadoProveedor proveedor; 

  ProveedorFormProvider(this.proveedor);

  
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false; 
  }

}
