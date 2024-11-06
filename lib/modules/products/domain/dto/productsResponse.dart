import 'dart:ffi';

class ProductResponse {
  final int id;
  final String title;
  final String thumbnail;

  ProductResponse({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
