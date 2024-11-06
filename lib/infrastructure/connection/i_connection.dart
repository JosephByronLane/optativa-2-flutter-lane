abstract class Iconnection {
  get<O>(String url, {Map<String, String>? headers}) async {}

  post<O, I>(String url, I data, {Map<String, String>? headers}) async {}

  put<O, I>(String url, I data, {Map<String, String>? headers}) async {}

  delete<O>(String url, {Map<String, String>? headers}) async {}
}
