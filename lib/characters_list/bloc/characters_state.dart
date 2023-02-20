part of 'characters_bloc.dart';

enum CharactersListStatus { initial, success, failure }

class CharactersListState extends Equatable {
  const CharactersListState({
    this.status = CharactersListStatus.initial,
    this.characters = const <Character>[],
    this.isLastPage = false,
  });

  final CharactersListStatus status;
  final List<Character> characters;
  final bool isLastPage;

  CharactersListState copyWith({
    CharactersListStatus? status,
    List<Character>? characters,
    bool? isLastPage,
  }) {
    return CharactersListState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  String toString() {
    return '''CharactersState { status: $status, characters: $characters, isLastPage: $isLastPage }''';
  }

  @override
  List<Object?> get props => [status, characters, isLastPage];
}
