
import 'package:rick_n_morty_flutter_app/characters_list/models/character.dart';
import 'package:rick_n_morty_flutter_app/characters_list/models/characters_response.dart';
import 'package:rick_n_morty_flutter_app/service/characters_service.dart';

import '../ApiClient/RickAndMortyApiClient.dart';

class CharactersServiceImpl extends CharactersService {

  final apiClient = RickAndMortyApiClient();
  late String? nextPage;
  late String? prevPage;

  @override
  Future<Character> getCharacterDetailInfo(int id) async {
      final jsonData = await apiClient.request(method: '/character/$id');
      return Character.fromJson(jsonData);
  }

  @override
  Future<List<Character>> getCharactersList() async {
    final jsonData = await apiClient.request();
    final charactersResponse = CharactersResponse.fromJson(jsonData);
    nextPage = charactersResponse.info.next;
    prevPage = charactersResponse.info.prev;
    return charactersResponse.results;
  }

  @override
  Future<List<Character>> getMoreCharacters() async {
    if (nextPage != null) {
      final jsonData = await apiClient.request(url: nextPage);
      final charactersResponse = CharactersResponse.fromJson(jsonData);
      nextPage = charactersResponse.info.next;
      prevPage = charactersResponse.info.prev;
      return charactersResponse.results;
    } else {
      return <Character>[];
    }
  }
}