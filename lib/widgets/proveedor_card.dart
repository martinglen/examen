import 'package:flutter/material.dart';
import 'package:flutter_examen/models/proveedores.dart'; 

class ProveedorCard extends StatelessWidget {
  final ListadoProveedor proveedor; 

  const ProveedorCard({Key? key, required this.proveedor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text('${proveedor.providerName} ${proveedor.providerLastName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Correo: ${proveedor.providerMail}'), 
            Text('ID: ${proveedor.providerId}'),
            Text(
              'Estado: ${_handleProveedorState(proveedor.providerState)}',
              style: TextStyle(
                color: _getProveedorStateColor(proveedor.providerState), 
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Color _getProveedorStateColor(String state) {
    if (state == "Activo") {
      return Colors.green; 
    } else {
      return Colors.red;
    }
  }

  String _handleProveedorState(String state) {
    return state;
  }
}
