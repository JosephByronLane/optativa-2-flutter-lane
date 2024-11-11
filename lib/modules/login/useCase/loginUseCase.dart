import '../../../infrastructure/app/useCase/use_case.dart';
import '../domain/dto/user_credentials.dart';
import '../domain/dto/user_login_response.dart';
import '../domain/repository/login_repository.dart';

class LoginUseCase implements UseCase<dynamic, UserCredentials> {
  @override
  Future<dynamic> execute(UserCredentials params) async {
    try {
      final UserCredentials credentials = UserCredentials(
        user: params.user,
        password: params.password,
      );

      final UserLoginResponse response = await LoginRepository().execute(credentials);
      return response;
    } catch (e) {
      return Future.error(e);  
    }
  }
}