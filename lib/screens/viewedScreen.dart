import 'package:examen_movil/modules/details/domain/dto/productDetailResponse.dart';
import 'package:examen_movil/modules/details/useCase/use_case.dart';
import 'package:examen_movil/screens/detailsScreen.dart';
import 'package:examen_movil/widgets/navigationWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ViewedScreen extends StatefulWidget {
  const ViewedScreen({Key? key}) : super(key: key);

  @override
  _ViewedScreenState createState() => _ViewedScreenState();
}

class _ViewedScreenState extends State<ViewedScreen> {
  List<int> _viewedIds = [];
  List<int> _viewCounts = [];
  List<ProductDetailResponse> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadViewedItems();
  }

  Future<void> _loadViewedItems() async {
    final LocalStorage storage = LocalStorage('viewed_items');
    await storage.ready;
    final ids = storage.getItem('ids') ?? [];
    final timesViewed = storage.getItem('ids_timesViewed') ?? [];

    if (ids.isNotEmpty && timesViewed.isNotEmpty) {
      final parsedIds = (ids as List<dynamic>).map((id) => int.parse(id.toString())).toList();
      final parsedTimesViewed = (timesViewed as List<dynamic>).map((count) => int.parse(count.toString())).toList();

      setState(() {
        _viewedIds = parsedIds;
        _viewCounts = parsedTimesViewed;
      });

      await _fetchProducts();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchProducts() async {
    List<ProductDetailResponse> products = [];

    for (int id in _viewedIds) {
      print(id);
      Future<ProductDetailResponse> response = ProductDetailUseCase().execute(id);

    products.add(await response);    }

    setState(() {
      _products = products;
      _isLoading = false;
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: NavigationWidget(),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _products.isEmpty
            ? const Center(child: Text('No items viewed yet'))
            : ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final timesViewed = _viewCounts[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(product.title),
                            subtitle: Text('Price: \$${product.price}'),
                            trailing: Text('Viewed: $timesViewed times'),
                            onTap: () {
                              final LocalStorage storage = LocalStorage('viewed_items');

                              final ids = storage.getItem('ids') ?? [];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailsscreen(
                                    productId: ids[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Detailsscreen.addToCart(product, 1, context),
                              child: const Text('Agregar a carrito'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
  );
}


}
