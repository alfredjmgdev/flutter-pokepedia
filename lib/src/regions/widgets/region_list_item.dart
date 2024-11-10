import 'package:flutter/material.dart';

class RegionListItem extends StatelessWidget {
  final String name;
  final int id;

  const RegionListItem({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('Region ID: $id'),
      onTap: () {
        // Handle tap if needed
      },
    );
  }
}
