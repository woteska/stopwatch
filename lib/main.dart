import 'package:flutter/material.dart';
import 'package:stopwatch/pages/home.page.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
