import 'package:flutter/material.dart';
import 'package:malory/services/router.dart';

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == RouterHelper.start) return child;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
