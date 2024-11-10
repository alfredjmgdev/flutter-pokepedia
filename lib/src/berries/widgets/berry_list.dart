import 'package:flutter/material.dart';
import 'berry_list_item.dart';

class BerryList extends StatelessWidget {
  final List<Map<String, dynamic>> berryData;
  final ScrollController scrollController;

  const BerryList({
    super.key,
    required this.berryData,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: berryData.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final berry = berryData[index];

        return BerryListItem(
          name: berry['name']!,
          sprite: berry['sprite']!,
          firmness: berry['firmness'],
          growthTime: berry['growth_time'],
          maxHarvest: berry['max_harvest'],
          naturalGiftPower: berry['natural_gift_power'],
          flavors: List<Map<String, dynamic>>.from(berry['flavors']),
        );
      },
    );
  }
}
