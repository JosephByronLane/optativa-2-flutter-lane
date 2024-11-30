import 'package:examen_movil/modules/products/domain/dto/productsResponse.dart';
import 'package:examen_movil/modules/products/domain/repository/productsRepository.dart';
import 'package:examen_movil/modules/products/useCase/useCase.dart';
import 'package:examen_movil/screens/cartScreen.dart';
import 'package:examen_movil/screens/detailsScreen.dart';
import 'package:examen_movil/widgets/navigationWidget.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryUrl;

  const ProductsScreen({Key? key, required this.categoryUrl}) : super(key: key);

@override
  Widget build(BuildContext context) {
    Future<List<ProductResponse>> futureProducts = ProductsUseCase().execute(categoryUrl);
    return Scaffold(
      appBar: NavigationWidget(),
      body: FutureBuilder<List<ProductResponse>>(
        future: futureProducts,
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
            List<ProductResponse> products = snapshot.data!;
            double itemWidth = (MediaQuery.of(context).size.width - 24) / 2;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
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
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                product.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                // final LocalStorage storage = LocalStorage('viewed_items');
                                // if(storage.getItem("ids") == null) {
                                //   storage.setItem("ids", [product.id]);
                                //   storage.setItem("ids_timesViewed", [1]);
                                // }
                                // else {
                                //   List<int> ids = storage.getItem("ids");
                                //   List<int> ids_timesViewed = storage.getItem("ids_timesViewed");
                                //   if(ids.contains(product.id)) {
                                //     int index = ids.indexOf(product.id);
                                //     ids_timesViewed[index] = ids_timesViewed[index] + 1;
                                //   }
                                //   else {
                                //     ids.add(product.id);
                                //     ids_timesViewed.add(1);
                                //   }
                                //   storage.setItem("ids", ids);
                                //   storage.setItem("ids_timesViewed", ids_timesViewed);
                                // }


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
            return const Center(
              child: Text('No products available.'),
            );
          }
        },
      ),
    );
  }
}
