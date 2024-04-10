import 'package:flutter/material.dart';
import 'pokemon.dart';


class PokemonComparisonPage extends StatelessWidget {
  final Pokemon pokemon1;
  final Pokemon pokemon2;
  final String question;
  final bool isCorrect;

  PokemonComparisonPage({required this.pokemon1, required this.pokemon2, required this.question, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer!'),
        centerTitle: true,
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Center(
        child: Column(
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
                    Image.network(
                      pokemon1.spriteUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    Text(pokemon1.name.toUpperCase()),
                    Text('Height: ${pokemon1.height}'),
                    Text('Weight: ${pokemon1.weight}'),
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      pokemon2.spriteUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    Text(pokemon2.name.toUpperCase()),
                    Text('Height: ${pokemon2.height}'),
                    Text('Weight: ${pokemon2.weight}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              isCorrect ? "It's Correct!" : "Wrong!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to PokemonSelectionPage and fetch new random pokemons
                Navigator.pop(context, true); // Pass true to indicate playing again
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}