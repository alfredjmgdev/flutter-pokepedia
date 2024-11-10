import 'package:flutter/material.dart';
import '../berries/screens/berries_page.dart';
import '../home/screens/home_page.dart';
import '../pokemon-list/screens/start_page.dart';
import '../menu/screens/menu_page.dart';
import '../regions/screens/regions_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const MyHomePage(),
    '/pokemon-list': (context) => const StartPage(),
    '/menu': (context) => const MenuPage(),
    '/berries': (context) => const BerriesPage(),
    '/regions': (context) => const RegionsPage(),
  };
}
