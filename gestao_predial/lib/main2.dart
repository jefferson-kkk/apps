import 'package:flutter/material.dart';

// Removemos o void main() e o MaterialApp daqui!
// Deixamos apenas a classe que constrói a tela.

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Center(
        child: Text(
          "Esta é a tela de Login.\n(Adicione seus campos de email e senha aqui)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}