import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_flutter_app/characters_list/bloc/characters_bloc.dart';
import 'package:rick_n_morty_flutter_app/characters_list/widgets/bottom_loader.dart';

import '../../character_detail_info/views/character_detail_info_page.dart';
import 'character_list_item.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersListBloc, CharactersListState>(
        builder: (context, state) {
      switch (state.status) {
        case CharactersListStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case CharactersListStatus.success:
          if (state.characters.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.characters.length
                  ? const BottomLoader()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CharacterDetailInfoPage(characterId: state.characters[index].id)));
                      },
                      child: Card(
                          child: CharacterListItem(
                              name: state.characters[index].name,
                              gender: state.characters[index].gender,
                              species: state.characters[index].species,
                              image: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      state.characters[index].image)))));
            },
            itemCount: state.isLastPage
                ? state.characters.length
                : state.characters.length + 1,
            controller: _scrollController,
          );
        case CharactersListStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CharactersListBloc>().add(CharactersFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
