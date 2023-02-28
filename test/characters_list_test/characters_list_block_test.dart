import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_n_morty_flutter_app/characters_list/bloc/characters_bloc.dart';
import 'package:rick_n_morty_flutter_app/models/character.dart';

import 'characters_list_test.mocks.dart';

Future<void> main() async {
  late MockCharacterServiceTest characterService;
  late CharactersListBloc charactersListBloc;

  final model = <Character>[];
  group('charactersListBloc init test success', () {
    setUpAll(() {
      characterService = MockCharacterServiceTest();
      when(characterService.getCharactersList()).thenAnswer((_) async {
        return model;
      });
      charactersListBloc = CharactersListBloc(charactersService: characterService);
    });
    blocTest<CharactersListBloc, CharactersListState>(
        'CharactersListFetched test',
        build: () => charactersListBloc,
        act: (bloc) => bloc.add(CharactersFetched()),
        expect: () => [CharactersListState(status: CharactersListStatus.success, characters: model, isLastPage: false)]
    );
  });
  
  group('charactersListBloc init test failure', () {
    setUpAll(() {
      characterService = MockCharacterServiceTest();
      when(characterService.getCharactersList()).thenAnswer((_) async {
        throw Exception();
      });
      charactersListBloc = CharactersListBloc(charactersService: characterService);
    });
    blocTest<CharactersListBloc, CharactersListState>(
        'CharactersListFetched test',
        build: () => charactersListBloc,
        act: (bloc) => bloc.add(CharactersFetched()),
        expect: () => [const CharactersListState(status: CharactersListStatus.failure, characters: [], isLastPage: false)]
    );
  });
}
