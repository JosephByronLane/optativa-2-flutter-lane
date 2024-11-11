import 'package:examen_movil/modules/products/domain/repository/productsRepository.dart';
import 'package:localstorage/localstorage.dart';
import '../../../infrastructure/app/useCase/use_case.dart';
import '../domain/dto/productsResponse.dart';

class ProductsUseCase implements UseCase<List<ProductResponse>, String> {
  @override
  Future<List<ProductResponse>> execute(String categoryUrl) async {
    final LocalStorage storage = LocalStorage('localstorage_app');

    String? accessToken = storage.getItem('token');
    if (accessToken == null) {
      throw Exception('No token.');
    }

    final products = await ProductsRepository().execute(categoryUrl);
    return products;
  }
}
