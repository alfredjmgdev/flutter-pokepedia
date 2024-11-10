import 'package:flutter/material.dart';
import '../widgets/menu_items_list.dart';
import '../widgets/menu_app_bar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MenuAppBar(),
      body: Center(
        child: MenuItemsList(),
      ),
    );
  }
}
