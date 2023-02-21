
import 'dart:convert';
import 'package:http/http.dart';

class RickAndMortyApiClient {

  final Client httpClient = Client();
  final String url = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> request({ String? url, String? method, Map<String, String>? parameters }) async {
    final uri = Uri.parse((url ?? this.url) + (method ?? ''));
    if (parameters != null) uri.replace(queryParameters: parameters);
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}