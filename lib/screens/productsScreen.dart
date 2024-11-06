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
      appBar: AppBar(
        title:Center(child: 
         Text(
          "Products",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ))
      ),
      body: FutureBuilder<List<ProductResponse>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductResponse> products = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.25,
                ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        SizedBox(
                        height: 50.0,
                        child: Image.network(
                          products[index].thumbnail,
                          fit: BoxFit.fill,
                        ),
                        ),
                        Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            products[index].title,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailsscreen(
                                  productId: products[index].id,
                                ),
                              ),
                            );
                          },
                          child: 
                          const Text('Detalles',
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
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
