import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CartScreen extends StatelessWidget {
  final LocalStorage storage = LocalStorage('localstorage_app');

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: storage.ready,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<dynamic> cartItems = storage.getItem('cart') ?? [];

            if (cartItems.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              double totalPrice = cartItems.fold(
                0,
                (sum, item) => sum + (item['totalPrice'] as double),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        var item = cartItems[index];
                        return ListTile(
                          leading: Icon(Icons.shopping_cart, color: Colors.blue),
                          title: Text(
                            item['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Price: \$${item['price']}'),
                          trailing: Text('Quantity: ${item['quantity']}'),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total a pagar: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
