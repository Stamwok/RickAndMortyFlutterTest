
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_n_morty_flutter_app/character_detail_info/bloc/character_info_bloc.dart';
import 'characters_list_test.dart';
import 'characters_list_test.mocks.dart';

Future<void> main() async {

  late MockCharacterServiceTest characterService;
  late CharacterInfoBloc characterInfoBloc;

  group('characterInfoBloc init test success', () {
    const model = character;
    setUpAll(() {
      characterService = MockCharacterServiceTest();
      when(characterService.getCharacterDetailInfo(1)).thenAnswer((_) async {
        return model;
      });
      characterInfoBloc = CharacterInfoBloc(charactersService: characterService);
    });
    blocTest<CharacterInfoBloc, CharacterInfoState>(
        'CharacterInfoFetched test',
        build: () => characterInfoBloc,
        act: (bloc) => bloc.add(CharacterInfoFetched(id: 1)),
        expect: () => [
              const CharacterInfoState(
                  status: CharacterInfoStatus.success, character: model)
            ]);
  });
  group('characterInfoBloc init test failure', () {
    setUpAll(() {
      characterService = MockCharacterServiceTest();
      when(characterService.getCharacterDetailInfo(1)).thenAnswer((_) async {
        throw Exception();
      });
      characterInfoBloc = CharacterInfoBloc(charactersService: characterService);
    });
    blocTest<CharacterInfoBloc, CharacterInfoState>(
        'CharacterInfoFetched test',
        build: () => characterInfoBloc,
        act: (bloc) => bloc.add(CharacterInfoFetched(id: 1)),
        expect: () => [
          const CharacterInfoState(
              status: CharacterInfoStatus.failure, character: null)
        ]);
  });
}
