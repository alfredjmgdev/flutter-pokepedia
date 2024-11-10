import 'package:flutter/material.dart';
import 'menu_button.dart';

class MenuItemsList extends StatelessWidget {
  const MenuItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: FutureBuilder(
            future: precacheImage(
              const NetworkImage(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png'),
              context,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(), // Loader
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return const Image(
                  image: NetworkImage(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
                  ),
                  width: 200,
                  fit: BoxFit.contain,
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Unable to load sprite'),
                  ),
                );
              }
            },
          ),
        ),
        const MenuButton(
          text: 'Pokémon List',
          route: '/pokemon-list',
          icon: Icons.catching_pokemon,
        ),
        const SizedBox(height: 16),
        const MenuButton(
          text: 'Berries',
          route: '/berries',
          icon: Icons.eco,
        ),
        const SizedBox(height: 16),
        const MenuButton(
          text: 'Regions',
          route: '/regions',
          icon: Icons.map,
        ),
      ],
    );
  }
}
