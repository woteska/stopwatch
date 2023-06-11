import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Placeholder(),
            )
          ],
        ),
      );
    });
  }
}
