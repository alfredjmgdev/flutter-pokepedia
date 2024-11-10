import 'package:flutter/material.dart';
import 'pokemon_list_item.dart';

class PokemonList extends StatelessWidget {
  final List<Map<String, dynamic>> pokemonData;
  final ScrollController scrollController;

  const PokemonList({
    super.key,
    required this.pokemonData,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: pokemonData.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final pokemon = pokemonData[index];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: PokemonListItem(
            name: pokemon['name']!,
            spriteUrl: pokemon['sprite']!,
            showdownSpriteUrl: pokemon['showdown_sprite']!,
            abilities: List<String>.from(pokemon['abilities']),
            moves: List<String>.from(pokemon['moves']),
            types: List<String>.from(pokemon['types']),
            stats: List<Map<String, dynamic>>.from(pokemon['stats']),
          ),
        );
      },
    );
  }
}
