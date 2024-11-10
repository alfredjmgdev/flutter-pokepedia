import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/pokemon_list.dart';
import '../widgets/loading_overlay.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Map<String, dynamic>> pokemonData = [];
  bool isLoading = false;
  int currentPage = 0;
  static const int pokemonsPerPage = 15;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchPokemonData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchPokemonData();
    }
  }

  Future<void> fetchPokemonData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final startIndex = currentPage * pokemonsPerPage + 1;
      final endIndex = startIndex + pokemonsPerPage;

      final futures = List.generate(
        pokemonsPerPage,
        (index) => http.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/${startIndex + index}'),
        ),
      );

      final responses = await Future.wait(futures);
      await Future.delayed(const Duration(seconds: 1));

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final abilities = (data['abilities'] as List)
              .map((ability) => ability['ability']['name'].toString())
              .map((name) => name[0].toUpperCase() + name.substring(1))
              .toList();

          final moves = (data['moves'] as List)
              .take(4)
              .map((move) => move['move']['name'].toString())
              .map((name) => name.replaceAll('-', ' '))
              .map((name) => name[0].toUpperCase() + name.substring(1))
              .toList();

          final types = (data['types'] as List)
              .map((type) => type['type']['name'].toString())
              .map((name) => name[0].toUpperCase() + name.substring(1))
              .toList();

          final stats = (data['stats'] as List)
              .map((stat) => {
                    'name': stat['stat']['name']
                        .toString()
                        .replaceAll('-', ' ')
                        .split(' ')
                        .map(
                            (word) => word[0].toUpperCase() + word.substring(1))
                        .join(' '),
                    'value': stat['base_stat'] as int,
                  })
              .toList();

          setState(() {
            pokemonData.add({
              'name': data['name'][0].toUpperCase() + data['name'].substring(1),
              'sprite': data['sprites']['front_default'],
              'showdown_sprite': data['sprites']['other']?['showdown']
                      ?['front_default'] ??
                  data['sprites']['versions']?['generation-v']?['black-white']
                      ?['animated']?['front_default'] ??
                  data['sprites']['front_default'],
              'abilities': abilities,
              'moves': moves,
              'types': types,
              'stats': stats,
            });
          });
        }
      }

      currentPage++;
    } catch (e) {
      print('Error fetching pokemon data: $e');
      if (pokemonData.isEmpty) {
        setState(() {
          pokemonData = [
            {
              'name': 'Error loading Pokemon',
              'sprite': '',
              'abilities': [],
              'moves': []
            }
          ];
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Pokemon List'),
      ),
      body: Stack(
        children: [
          PokemonList(
            pokemonData: pokemonData,
            scrollController: _scrollController,
          ),
          if (isLoading) const LoadingOverlay(),
        ],
      ),
    );
  }
}
