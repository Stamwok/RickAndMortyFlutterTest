
import 'package:flutter/material.dart';
import 'package:my_app/Model/Character.dart';
import 'package:my_app/Widget/CharacterDetailInfoPage.dart';
import 'package:my_app/Widget/CharacterListItem.dart';
import 'Widget/CharactersListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CharactersListPage(title: 'Characters list'),
    );
  }
}
