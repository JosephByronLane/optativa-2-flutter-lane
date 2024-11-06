class ProductDetailResponse {
  final String title;
  final List<String> images;
  final String description;
  final num price;
  final int stock;

  ProductDetailResponse({
    required this.title,
    required this.images,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      title: json['title'] as String,
      images: List<String>.from(json['images'] as List),
      description: json['description'] as String,
      price: json['price'] as num,
      stock: json['stock'] as int,
    );
  }
}
