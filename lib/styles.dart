import 'package:flutter/material.dart';

class Styles {
  // 🎨 Paleta de cores
  static const Color ultramarine = Color(0xFF1106A2);
  static const Color blueMarguerite = Color(0xFF695FC4);
  static const Color snuff = Color(0xFFE4E0F3);
  static const Color persianBlue = Color(0xFF311EAA);
  static const Color navyBlue = Color(0xFF050192);

  static const Color primaryColor = ultramarine;
  static const Color secondaryColor = blueMarguerite;
  static const Color backgroundColor = snuff;
  static const Color textColor = navyBlue;
  static const Color accentColor = persianBlue;

  // 🖋️ Text styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 🎯 Botões padrão
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    textStyle: button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
  );

  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    textStyle: button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // 🧠 Tema global
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
    fontFamily: 'Roboto',

    // TextTheme global
    textTheme: const TextTheme(
      headlineSmall: heading1,
      titleMedium: heading2,
      bodyMedium: body,
      labelLarge: button,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: heading2,
      toolbarTextStyle: body,
      iconTheme: IconThemeData(color: navyBlue),
      actionsIconTheme: IconThemeData(color: navyBlue),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
    ),


    // Input
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.grey),
      hintStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
