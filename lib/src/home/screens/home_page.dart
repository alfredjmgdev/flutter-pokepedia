import 'package:flutter/material.dart';
import '../widgets/pokemon_app_bar.dart';
import '../widgets/start_button.dart';
import '../widgets/background_container.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PokemonAppBar(title: 'Pokepedia'),
      body: BackgroundContainer(
        child: Center(
          child: StartButton(),
        ),
      ),
    );
  }
}
