import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:iospokemonflutter/pages/testpokemon.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> _pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=30&offset='));

    if (response.statusCode == 200) {
      setState(() {
        _pokemonList = jsonDecode(response.body)["results"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Pokedex'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CupertinoButton(
                  child: Text(_pokemonList[index]['name']),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            TestPokemon(pokemon: _pokemonList[index]),
                      ),
                    );
                  },
                );
              },
              childCount: _pokemonList.length,
            ),
          ),
        ],
      ),
    );
  }
}
