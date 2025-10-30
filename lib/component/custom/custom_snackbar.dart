import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required AnimatedSnackBarType type,
    Duration duration = const Duration(seconds: 5),
    MobileSnackBarPosition mobilePosition = MobileSnackBarPosition.top,
    DesktopSnackBarPosition desktopPosition = DesktopSnackBarPosition.topCenter,
  }) {
    AnimatedSnackBar.material(
      message,
      type: type,
      duration: duration,
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 100,
      ),
      mobileSnackBarPosition: mobilePosition,
      desktopSnackBarPosition: desktopPosition,
    ).show(context);
  }
}