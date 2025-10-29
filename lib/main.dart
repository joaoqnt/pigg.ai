import 'package:flutter/material.dart';
import 'package:piggai/page/bottom_navigation_page.dart';
import 'package:piggai/theme/app_theme.dart';
import 'package:piggai/theme/util_theme.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Pigg.ai',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const BottomNavigationPage(),
    );
  }
}