import 'package:flutter/material.dart';

class Styles {
  // 🎨 Paleta de cores suavizada
  static const Color primaryColor = Color(0xFF4B4EA0);
  static const Color secondaryColor = Color(0xFF8B84C7);
  static const Color accentColor = Color(0xFF5D52A7);
  static Color backgroundColor = Color(0xFFF8F8FA);
  static const Color textColor = Colors.black87;

  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: textColor,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
  );

  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    textStyle: button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    minimumSize: const Size(double.infinity, 50),
  );

  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    textStyle: button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );


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

    // ✅ AppBar clean
    appBarTheme: const AppBarTheme(
      elevation: 2,
      titleTextStyle: heading2,
      toolbarTextStyle: body,
      iconTheme: IconThemeData(color: textColor),
      actionsIconTheme: IconThemeData(color: textColor),
    ),

    // ✅ FAB leve
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      // Texto compacto
      extendedTextStyle: button.copyWith(
        fontWeight: FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordas menos arredondadas
      ),
    ),


    // ✅ PopupMenuButton
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        menuPadding: EdgeInsets.zero,
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
        position: PopupMenuPosition.under,
        elevation: 1,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
        ),
      ),

      textTheme: const TextTheme(
      headlineSmall: heading1,
      titleMedium: heading2,
      bodyMedium: body,
      labelLarge: button,
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

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(24)
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
      hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
    )
  );
}
