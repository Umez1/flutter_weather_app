import 'package:flutter/material.dart';
import 'weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // CHANGED: from StatelessWidget → StatefulWidget
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState(); // NEW
}

class _MyAppState extends State<MyApp> {
  // NEW: theme state manager
  ThemeMode _themeMode = ThemeMode.system; // NEW: start with system setting

  void _toggleTheme() {
    // NEW: toggle logic
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // NEW: Light theme
      darkTheme: ThemeData.dark(), // NEW: Dark theme
      themeMode: _themeMode, // NEW: use our theme mode
      home: WeatherPage(onToggleTheme: _toggleTheme), // CHANGED: pass function
    );
  }
}
