import 'package:flutter/material.dart';
import 'package:flutter_examen/models/productos.dart';

class ProductCard extends StatelessWidget {
  final Listado product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: _getProductImage(product.productImage),
        ),
        title: Text(product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio: \$${product.productPrice.toStringAsFixed(2)}'),
            Text(
              'Disponible: ${_handleAvailable(product.productState)}',
              style: TextStyle(
                color: _getAvailableColor(product.productState),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _getProductImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.image, size: 40); 
    } else {
      return Image.network(imageUrl, fit: BoxFit.cover);
    }
  }

  Color _getAvailableColor(String state) {
    
    if (state == "Activo") {
      return Colors.green; 
    } else {
      return Colors.red;
    }
  }

  String _handleAvailable(String state) {
    return state;
  }
}
