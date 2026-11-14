import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SeGrupApp());
}

class SeGrupApp extends StatelessWidget {
  const SeGrupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeGrup',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(), // Memulai dari Splash Screen
    );
  }
}