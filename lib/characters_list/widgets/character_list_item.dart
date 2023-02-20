
import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    super.key,
    required this.image,
    required this.gender,
    required this.name,
    required this.species,
  });

  final Widget image;
  final String name;
  final String gender;
  final String species;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: image,
          ),
          Expanded(
            flex: 3,
            child: _CharacterDescription(
              name: name,
              gender: gender,
              species: species,
            ),
          )
        ],
      ),
    );
  }
}

class _CharacterDescription extends StatelessWidget {
  const _CharacterDescription({
    required this.name,
    required this.species,
    required this.gender,
  });

  final String name;
  final String gender;
  final String species;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name,
              style:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Text(
            gender,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          Text(species, style: const TextStyle(fontSize: 10, color: Colors.grey))
        ],
      ),
    );
  }
}
