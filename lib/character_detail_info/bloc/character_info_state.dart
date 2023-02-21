part of 'character_info_bloc.dart';

enum CharacterInfoStatus { initial, success, failure }

class CharacterInfoState extends Equatable {
  const CharacterInfoState(
      {this.status = CharacterInfoStatus.initial, this.character});

  final CharacterInfoStatus status;
  final Character? character;

  CharacterInfoState copyWith({
    CharacterInfoStatus? status,
    Character? character,
  }) {
    return CharacterInfoState(
        status: status ?? this.status, character: character ?? this.character);
  }

  @override
  String toString() {
    return '''CharacterDetailInfoState { status: $status, character: $character }''';
  }

  @override
  List<Object?> get props => [status, character];
}
