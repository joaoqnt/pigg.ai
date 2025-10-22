import 'package:flutter/material.dart';

class ColorUtil{
  Color darken(Color color, [double amount = 0.2]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark =
    hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color formatColor(String color){
    return Color(
      int.parse(color.replaceFirst('#', '0xFF')),
    );
  }
}