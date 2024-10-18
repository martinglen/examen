import 'package:flutter/material.dart';
import 'package:flutter_examen/services/proveedores_service.dart';
import 'package:provider/provider.dart';
import '../providers/proveedor_form.dart';
import 'package:flutter_examen/ui/input_decorations.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProveedorFormProvider(proveedorService.selectedProveedor!),
      child: _ProveedorScreenBody(
        proveedorService: proveedorService,
      ),
    );
  }
}

class _ProveedorScreenBody extends StatelessWidget {
  const _ProveedorScreenBody({
    Key? key,
    required this.proveedorService,
  }) : super(key: key);

  final ProveedorService proveedorService;

  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _ProveedorForm(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              bool success = await proveedorService.deleteProveedor(proveedorForm.proveedor, context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proveedor eliminado con éxito.')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed('listpro'); 
                });
              }
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),

          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {

              
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.editOrCreateProveedor(proveedorForm.proveedor);              
              await proveedorService.loadProveedores();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proveedor guardado con éxito.')),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed('listpro'); 
              });
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProveedorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    final proveedor = proveedorForm.proveedor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: proveedorForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: proveedor.providerId.toString(), 
                readOnly: true, 
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'ID del proveedor',
                  labelText: 'ID:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerName,
                onChanged: (value) => proveedor.providerName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del proveedor',
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerLastName,
                onChanged: (value) => proveedor.providerLastName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El apellido es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Apellido del proveedor',
                  labelText: 'Apellido:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.providerMail,
                onChanged: (value) => proveedor.providerMail = value,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Correo electrónico inválido';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Correo electrónico',
                  labelText: 'Correo:',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: proveedor.providerState,
                items: const [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                ],
                onChanged: (value) {
                  proveedor.providerState = value ?? 'Inactivo';
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Estado del Proveedor:',
                  hintText: 'Selecciona el estado',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ],
      );
}
