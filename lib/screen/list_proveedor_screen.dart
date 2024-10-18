import 'package:flutter/material.dart';
import 'package:flutter_examen/models/proveedores.dart';
import 'package:flutter_examen/screen/loading_screen.dart';
import 'package:flutter_examen/services/proveedores_service.dart';
import 'package:flutter_examen/services/auth_service.dart';
import 'package:flutter_examen/widgets/proveedor_card.dart';
import 'package:provider/provider.dart';

class ListProveedorScreen extends StatefulWidget {
  const ListProveedorScreen({super.key});

  @override
  _ListProveedorScreenState createState() => _ListProveedorScreenState();
}

class _ListProveedorScreenState extends State<ListProveedorScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    if (proveedorService.isLoading) return const LoadingScreen();

    final filteredProveedores = proveedorService.proveedores.where((proveedor) {
      return proveedor.providerName.toLowerCase().contains(search.toLowerCase()) ||
             proveedor.providerLastName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Proveedores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.logout();
              Navigator.pushReplacementNamed(context, 'principal');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: _SearchField(
            onChanged: (value) {
              setState(() {
                search = value; 
              });
            },
          ),
        ),
      ),
      body: _ProveedorList(filteredProveedores: filteredProveedores),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          proveedorService.selectedProveedor = ListadoProveedor(
            providerId: 0,
            providerName: '',
            providerLastName: '',
            providerMail: '',
            providerState: 'Activo',
          );
          Navigator.popAndPushNamed(context, 'editpro');
        },
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar proveedores ...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class _ProveedorList extends StatelessWidget {
  final List<ListadoProveedor> filteredProveedores;

  const _ProveedorList({Key? key, required this.filteredProveedores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredProveedores.length,
      itemBuilder: (BuildContext context, index) => GestureDetector(
        onTap: () {
          final proveedorService = Provider.of<ProveedorService>(context, listen: false);
          proveedorService.selectedProveedor = filteredProveedores[index].copy();
          Navigator.pushNamed(context, 'editpro');
        },
        child: ProveedorCard(proveedor: filteredProveedores[index]),
      ),
    );
  }
}
