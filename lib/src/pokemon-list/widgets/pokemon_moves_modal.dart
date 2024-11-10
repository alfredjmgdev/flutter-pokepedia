import 'package:flutter/material.dart';

class PokemonMovesModal extends StatelessWidget {
  final String pokemonName;
  final List<String> moves;

  const PokemonMovesModal({
    super.key,
    required this.pokemonName,
    required this.moves,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.red, width: 2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$pokemonName\'s Moves',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...moves.map((move) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '• $move',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
