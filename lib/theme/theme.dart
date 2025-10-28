import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff406835),
      surfaceTint: Color(0xff406835),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc1efaf),
      onPrimaryContainer: Color(0xff294f20),
      secondary: Color(0xff54634d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd7e8cc),
      onSecondaryContainer: Color(0xff3d4b37),
      tertiary: Color(0xff386668),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd4f3f6),
      onTertiaryContainer: Color(0xff1e4d50),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffffffff),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff43483f),
      outline: Color(0xff73796e),
      outlineVariant: Color(0xffc3c8bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inversePrimary: Color(0xffa6d395),
      primaryFixed: Color(0xffc1efaf),
      onPrimaryFixed: Color(0xff012200),
      primaryFixedDim: Color(0xffa6d395),
      onPrimaryFixedVariant: Color(0xff294f20),
      secondaryFixed: Color(0xffd7e8cc),
      onSecondaryFixed: Color(0xff121f0e),
      secondaryFixedDim: Color(0xffbbcbb1),
      onSecondaryFixedVariant: Color(0xff3d4b37),
      tertiaryFixed: Color(0xffbcebee),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xffa0cfd2),
      onTertiaryFixedVariant: Color(0xff1e4d50),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff8fbf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3f3),
      surfaceContainer: Color(0xffecefe5),
      surfaceContainerHigh: Color(0xffe6e9df),
      surfaceContainerHighest: Color(0xffe1e4da),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff183e10),
      surfaceTint: Color(0xff406835),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f7742),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2c3a27),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff62715b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff073d3f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff477477),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8fbf0),
      onSurface: Color(0xff0f120d),
      onSurfaceVariant: Color(0xff32382f),
      outline: Color(0xff4e544a),
      outlineVariant: Color(0xff696f64),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inversePrimary: Color(0xffa6d395),
      primaryFixed: Color(0xff4f7742),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff375e2c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff62715b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a5944),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff477477),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2e5c5e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c8be),
      surfaceBright: Color(0xfff8fbf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffe6e9df),
      surfaceContainerHigh: Color(0xffdbded4),
      surfaceContainerHighest: Color(0xffd0d3c9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0d3407),
      surfaceTint: Color(0xff406835),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c5222),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff22301e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3f4d39),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003234),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff215053),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8fbf0),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282e25),
      outlineVariant: Color(0xff454b41),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inversePrimary: Color(0xffa6d395),
      primaryFixed: Color(0xff2c5222),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff153a0d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3f4d39),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff293624),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff215053),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff02393c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7bab1),
      surfaceBright: Color(0xfff8fbf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff2e8),
      surfaceContainer: Color(0xffe1e4da),
      surfaceContainerHigh: Color(0xffd3d6cc),
      surfaceContainerHighest: Color(0xffc5c8be),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa6d395),
      surfaceTint: Color(0xffa6d395),
      onPrimary: Color(0xff12380b),
      primaryContainer: Color(0xff294f20),
      onPrimaryContainer: Color(0xffc1efaf),
      secondary: Color(0xffbbcbb1),
      onSecondary: Color(0xff273422),
      secondaryContainer: Color(0xff3d4b37),
      onSecondaryContainer: Color(0xffd7e8cc),
      tertiary: Color(0xffa0cfd2),
      onTertiary: Color(0xff003739),
      tertiaryContainer: Color(0xff1e4d50),
      onTertiaryContainer: Color(0xffbcebee),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff11140f),
      onSurface: Color(0xffe1e4da),
      onSurfaceVariant: Color(0xffc3c8bc),
      outline: Color(0xff8d9387),
      outlineVariant: Color(0xff43483f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4da),
      inversePrimary: Color(0xff406835),
      primaryFixed: Color(0xffc1efaf),
      onPrimaryFixed: Color(0xff012200),
      primaryFixedDim: Color(0xffa6d395),
      onPrimaryFixedVariant: Color(0xff294f20),
      secondaryFixed: Color(0xffd7e8cc),
      onSecondaryFixed: Color(0xff121f0e),
      secondaryFixedDim: Color(0xffbbcbb1),
      onSecondaryFixedVariant: Color(0xff3d4b37),
      tertiaryFixed: Color(0xffbcebee),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xffa0cfd2),
      onTertiaryFixedVariant: Color(0xff1e4d50),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff373a34),
      surfaceContainerLowest: Color(0xff0c0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff32362f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbbe9a9),
      surfaceTint: Color(0xffa6d395),
      onPrimary: Color(0xff062d02),
      primaryContainer: Color(0xff719c63),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd1e1c6),
      onSecondary: Color(0xff1c2917),
      secondaryContainer: Color(0xff86957d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb6e5e8),
      onTertiary: Color(0xff002b2d),
      tertiaryContainer: Color(0xff6b999b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9ded1),
      outline: Color(0xffaeb4a8),
      outlineVariant: Color(0xff8c9287),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4da),
      inversePrimary: Color(0xff2a5121),
      primaryFixed: Color(0xffc1efaf),
      onPrimaryFixed: Color(0xff011600),
      primaryFixedDim: Color(0xffa6d395),
      onPrimaryFixedVariant: Color(0xff183e10),
      secondaryFixed: Color(0xffd7e8cc),
      onSecondaryFixed: Color(0xff081405),
      secondaryFixedDim: Color(0xffbbcbb1),
      onSecondaryFixedVariant: Color(0xff2c3a27),
      tertiaryFixed: Color(0xffbcebee),
      onTertiaryFixed: Color(0xff001415),
      tertiaryFixedDim: Color(0xffa0cfd2),
      onTertiaryFixedVariant: Color(0xff073d3f),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff42463f),
      surfaceContainerLowest: Color(0xff050804),
      surfaceContainerLow: Color(0xff1b1f19),
      surfaceContainer: Color(0xff252923),
      surfaceContainerHigh: Color(0xff30342d),
      surfaceContainerHighest: Color(0xff3b3f38),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcefdbb),
      surfaceTint: Color(0xffa6d395),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa2cf91),
      onPrimaryContainer: Color(0xff000f00),
      secondary: Color(0xffe5f5d9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7c7ad),
      onSecondaryContainer: Color(0xff040e02),
      tertiary: Color(0xffc9f9fb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9ccbce),
      onTertiaryContainer: Color(0xff000e0f),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff11140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf2e5),
      outlineVariant: Color(0xffbfc4b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4da),
      inversePrimary: Color(0xff2a5121),
      primaryFixed: Color(0xffc1efaf),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa6d395),
      onPrimaryFixedVariant: Color(0xff011600),
      secondaryFixed: Color(0xffd7e8cc),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbbcbb1),
      onSecondaryFixedVariant: Color(0xff081405),
      tertiaryFixed: Color(0xffbcebee),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa0cfd2),
      onTertiaryFixedVariant: Color(0xff001415),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff4d514a),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d211b),
      surfaceContainer: Color(0xff2e322b),
      surfaceContainerHigh: Color(0xff393d36),
      surfaceContainerHighest: Color(0xff444841),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
    cardTheme: CardTheme(
      elevation: 0,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      scrolledUnderElevation: 0,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
      contentTextStyle: TextStyle(color: colorScheme.onSurface),
      titleTextStyle: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
    ),


    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
      ),
      modalBarrierColor: colorScheme.scrim.withOpacity(0.4),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.surfaceContainerHigh,
      contentTextStyle: TextStyle(color: colorScheme.onSurface),
      actionTextColor: colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
    ),


  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
