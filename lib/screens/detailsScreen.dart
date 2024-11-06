import 'package:examen_movil/modules/details/domain/dto/productDetailResponse.dart';
import 'package:examen_movil/modules/details/domain/repository/productDetailRepository.dart';
import 'package:flutter/material.dart';

class Detailsscreen extends StatelessWidget {
  final int productId;

 const Detailsscreen({super.key, required this.productId});

@override
  Widget build(BuildContext context) {
    Future<ProductDetailResponse> futureProductDetail =
        ProductDetailRepository().execute(productId);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Detalle de product", style: TextStyle(color: Colors.white),),
          
        ),
      ),
      body: FutureBuilder<ProductDetailResponse>(
        future: futureProductDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProductDetailResponse product = snapshot.data!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the image without cutting it off
                  if (product.images.isNotEmpty)
                    Image.network(
                      product.images[0],
                      width: double.infinity,
                      fit: BoxFit.contain, // Use BoxFit.contain to avoid cropping
                    ),
                  SizedBox(height: 16.0),
                  // Center the title
                  Center(
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Add a Divider
                  Divider(),
                  SizedBox(height: 8.0),
                  // Display the description
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  // Display price and stock in a row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: \$${product.price}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Divider(),
                  Divider(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.add),
                      label: Text('Agregar'),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}