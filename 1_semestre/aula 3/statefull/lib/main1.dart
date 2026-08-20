import 'package:flutter/material.dart';

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

  void increment() {
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('meu app interativo')),
      body: Center(
        child: Text("cliques: $contador", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(onPressed: increment, child: Icon(Icons.add)),
          SizedBox(height: 10),
          FloatingActionButton(onPressed: decrement, child: Icon(Icons.remove)),
          FloatingActionButton(onPressed: indecrement, child: Icon(Icons.delete)),
        ],
      ),
    );
  }

  void decrement() {
    setState(() {
      contador--;
    });
  }
    void indecrement() {
    setState(() {
      contador = 0;
    });
  }
}
