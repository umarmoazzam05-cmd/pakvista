import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PakVistaApp());
}

class PakVistaApp extends StatelessWidget {
  const PakVistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PakVista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
