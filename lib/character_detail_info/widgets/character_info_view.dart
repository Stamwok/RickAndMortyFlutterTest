import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_flutter_app/character_detail_info/bloc/character_info_bloc.dart';

class CharacterInfoView extends StatefulWidget {
  const CharacterInfoView({super.key});

  @override
  State<CharacterInfoView> createState() => _CharacterInfoViewState();
}

class _CharacterInfoViewState extends State<CharacterInfoView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterInfoBloc, CharacterInfoState>(
      builder: (context, state) {
        switch (state.status) {
          case CharacterInfoStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case CharacterInfoStatus.failure:
            return const Center(child: Text('failed to fetch character'));
          case CharacterInfoStatus.success:
            final character = state.character;
            if (character != null) {
              return ListView(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Image.network(character.image),
                      ),
                      Text(character.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text(character.location,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                      Text(character.species,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                      Text(character.status,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                    ],
                  )
                ],
              );
            } else {
              return const Center(child: Text('failed to fetch character'));
            }
        }
      },
    );
  }
}
