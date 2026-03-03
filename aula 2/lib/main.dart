import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  const PaginaContador({super.key});

  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
  int contador = 0;

  void sortear() {
    setState(() {
      Random random = Random();
      contador = random.nextInt(11);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('xbet')),
      body: Center(
        child: Text("sorteie: $contador", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(onPressed: sortear, child: Icon(Icons.auto_awesome)),
        ],
      ),
    );
  }
}

 

