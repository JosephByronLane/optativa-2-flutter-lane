class CategoriesResponse {
  String slug;
  String name;
  String url;

  CategoriesResponse({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      slug: json['slug'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
