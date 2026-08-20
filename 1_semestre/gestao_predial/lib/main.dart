import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal SENAI',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF2B2B),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Começa na tela com o botão no topo direito
    );
  }
}