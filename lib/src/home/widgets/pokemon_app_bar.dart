import 'package:flutter/material.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PokemonAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: Row(
        children: [
          const Icon(Icons.catching_pokemon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
