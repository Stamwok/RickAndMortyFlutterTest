// import 'dart:ffi';
//
// import 'package:my_app/Model/Character.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
//
// class ApiManager {
//   List<Character> _items = [];
//   late String? _nextPage = 'https://rickandmortyapi.com/api/character';
//   late String? _prevPage;
//   bool _isLastPage = false;
//
//   Future<List<Character>> fetchData(bool isLoadNextPage) async {
//     late Uri url;
//     if (_nextPage != null) {
//       url = Uri.parse(_nextPage!);
//     } else {
//       _isLastPage = true;
//     }
//     if (!_isLastPage && isLoadNextPage) {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         List results = json.decode(response.body)['results'];
//         _items.addAll(results.map((data) => Character.fromJson(data)).toList());
//         _nextPage = json.decode(response.body)['info']['nextPage'];
//         _prevPage = json.decode(response.body)['info']['prevPage'];
//       } else {
//         throw Exception('Unexpected error occured!');
//       }
//     }
//     return _items;
//   }
//
//   Future<Character> getCharacterInfo(int id) async {
//     var url = Uri.parse('https://rickandmortyapi.com/api/character/$id');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       Character jsonResponse = Character.fromJson(json.decode(response.body));
//       return jsonResponse;
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }
// }
