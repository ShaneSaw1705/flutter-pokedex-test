// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iospokemonflutter/models/pokemon.dart' as pokemontype;
import 'package:http/http.dart' as http;

class TestPokemon extends StatefulWidget {
  final Map<String, dynamic> pokemon;

  const TestPokemon({super.key, required this.pokemon});

  @override
  State<TestPokemon> createState() => _TestPokemonState();
}

class _TestPokemonState extends State<TestPokemon> {
  Future<pokemontype.Pokemon> fetchPokemon() async {
    final response = await http.get(Uri.parse(widget.pokemon['url']));
    if (response.statusCode == 200) {
      return pokemontype.pokemonFromJson(response.body);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.pokemon['name']),
        previousPageTitle: 'Back',
        automaticallyImplyLeading: true,
      ),
      child: SafeArea(
        child: FutureBuilder<pokemontype.Pokemon>(
          future: fetchPokemon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final pokemon = snapshot.data!;
              return Column(
                children: [
                  Image.network(
                    pokemon.sprites.frontDefault,
                  ),
                  ElevatedButton(
                      onPressed: () => {}, child: const Text('testing')),
                  Center(
                    child: Text('Details for ${pokemon.name}'),
                  ),
                  Text('${pokemon.name} has ${pokemon.stats.length} stats'),
                  Text('${pokemon.name} has ${pokemon.types.length} types'),
                  Text(
                    '${pokemon.name} has ${pokemon.abilities.length} abilities',
                  ),
                  Expanded(
                    child: ListView(
                      children: pokemon.abilities
                          .map((ability) => Text(ability.ability.name))
                          .toList(),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
