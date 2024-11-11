import 'package:examen_movil/infrastructure/app/useCase/use_case.dart';
import 'package:localstorage/localstorage.dart';
import 'package:examen_movil/modules/categories/domain/dto/categoriesResponse.dart';
import 'package:examen_movil/modules/categories/domain/repository/repository.dart';

class CategoriesUseCase implements UseCase<List<CategoriesResponse>, void> {
  @override
  Future<List<CategoriesResponse>> execute(void params) async {
    final LocalStorage storage = LocalStorage('localstorage_app');
    String? token = storage.getItem('token');
    print(token);
    if (token == null) {
      throw Exception('No token.');
    }

    return await CategoriesRepository().execute(params);
  }
}
