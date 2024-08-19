import 'package:flutter/material.dart';
import 'package:timer3/countdown.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF2D2D2D),
        body: Center(
          child: Countdowner(),
        ),
      ),
    );
  }
}
