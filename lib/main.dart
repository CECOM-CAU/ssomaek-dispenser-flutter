import 'package:flutter/material.dart';
import 'pages/mixing_page.dart';

void main() {
  runApp(const SojuBeerApp());
}

class SojuBeerApp extends StatelessWidget {
  const SojuBeerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CECOM Mixer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MixingPage(),
    );
  }
}
