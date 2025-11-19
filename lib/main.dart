import 'package:flutter/material.dart';
import 'package:workshop1/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G-Store Demo',
      home: const HomeScreen(),
    );
  }
}