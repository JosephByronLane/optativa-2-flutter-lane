import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final LocalStorage storage = LocalStorage('localstorage_app');
  List<dynamic> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    await storage.ready;
    setState(() {
      cartItems = storage.getItem('cart') ?? [];
      totalPrice = _calculateTotalPrice();
    });
  }

  double _calculateTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item['totalPrice'] as double));
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      totalPrice = _calculateTotalPrice();
      storage.setItem('cart', cartItems); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Carrito vacio.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartItems[index];
                      return ListTile(
                        leading: Image.network(
                          item['image'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          item['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Price: \$${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Quantity: ${item['quantity']}'),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removeItem(index),
                            ),
                          ],
                        ),
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
            ),
    );
  }
}
