import 'package:flutter/material.dart';
import 'package:flutter_examen/services/product_service.dart';
import 'package:flutter_examen/widgets/product_image.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'package:flutter_examen/ui/input_decorations.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.SelectProduct!),
      child: _ProductScreenBody(
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.SelectProduct!.productImage,
              ),
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
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  onPressed: () {
                   //en caso de agregar carro de compras 
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
             
              bool success = await productService.deleteProduct(productForm.product, context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Producto eliminado con éxito.')),
                );

                await productService.loadProducts();
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed('list'); 
                });
              }
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.data_saver_on_sharp),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.product);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Producto guardado con éxito.')),
              );

              await productService.loadProducts();

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed('list');
              });
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productImage,
                onChanged: (value) => product.productImage = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'La URL es obligatoria';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'URL',
                  labelText: 'Imagen:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: product.productState, 
                items: const [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                ],
                onChanged: (value) {
                  product.productState = value ?? 'Inactivo';
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Estado del Producto:',
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
