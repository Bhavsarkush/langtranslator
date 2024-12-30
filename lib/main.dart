import 'package:flutter/material.dart';
import 'Language Translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Translator',
      theme: ThemeData(
        primaryColor: const Color(0xFF0089ba),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0089ba)),
        useMaterial3: true,
      ),
      home: const lang(),
    );
  }
}

