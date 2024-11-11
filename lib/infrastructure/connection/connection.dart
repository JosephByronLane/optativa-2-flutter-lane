import 'dart:convert';
import 'package:examen_movil/infrastructure/connection/i_connection.dart';
import 'package:http/http.dart' as http;

class Connection implements Iconnection {
  @override
  Future<O> get<O>(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as O;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<O> post<O, I>(String url, I data,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as O;
      } else {
        throw Exception('Failed to authenticate: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  delete<O>(String url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  put<O, I>(String url, I data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
