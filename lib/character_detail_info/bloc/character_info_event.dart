
part of 'character_info_bloc.dart';

abstract class CharacterInfoEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class CharacterInfoFetched extends CharacterInfoEvent {
  CharacterInfoFetched({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}