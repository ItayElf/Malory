import 'dart:ui';

import 'package:flutter/cupertino.dart';

double convert(double num) {
  double pixelRatio = window.devicePixelRatio;
  Size logicalScreenSize = window.physicalSize / pixelRatio;
  double logicalWidth = logicalScreenSize.width;
  return logicalWidth * num / 1080;
}