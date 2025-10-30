import 'package:flutter/material.dart';

class CustomSlideAction {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  CustomSlideAction({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  });
}
