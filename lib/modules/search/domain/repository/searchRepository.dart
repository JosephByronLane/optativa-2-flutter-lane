import 'package:examen_movil/infrastructure/app/repository/repository.dart';
import 'package:examen_movil/infrastructure/connection/connection.dart';
import 'package:examen_movil/modules/products/domain/dto/productsResponse.dart';
import 'package:examen_movil/modules/search/domain/dto/searchResponse.dart';

class SearchRepository implements Repository<List<searchResponse>, String> {
  @override
  Future<List<searchResponse>> execute(String searchTerm) async {
    final url = 'https://dummyjson.com/products/search?q=$searchTerm';
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    List<dynamic> data = response['products'] as List<dynamic>;
    List<searchResponse> products = data.map((json) => searchResponse.fromJson(json)).toList();
    return products;
  }
}