import 'package:localstorage/localstorage.dart';
import '../../../infrastructure/app/useCase/use_case.dart';
import '../domain/dto/productDetailResponse.dart';
import '../domain/repository/productDetailRepository.dart';

class ProductDetailUseCase implements UseCase<ProductDetailResponse, int> {
  @override
  Future<ProductDetailResponse> execute(int productId) async {  
    final LocalStorage storage = LocalStorage('localstorage_app');

    String? accessToken = storage.getItem('token');
    if (accessToken == null) {
      throw Exception('No token');
    }

    final productDetails = await ProductDetailRepository().execute(productId);
    return productDetails;
  }
}
