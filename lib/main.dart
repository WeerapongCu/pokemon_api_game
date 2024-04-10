import 'package:flutter/material.dart';
import 'PokemonHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Who\'s Correct Pokémon?',
      theme: ThemeData(
        primaryColor: Colors.red[400], // Pokédex theme color
        scaffoldBackgroundColor: Colors.grey[200], // Pokédex background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[400], // Pokédex app bar color
        ),
      ),
      home: CorrectPokemonPage(),
    );
  }
}
