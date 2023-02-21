// ignore_for_file: avoid_print

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rick_n_morty_flutter_app/models/character.dart';
import 'package:rick_n_morty_flutter_app/service/characters_service.dart';

part 'characters_event.dart';
part 'characters_state.dart';



const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersListBloc extends Bloc<CharactersListEvent, CharactersListState> {
  CharactersListBloc({required this.charactersService}): super(const CharactersListState()) {
    on<CharactersFetched>(
        _onCharactersFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final CharactersService charactersService;

  Future<void> _onCharactersFetched(CharactersFetched event, Emitter<CharactersListState> emit) async {
    if (state.isLastPage) return;
    try {
      if (state.status == CharactersListStatus.initial) {
        final characters = await charactersService.getCharactersList();
        return emit(
            state.copyWith(
                status: CharactersListStatus.success,
                characters: characters,
                isLastPage: false
            )
        );
      }
      final newCharacters = await charactersService.getMoreCharacters();
      if (newCharacters.isEmpty) {
        emit(state.copyWith(isLastPage: true));
      } else {
        emit(state.copyWith(
            status: CharactersListStatus.success,
            characters: List.of(state.characters)..addAll(newCharacters),
            isLastPage: false
        ));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: CharactersListStatus.failure));
    }
  }


}