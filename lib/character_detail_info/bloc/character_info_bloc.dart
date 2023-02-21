// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_n_morty_flutter_app/service/characters_service.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../models/character.dart';

part 'character_info_event.dart';
part 'character_info_state.dart';

const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterInfoBloc extends Bloc<CharacterInfoEvent, CharacterInfoState> {
  CharacterInfoBloc({ required this.charactersService }): super(const CharacterInfoState()) {
    on<CharacterInfoFetched>(
        _onCharacterInfoFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }

  final CharactersService charactersService;

  Future<void> _onCharacterInfoFetched(CharacterInfoFetched event, Emitter<CharacterInfoState> emit) async {
    try {
      final character = await charactersService.getCharacterDetailInfo(event.id);
      return emit(
        state.copyWith(
          status: CharacterInfoStatus.success,
          character: character
        )
      );
    } catch(e) {
      print(e);
          emit(state.copyWith(status: CharacterInfoStatus.failure));
    }
  }
}