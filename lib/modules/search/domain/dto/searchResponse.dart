import 'dart:ffi';

class searchResponse {
  final int id;
  final String title;
  final String description;
  final String thumbnail;

  searchResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory searchResponse.fromJson(Map<String, dynamic> json) {
    return searchResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
