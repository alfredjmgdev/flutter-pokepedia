import 'package:flutter/material.dart';
import 'pokemon_modal.dart';
import 'pokemon_moves_modal.dart';
import 'pokemon_stats_modal.dart';

class PokemonListItem extends StatelessWidget {
  final String name;
  final String spriteUrl;
  final String showdownSpriteUrl;
  final List<String> abilities;
  final List<String> moves;
  final List<String> types;
  final List<Map<String, dynamic>> stats;

  const PokemonListItem({
    super.key,
    required this.name,
    required this.spriteUrl,
    required this.showdownSpriteUrl,
    required this.abilities,
    required this.moves,
    required this.types,
    required this.stats,
  });

  void _showMovesModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PokemonMovesModal(
          pokemonName: name,
          moves: moves,
        );
      },
    );
  }

  void _showStatsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PokemonStatsModal(
          pokemonName: name,
          stats: stats,
        );
      },
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.grey[400]!;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow[700]!;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.orange[800]!;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.indigo[200]!;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.grey[800]!;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PokemonModal(
                pokemonName: name,
                spriteUrl: spriteUrl,
                showdownSpriteUrl: showdownSpriteUrl,
                abilities: abilities,
                moves: moves,
                types: types,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                spriteUrl,
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: types
                          .map((type) => Chip(
                                label: Text(
                                  type,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: _getTypeColor(type),
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.sports_martial_arts),
                onPressed: () => _showMovesModal(context),
                tooltip: 'Show Moves',
              ),
              IconButton(
                icon: const Icon(Icons.bar_chart),
                onPressed: () => _showStatsModal(context),
                tooltip: 'Show Stats',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
