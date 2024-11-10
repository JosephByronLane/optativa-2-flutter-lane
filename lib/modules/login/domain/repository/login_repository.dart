import '../../../../infrastructure/app/repository/repository.dart';
import '../../../../infrastructure/connection/connection.dart';
import '../dto/user_credentials.dart';
import '../dto/user_login_response.dart';

class LoginRepository
    implements Repository<UserLoginResponse, UserCredentials> {
  @override
  Future<UserLoginResponse> execute(UserCredentials params) async {
    final data = {
      "username": params.user,
      "password": params.password,
      "expiresInMins": 30,
    };
    String url = "https://dummyjson.com/auth/login";
    Connection connection = Connection();
    final response = await connection.post(url, data, headers: {
      'Content-Type': 'application/json',
    });

    return UserLoginResponse.fromJson(response);
  }
}
