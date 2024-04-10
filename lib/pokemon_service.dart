import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon_model.dart';

class PokemonService {
  final String apiUrl = 'https://ex.traction.one/pokedex/pokemon';

 Future<List<Pokemon>> getPokemonList() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Pokemon> pokemonList = [];
    data.forEach((id, name) {
      pokemonList.add(Pokemon(id: id, name: name));
    });
    return pokemonList;
  } else {
    throw Exception('Failed to load pokemon list');
  }
}
}
