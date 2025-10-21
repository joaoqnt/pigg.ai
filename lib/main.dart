import 'package:flutter/material.dart';
import 'package:piggai/page/bottom_navigation_page.dart';
import 'package:piggai/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Styles.theme,
      home: BottomNavigationPage()
    );
  }
}
