import 'package:flutter/material.dart';
import 'package:malory/screens/auth_screen.dart';
import 'package:malory/screens/home_screen.dart';
import 'package:malory/screens/lobby_screen.dart';
import 'package:malory/screens/rooms_screen.dart';
import 'package:malory/screens/unit_selection_screen.dart';
import 'package:malory/screens/wiki/units_screen.dart';
import 'package:malory/screens/wiki/wiki_screen.dart';
import 'package:malory/services/custom_page_route.dart';

class RouterHelper {
  static const String start = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return CustomPageRoute(
          settings: settings,
          builder: (_) => const Home(),
        );
      case "/login":
        return CustomPageRoute(
          settings: settings,
          builder: (_) => const AuthScreen(register: false),
        );
      case "/register":
        return CustomPageRoute(
          settings: settings,
          builder: (_) => const AuthScreen(register: true),
        );
      case "/lobby":
        return CustomPageRoute(
          builder: (_) => const Lobby(),
          settings: settings,
        );
      case "/wiki":
        return CustomPageRoute(
          builder: (_) => const Wiki(),
          settings: settings,
        );
      case "/units":
        return CustomPageRoute(
          builder: (_) => const UnitsScreen(),
          settings: settings,
        );
      case "/rooms":
        return CustomPageRoute(
          builder: (_) => const RoomScreen(),
          settings: settings,
        );
      case "/unit_selection":
        return CustomPageRoute(
          builder: (_) => const UnitSelectionScreen(),
          settings: settings,
        );
      default:
        return CustomPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
