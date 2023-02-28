
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_n_morty_flutter_app/models/character.dart';
import 'package:rick_n_morty_flutter_app/service/characters_service.dart';

import 'characters_list_test.mocks.dart';

const character = Character(
    status: 'status',
    location: 'location',
    episodes: 0,
    id: 1,
    name: 'name',
    gender: 'gender',
    species: 'species',
    image: 'image');

class CharacterServiceTest extends Mock implements CharactersService {}

@GenerateMocks([CharacterServiceTest])
Future<void> main() async {
  late MockCharacterServiceTest charactersService;
  setUpAll(() {
    charactersService = MockCharacterServiceTest();
  });
  group('test charactersList', () {
    test('test getCharactersList', () async {
      final model = [character];
      when(charactersService.getCharactersList()).thenAnswer((_) async {
        return model;
      });
      final res = await charactersService.getCharactersList();
      expect(res, isA<List<Character>>());
      expect(res, model);
    });
    test('test getCharactersList throws Exception', () {
      when(charactersService.getCharactersList()).thenAnswer((_) async {
        throw Exception();
      });
      final res = charactersService.getCharactersList();
      expect(res, throwsException);
    });
  });
  group ('test charactersDetailInfo', () {
    test('test getCharacterInfo', () async {
      const model = character;
      when(charactersService.getCharacterDetailInfo(1)).thenAnswer((_) async {
        return model;
      });
        final res = await charactersService.getCharacterDetailInfo(1);
        expect(res, model);
    });
    test('test getCharacterInfo throws Exception', () {
      when(charactersService.getCharacterDetailInfo(1)).thenAnswer((_) async {
        throw Exception();
      });
      final res = charactersService.getCharacterDetailInfo(1);
      expect(res, throwsException);
    });
  });
}
