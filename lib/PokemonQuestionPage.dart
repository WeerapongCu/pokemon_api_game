import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PokemonAnswerPage.dart';
import 'pokemon.dart';

class PokemonSelectionPage extends StatefulWidget {
  @override
  _PokemonSelectionPageState createState() => _PokemonSelectionPageState();
}

class _PokemonSelectionPageState extends State<PokemonSelectionPage> {
  late Future<List<Pokemon>> futurePokemons;
  late String question;
  bool isCorrectSelected = false;

  @override
  void initState() {
    super.initState();
    futurePokemons = fetchRandomPokemons();
    generateRandomQuestion();
  }

  Future<List<Pokemon>> fetchRandomPokemons() async {
    final Random random = Random();
    final List<Future<Pokemon>> pokemonFutures = [];
    for (int i = 0; i < 2; i++) {
      final int randomPokemonId = random.nextInt(151) + 1;
      pokemonFutures.add(fetchPokemon(randomPokemonId));
    }
    return Future.wait(pokemonFutures);
  }

  Future<Pokemon> fetchPokemon(int id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Pokemon(
        name: jsonData['name'],
        weight: jsonData['weight'],
        height: jsonData['height'],
        spriteUrl: jsonData['sprites']['front_default'],
      );
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  void generateRandomQuestion() {
    final Random random = Random();
    final List<String> attributes = ['height', 'weight'];
    final List<String> operators = ['greater than', 'less than'];
    final String selectedAttribute = attributes[random.nextInt(2)];
    final String selectedOperator = operators[random.nextInt(2)];
    setState(() {
      question = 'Whose $selectedAttribute is $selectedOperator?';
    });
  }

  void navigateToComparisonPage(Pokemon pokemon1, Pokemon pokemon2) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PokemonComparisonPage(
        pokemon1: pokemon1,
        pokemon2: pokemon2,
        question: question,
        isCorrect: isCorrectSelected,
      ),
    ),
  );

  if (result == true) {
    setState(() {
      futurePokemons = fetchRandomPokemons();
      generateRandomQuestion();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Pokémon for Comparison'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: futurePokemons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final pokemons = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    question,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              bool isCorrect;
                              if (question.contains('greater')) {
                                isCorrect = pokemons[0].height > pokemons[1].height;
                              } else {
                                isCorrect = pokemons[0].height < pokemons[1].height;
                              }
                              setState(() {
                                isCorrectSelected = isCorrect;
                              });
                              navigateToComparisonPage(pokemons[0], pokemons[1]);
                            },
                            child: Image.network(
                              pokemons[0].spriteUrl,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(pokemons[0].name.toUpperCase()),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              bool isCorrect;
                              if (question.contains('greater')) {
                                isCorrect = pokemons[1].height > pokemons[0].height;
                              } else {
                                isCorrect = pokemons[1].height < pokemons[0].height;
                              }
                              setState(() {
                                isCorrectSelected = isCorrect;
                              });
                              navigateToComparisonPage(pokemons[1], pokemons[0]);
                            },
                            child: Image.network(
                              pokemons[1].spriteUrl,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(pokemons[1].name.toUpperCase()),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}