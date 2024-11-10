import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/berry_list.dart';
import '../../pokemon-list/widgets/loading_overlay.dart';

class BerriesPage extends StatefulWidget {
  const BerriesPage({super.key});

  @override
  State<BerriesPage> createState() => _BerriesPageState();
}

class _BerriesPageState extends State<BerriesPage> {
  List<Map<String, dynamic>> berryData = [];
  bool isLoading = false;
  int currentPage = 0;
  static const int berriesPerPage = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchBerryData();
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
      fetchBerryData();
    }
  }

  Future<String?> fetchBerrySprite(String itemUrl) async {
    try {
      final response = await http.get(Uri.parse(itemUrl));
      if (response.statusCode == 200) {
        final itemData = jsonDecode(response.body);
        return itemData['sprites']['default'];
      }
    } catch (e) {
      print('Error fetching berry sprite: $e');
    }
    return null;
  }

  Future<void> fetchBerryData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final startIndex = currentPage * berriesPerPage + 1;
      final endIndex = startIndex + berriesPerPage;

      final futures = List.generate(
        berriesPerPage,
        (index) => http.get(
          Uri.parse('https://pokeapi.co/api/v2/berry/${startIndex + index}'),
        ),
      );

      final responses = await Future.wait(futures);
      await Future.delayed(const Duration(seconds: 1));

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final itemUrl = data['item']['url'];
          final sprite = await fetchBerrySprite(itemUrl);

          setState(() {
            berryData.add({
              'name': data['name'][0].toUpperCase() + data['name'].substring(1),
              'sprite': sprite ?? '',
              'flavors': data['flavors'],
              'firmness': data['firmness']['name'],
              'growth_time': data['growth_time'],
              'max_harvest': data['max_harvest'],
              'natural_gift_power': data['natural_gift_power'],
            });
          });
        }
      }

      currentPage++;
    } catch (e) {
      print('Error fetching berry data: $e');
      if (berryData.isEmpty) {
        setState(() {
          berryData = [
            {
              'name': 'Error loading Berries',
              'sprite': '',
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
        backgroundColor: Colors.green,
        title: const Text('Berry List'),
      ),
      body: Stack(
        children: [
          BerryList(
            berryData: berryData,
            scrollController: _scrollController,
          ),
          if (isLoading) const LoadingOverlay(),
        ],
      ),
    );
  }
}
