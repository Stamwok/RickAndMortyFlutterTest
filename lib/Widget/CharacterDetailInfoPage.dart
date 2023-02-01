

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Character.dart';

class CharacterDetailInfoPage extends StatefulWidget {
  const CharacterDetailInfoPage({super.key, required this.title, required this.characterId});

  final String title;
  final int characterId;

  @override
  State<CharacterDetailInfoPage> createState() => _CharacterDetailInfoPage();
}

class _CharacterDetailInfoPage extends State<CharacterDetailInfoPage> {

  Future<Character> getCharacterInfo(int id) async {
    var url = Uri.parse('https://rickandmortyapi.com/api/character/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Character jsonResponse = Character.fromJson(json.decode(response.body));
      return jsonResponse;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<Character> character = ApiManager().getCharacterInfo(widget.characterId);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          FutureBuilder<Character>(
            future: getCharacterInfo(widget.characterId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Center(
                      child: Image.network(snapshot.data!.image),
                    ),
                    Text(snapshot.data!.name, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(snapshot.data!.location, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    Text(snapshot.data!.species, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    Text(snapshot.data!.status, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                );
              } else if (snapshot.hasError){
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}