import 'package:flutter/material.dart';
import 'PokemonQuestionPage.dart';

class CorrectPokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who\'s Correct Pokémon?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Who\'s Correct Pokémon?",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonSelectionPage(),
                  ),
                );
              },
              child: Text('PLAY'),
            ),
          ],
        ),
      ),
    );
  }
}
