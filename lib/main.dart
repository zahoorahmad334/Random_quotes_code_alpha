import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system, // Automatically switches based on system settings
      home: const HomePage(),
    );
  }
}
