import 'package:flutter/material.dart';
import 'package:test_chart/screens/first_loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Size deviceSize = const Size(1, 1);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstLoadingScreen(),
    );
  }
}
