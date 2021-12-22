import 'dart:ui';

import 'package:flutter/material.dart';

double convert(double num) {
  double pixelRatio = window.devicePixelRatio;
  Size logicalScreenSize = window.physicalSize / pixelRatio;
  double logicalWidth = logicalScreenSize.width;
  return logicalWidth * num / 1080;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: convert(18)),
      ),
    ),
  );
}
