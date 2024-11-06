import 'package:examen_movil/modules/products/domain/dto/productsResponse.dart';
import 'package:examen_movil/modules/products/domain/repository/productsRepository.dart';
import 'package:examen_movil/screens/detailsScreen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryUrl;

  const ProductsScreen({Key? key, required this.categoryUrl}) : super(key: key);

@override
  Widget build(BuildContext context) {
    Future<List<ProductResponse>> futureProducts =
        ProductsRepository().execute(categoryUrl);

    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.blue,
          flexibleSpace: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      body: FutureBuilder<List<ProductResponse>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductResponse> products = snapshot.data!;
            double itemWidth = (MediaQuery.of(context).size.width - 24) / 2;

            return SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0, 
                children: products.map((product) {
                  return Container(
                    width: itemWidth,
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, 
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 150, 
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                product.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to the product details screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detailsscreen(
                                      productId: product.id,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Details',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
