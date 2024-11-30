import 'package:examen_movil/modules/details/domain/dto/reviewResponse.dart';

class ProductDetailResponse {
  final String title;
  final List<String> images;
  final String description;
  final num price;
  final int stock;
  final List<Review> reviews;

  ProductDetailResponse({
    required this.title,
    required this.images,
    required this.description,
    required this.price,
    required this.stock,
    required this.reviews,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      title: json['title'] as String,
      images: List<String>.from(json['images'] as List),
      description: json['description'] as String,
      price: json['price'] as num,
      stock: json['stock'] as int,
      reviews: (json['reviews'] as List<dynamic>)
          .map((reviewJson) => Review.fromJson(reviewJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
