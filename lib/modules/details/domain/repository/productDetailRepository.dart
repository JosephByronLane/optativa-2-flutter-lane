import 'package:examen_movil/infrastructure/app/repository/repository.dart';
import 'package:examen_movil/infrastructure/connection/connection.dart';
import 'package:examen_movil/modules/details/domain/dto/productDetailResponse.dart';

class ProductDetailRepository implements Repository<ProductDetailResponse, int> {
  @override
  Future<ProductDetailResponse> execute(int productId) async {
    String url = 'https://dummyjson.com/products/$productId';
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return ProductDetailResponse.fromJson(response);
  }
}
