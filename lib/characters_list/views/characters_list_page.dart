import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_flutter_app/characters_list/bloc/characters_bloc.dart';

import '../../service/characters_service_impl.dart';
import '../widgets/characters_list.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters list')),
      body: BlocProvider(
        create: (_) => CharactersListBloc(charactersService: CharactersServiceImpl())..add(CharactersFetched()),
        child: const CharactersList(),
      ),
    );
  }
}