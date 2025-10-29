import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_light.dart';
import 'theme_dark.dart';

class AppTheme {
  static ThemeData light() => buildTheme(lightColorScheme);
  static ThemeData dark() => buildTheme(darkColorScheme);

  static ThemeData buildTheme(ColorScheme scheme) => ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: scheme.brightness,
    scaffoldBackgroundColor: scheme.surface,
    canvasColor: scheme.surface,

    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    ),


    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: scheme.onSurface,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 14,color: scheme.onSurface)
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: scheme.surfaceContainerLow,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    // listTileTheme: ListTileThemeData(
    //   iconColor: scheme.onSurfaceVariant,
    //   selectedColor: scheme.primary,
    //   selectedTileColor: scheme.primary.withOpacity(0.15),
    // ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primary.withOpacity(0.18),
      elevation: 0,
      labelTextStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(
          fontWeight: states.contains(MaterialState.selected)
              ? FontWeight.w600
              : FontWeight.w400,
          color: states.contains(MaterialState.selected)
              ? scheme.primary
              : scheme.onSurfaceVariant,
        ),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: scheme.surfaceContainerHigh,
      contentTextStyle: TextStyle(color: scheme.onSurface),
      actionTextColor: scheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(color: scheme.onSurface),
    ),
  );
}
