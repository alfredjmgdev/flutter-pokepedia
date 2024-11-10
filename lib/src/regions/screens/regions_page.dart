import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/region_list.dart';
import '../../pokemon-list/widgets/loading_overlay.dart';

class RegionsPage extends StatefulWidget {
  const RegionsPage({super.key});

  @override
  State<RegionsPage> createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  List<Map<String, dynamic>> regionData = [];
  bool isLoading = false;
  int currentPage = 0;
  static const int regionsPerPage = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchRegionData();
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
      fetchRegionData();
    }
  }

  Future<void> fetchRegionData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final startIndex = currentPage * regionsPerPage + 1;
      final endIndex = startIndex + regionsPerPage;

      final futures = List.generate(
        regionsPerPage,
        (index) => http.get(
          Uri.parse('https://pokeapi.co/api/v2/region/${startIndex + index}'),
        ),
      );

      final responses = await Future.wait(futures);
      await Future.delayed(const Duration(seconds: 1));

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            regionData.add({
              'name': data['name'][0].toUpperCase() + data['name'].substring(1),
              'id': data['id'],
            });
          });
        }
      }

      currentPage++;
    } catch (e) {
      print('Error fetching region data: $e');
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
        backgroundColor: Colors.blue,
        title: const Text('Region List'),
      ),
      body: Stack(
        children: [
          RegionList(
            regionData: regionData,
            scrollController: _scrollController,
          ),
          if (isLoading) const LoadingOverlay(),
        ],
      ),
    );
  }
}
