import 'package:flutter/material.dart'; 
import 'package:flutter_examen/models/productos.dart';
import 'package:flutter_examen/screen/loading_screen.dart';
import 'package:flutter_examen/services/product_service.dart';
import 'package:flutter_examen/services/auth_service.dart'; 
import 'package:flutter_examen/widgets/product_card.dart'; 
import 'package:provider/provider.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return const LoadingScreen();

    final filteredProducts = productService.products.where((product) {
      return product.productName.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
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
      body: _ProductList(filteredProducts: filteredProducts),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage:
                'https://as2.ftcdn.net/v2/jpg/02/51/95/53/1000_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg',
            productState: 'Activo',
          );
          Navigator.popAndPushNamed(context, 'edit');
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
          hintText: 'Buscar productos .....',
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

class _ProductList extends StatelessWidget {
  final List<Listado> filteredProducts;

  const _ProductList({Key? key, required this.filteredProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (BuildContext context, index) => GestureDetector(
        onTap: () {
          final productService = Provider.of<ProductService>(context, listen: false);
          productService.SelectProduct = filteredProducts[index].copy();
          Navigator.pushNamed(context, 'edit');
        },
        child: ProductCard(product: filteredProducts[index]), 
      ),
    );
  }
}
