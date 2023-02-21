
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_flutter_app/character_detail_info/bloc/character_info_bloc.dart';
import 'package:rick_n_morty_flutter_app/service/characters_service_impl.dart';
import '../widgets/character_info_view.dart';

class CharacterDetailInfoPage extends StatelessWidget {
  const CharacterDetailInfoPage({super.key, required this.characterId});

  final int characterId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character info')
      ),
      body: BlocProvider(
        create: (_) => CharacterInfoBloc(charactersService: CharactersServiceImpl())..add(CharacterInfoFetched(id: characterId)),
        child: const CharacterInfoView()
      ),
    );
  }


}