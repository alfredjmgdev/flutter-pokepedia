import 'package:flutter/material.dart';

import 'berry_modal.dart';

class BerryListItem extends StatelessWidget {
  final String name;
  final String sprite;
  final String firmness;
  final int growthTime;
  final int maxHarvest;
  final int naturalGiftPower;
  final List<Map<String, dynamic>> flavors;

  const BerryListItem(
      {super.key,
      required this.name,
      required this.sprite,
      required this.firmness,
      required this.growthTime,
      required this.maxHarvest,
      required this.naturalGiftPower,
      required this.flavors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return BerryModal(
              berryName: name,
              spriteUrl: sprite,
              firmness: firmness,
              growthTime: growthTime,
              maxHarvest: maxHarvest,
              naturalGiftPower: naturalGiftPower,
              flavors: flavors,
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.network(
                sprite,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
