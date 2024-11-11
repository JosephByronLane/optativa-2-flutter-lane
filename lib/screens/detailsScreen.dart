import 'package:examen_movil/modules/details/domain/dto/productDetailResponse.dart';
import 'package:examen_movil/modules/details/useCase/use_case.dart';
import 'package:examen_movil/screens/cartScreen.dart'; 
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class Detailsscreen extends StatefulWidget {
  final int productId;

  const Detailsscreen({super.key, required this.productId});

  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  int _selectedQuantity = 1;
  final LocalStorage storage = LocalStorage('localstorage_app');
  int _availableStock = 0;

  @override
  Widget build(BuildContext context) {
    Future<ProductDetailResponse> futureProductDetail =
        ProductDetailUseCase().execute(widget.productId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Detalle de producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<ProductDetailResponse>(
        future: futureProductDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData) {
            ProductDetailResponse product = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.images.isNotEmpty)
                    Image.network(
                      product.images[0],
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  Center(
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      product.description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio: \$${product.price}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Disponible: ${product.stock}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cantidad a agregar:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      DropdownButton<int>(
                        value: _selectedQuantity,
                        items: List.generate(
                          product.stock > 99 ? 99 : product.stock,
                          (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedQuantity = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => addToCart(product),
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No product details available.'),
            );
          }
        },
      ),
    );
  }

  void addToCart(ProductDetailResponse product) async {
    await storage.ready;
    List<dynamic> cart = storage.getItem('cart') ?? [];

    int existingProductIndex = cart.indexWhere((item) => item['name'] == product.title);

    if (existingProductIndex != -1) {
      var existingProduct = cart[existingProductIndex];
      int updatedQuantity = existingProduct['quantity'] + _selectedQuantity;

      if (updatedQuantity > product.stock) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cantidad excede el stock disponible.'),
          ),
        );
        return;
      }

      existingProduct['quantity'] = updatedQuantity;
      existingProduct['totalPrice'] = updatedQuantity * product.price;

      cart[existingProductIndex] = existingProduct;
    } else {
      if (cart.length >= 7) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solo puedes agregar hasta 7 productos.'),
          ),
        );
        return;
      }

      cart.add({
        'image': product.images.isNotEmpty ? product.images[0] : null,
        'name': product.title,
        'quantity': _selectedQuantity,
        'price': product.price,
        'totalPrice': _selectedQuantity * product.price,
        'dateAdded': DateTime.now().toIso8601String(),
      });
    }

    storage.setItem('cart', cart);
  }
}
