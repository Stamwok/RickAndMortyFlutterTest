
import '../characters_list/models/character.dart';
import '../characters_list/models/characters_response.dart';

abstract class CharactersService {
  Future<List<Character>> getCharactersList();
  Future<List<Character>> getMoreCharacters();
  Future<Character> getCharacterDetailInfo(int id);
}