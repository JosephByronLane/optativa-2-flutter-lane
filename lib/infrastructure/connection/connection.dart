import 'dart:convert';
import 'package:examen_movil/infrastructure/connection/i_connection.dart';
import 'package:http/http.dart' as http;

class Connection implements Iconnection {
  @override
  Future<O> get<O>(String url, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    return jsonDecode(response.body) as O;
  }

  @override
  Future<O> post<O, I>(String url, I data,
      {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
      return jsonDecode(response.body) as O;
    
  }

  @override
  delete<O>(String url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  put<O,I>(String url,I data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
