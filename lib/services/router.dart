import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malory/screens/auth_screen.dart';
import 'package:malory/screens/home_screen.dart';

class RouterHelper {
  static const String start = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Home(),
        );
      case "/login":
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AuthScreen(register: false),
        );
      case "/register":
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AuthScreen(register: true),
        );
      default:
        return MaterialPageRoute(
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
