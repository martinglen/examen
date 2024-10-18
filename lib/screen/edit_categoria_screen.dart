import 'package:flutter/material.dart';
import 'package:flutter_examen/services/categorias_service.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'package:flutter_examen/ui/input_decorations.dart';

class EditCategoriaScreen extends StatelessWidget {
  const EditCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriasService = Provider.of<CategoriaService>(context);
    return ChangeNotifierProvider(
      create: (_) => CategoriaFormProvider(categoriasService.selectedCategoria!), 
      child: _CategoriaScreenBody(
        categoriasService: categoriasService,
      ),
    );
  }
}

class _CategoriaScreenBody extends StatelessWidget {
  const _CategoriaScreenBody({
    Key? key,
    required this.categoriasService,
  }) : super(key: key);

  final CategoriaService categoriasService;

  @override
  Widget build(BuildContext context) {
    final categoriaForm = Provider.of<CategoriaFormProvider>(context);
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
            _CategoriaForm(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!categoriaForm.isValidForm()) return;
              bool success = await categoriasService.deleteCategoria(categoriaForm.categoria, context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Categoría eliminada con éxito.')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed('listcat'); 
                });
              }
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {
              if (!categoriaForm.isValidForm()) return;             
              await categoriasService.editOrCreateCategoria(categoriaForm.categoria);             
              await categoriasService.loadCategorias(); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Categoría guardada con éxito.')),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed('listcat'); 
              });
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _CategoriaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriaForm = Provider.of<CategoriaFormProvider>(context);
    final categoria = categoriaForm.categoria;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoriaForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: categoria.categoryName,
                onChanged: (value) => categoria.categoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de la categoría',
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: categoria.categoryState,
                items: const [
                  DropdownMenuItem(value: 'Activa', child: Text('Activa')),
                  DropdownMenuItem(value: 'Inactiva', child: Text('Inactiva')),
                ],
                onChanged: (value) {
                  categoria.categoryState = value ?? 'Inactiva';
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Estado de la Categoría:',
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
