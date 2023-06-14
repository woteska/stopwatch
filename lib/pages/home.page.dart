import 'package:flutter/material.dart';
import 'package:stopwatch/widgets/stopwatch.widget.dart';

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
          body: SafeArea(
        child: StopwatchWidget(),
      ));
    });
  }
}
