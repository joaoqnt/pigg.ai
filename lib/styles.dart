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
  static const Color accentColor = persianBlue;

  // 🖋️ Text styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
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
    fontFamily: 'Poppins',

    textTheme: const TextTheme(
      headlineSmall: heading1,
      titleMedium: heading2,
      bodyMedium: body,
      labelLarge: button,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: heading2,
      toolbarTextStyle: body,
      iconTheme: IconThemeData(color: navyBlue),
      actionsIconTheme: IconThemeData(color: navyBlue),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
      hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
