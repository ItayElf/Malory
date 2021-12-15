import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malory/screens/auth_screen.dart';
import 'package:malory/screens/home_screen.dart';
import 'package:malory/screens/lobby_screen.dart';
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
