import 'package:flutter/material.dart';
import 'package:flutter_examen/models/categorias.dart'; 
import 'package:flutter_examen/screen/loading_screen.dart';
import 'package:flutter_examen/services/categorias_service.dart'; 
import 'package:flutter_examen/services/auth_service.dart';
import 'package:flutter_examen/widgets/categoria_card.dart';
import 'package:provider/provider.dart';

class ListCategoriaScreen extends StatefulWidget {
  const ListCategoriaScreen({super.key});

  @override
  _ListCategoriaScreenState createState() => _ListCategoriaScreenState();
}

class _ListCategoriaScreenState extends State<ListCategoriaScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final categoriaService = Provider.of<CategoriaService>(context);

    if (categoriaService.isLoading) return const LoadingScreen();

    final filteredCategories = categoriaService.categorias.where((categoria) {
      return categoria.categoryName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Categorías'),
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
      body: _CategoriaList(filteredCategories: filteredCategories),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoriaService.selectedCategoria = ListadoCategoria( 
            categoryId: 0,
            categoryName: '',
            categoryState: 'Activa',
          );
          Navigator.popAndPushNamed(context, 'editcat'); 
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
          hintText: 'Buscar categorías ...',
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

class _CategoriaList extends StatelessWidget {
  final List<ListadoCategoria> filteredCategories;

  const _CategoriaList({Key? key, required this.filteredCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredCategories.length,
      itemBuilder: (BuildContext context, index) => GestureDetector(
        onTap: () {
          final categoriaService = Provider.of<CategoriaService>(context, listen: false);
          categoriaService.selectedCategoria = filteredCategories[index].copy(); 
          Navigator.pushNamed(context, 'editcat'); 
        },
        child: CategoriaCard(categoria: filteredCategories[index]), 
      ),
    );
  }
}
