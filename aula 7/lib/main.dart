import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TelaInicial()));
}

//------- tela 1-------
class TelaInicial extends StatelessWidget {
  final String nome = "jefferson";
  const TelaInicial({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("tela inicial"), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          child: Text("próximo"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SegundaTela(nome: nome)),
            );
          },
        ),
      ),
    );
  }
}

//------- tela 2-------
class SegundaTela extends StatelessWidget {
  const SegundaTela({super.key, required this.nome});
    final String nome; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("segunda tela"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bem vindo! a", style: TextStyle(color: Colors.black, fontSize: 30),),
          Text("segunda tela", style: TextStyle(color: Colors.green, fontWeight: FontWeight(900), fontSize: 40),),
        ]),
      ),
    );
  }
}
