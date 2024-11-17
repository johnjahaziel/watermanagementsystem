import 'package:flutter/material.dart';
import 'package:watertank/watertank.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Watertank(),
        Watertank.id : (context) => const Watertank()
      },
    );
  }
}
