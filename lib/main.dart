
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'characters_list/views/characters_list_page.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const App());
}

class App extends MaterialApp {
  const App({super.key}) : super(home: const CharactersListPage());
}