import 'package:flutter/material.dart';
import 'package:timer3/countdown.dart';
import 'package:timer3/small_task.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF2D2D2D),
        body: Center(
          child: Column(
            children: [
              const Countdowner(),
              SmallTask(
                list: const [
                  'first',
                  'second',
                  'third',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
