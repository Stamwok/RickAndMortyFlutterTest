import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/Character.dart';
import 'CharacterDetailInfoPage.dart';
import 'CharacterListItem.dart';
import 'package:http/http.dart' as http;

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key, required this.title});

  final String title;

  @override
  State<CharactersListPage> createState() => _CharactersListPage();
}

class _CharactersListPage extends State<CharactersListPage> {

  final List<Character> _items = [];
  late String? _nextPage = 'https://rickandmortyapi.com/api/character';
  late String? _prevPage;
  bool _isLastPage = false;
  bool _loading = false;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _buildListView()
      ),
    );
  }

  Future<void> fetchData() async {
    late Uri url;
    if (_nextPage != null) {
      url = Uri.parse(_nextPage!);
    } else {
      _isLastPage = true;
    }
    _loading = true;
    if (!_isLastPage) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List results = json.decode(response.body)['results'];
        setState(() {
          _items.addAll(
              results.map((data) => Character.fromJson(data)).toList());
          _nextPage = json.decode(response.body)['info']['next'];
          _prevPage = json.decode(response.body)['info']['prev'];
          _loading = false;
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    }
  }

  Widget _buildListView() {
    if (_loading) {
      return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ));
    }
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        if (_items.length - 3 < index && !_loading) {
          fetchData();
        }
        return _getItem(_items, index);
      },
    );
  }

  Widget _getItem(List<Character> snapshot, int index) {
    return GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  CharacterDetailInfoPage(title: 'Character Info',
                      characterId: snapshot[index].id))
          );
        },
        child: Card(
            child: CharacterListItem(
                name: snapshot[index].name,
                gender: snapshot[index].gender,
                species: snapshot[index].species,
                image: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    NetworkImage(snapshot[index].image)))));
  }
}