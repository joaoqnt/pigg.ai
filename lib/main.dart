import 'package:flutter/material.dart';
import 'package:piggai/page/bottom_navigation_page.dart';
import 'package:piggai/theme/theme.dart';
import 'package:piggai/theme/util_theme.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Inter", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Pigg.ai',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const BottomNavigationPage(),
    );
  }
}