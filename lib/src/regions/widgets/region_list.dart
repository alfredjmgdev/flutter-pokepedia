import 'package:flutter/material.dart';
import 'region_list_item.dart';

class RegionList extends StatelessWidget {
  final List<Map<String, dynamic>> regionData;
  final ScrollController scrollController;

  const RegionList({
    super.key,
    required this.regionData,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: regionData.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final region = regionData[index];

        return RegionListItem(
          name: region['name']!,
          id: region['id'],
        );
      },
    );
  }
}
