
part of 'characters_bloc.dart';


abstract class CharactersListEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class CharactersFetched extends CharactersListEvent {}