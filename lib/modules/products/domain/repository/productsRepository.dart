import 'package:examen_movil/infrastructure/app/repository/repository.dart';
import 'package:examen_movil/infrastructure/connection/connection.dart';
import 'package:examen_movil/modules/products/domain/dto/productsResponse.dart';

class ProductsRepository implements Repository<List<ProductResponse>, String> {
  @override
  Future<List<ProductResponse>> execute(String categoryUrl) async {
    String url = categoryUrl;
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    List<dynamic> data = response['products'] as List<dynamic>;
    List<ProductResponse> products = data.map((json) => ProductResponse.fromJson(json)).toList();
    return products;
  }
}