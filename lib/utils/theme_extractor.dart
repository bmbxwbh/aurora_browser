import 'package:flutter/material.dart';

class ThemeExtractor {
  static Color extractFromUrl(String url) {
    final hash = url.hashCode;
    final hue = (hash.abs() % 360);
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.6, 0.6).toColor();
  }
}
