import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:piggai/page/bottom_navigation_page.dart';
import 'package:piggai/page/setup/onboarding_page.dart';
import 'package:piggai/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isFirstAccess() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("first_access_done") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pigg.ai',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,

      // Definição dinâmica da home
      home: FutureBuilder<bool>(
        future: isFirstAccess(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final alreadyDoneSetup = snapshot.data!;

          /// Se já fez o onboarding, vai pro app
          return alreadyDoneSetup
              ? const BottomNavigationPage()
              : OnboardingIntroPage();
        },
      ),
    );
  }
}
