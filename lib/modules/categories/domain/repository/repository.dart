import 'package:examen_movil/infrastructure/app/repository/repository.dart';
import 'package:examen_movil/infrastructure/connection/connection.dart';
import 'package:examen_movil/modules/categories/domain/dto/categoriesResponse.dart';

class CategoriesRepository implements Repository<List<CategoriesResponse>, void> {
  @override
  Future<List<CategoriesResponse>> execute(void params) async {
    String url = "https://dummyjson.com/products/categories";
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    List<dynamic> data = response as List<dynamic>;

    return data.map((json) => CategoriesResponse.fromJson(json)).toList();
  }
}