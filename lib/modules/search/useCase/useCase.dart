import 'package:examen_movil/modules/products/domain/repository/productsRepository.dart';
import 'package:examen_movil/modules/search/domain/repository/searchRepository.dart';
import 'package:localstorage/localstorage.dart';
import '../../../infrastructure/app/useCase/use_case.dart';
import '../domain/dto/searchResponse.dart';

class SearchUseCase implements UseCase<List<searchResponse>, String> {
  @override
  Future<List<searchResponse>> execute(String categoryUrl) async {
    final LocalStorage storage = LocalStorage('localstorage_app');

    String? accessToken = storage.getItem('token');
    if (accessToken == null) {
      throw Exception('No token.');
    }

    final products = await SearchRepository().execute(categoryUrl);
    return products;
  }
}
