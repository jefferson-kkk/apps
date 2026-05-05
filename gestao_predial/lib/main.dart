import 'package:flutter/material.dart';

// 1. IMPORTAÇÃO DO SEGUNDO ARQUIVO
// Certifique-se de que o nome do arquivo seja exatamente esse.
import 'main2.dart'; 

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

// ==========================================
// TELA 1: DASHBOARD (INICIAL)
// ==========================================
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  final String linkLogoSenai =
      'https://upload.wikimedia.org/wikipedia/commons/8/8c/SENAI_S%C3%A3o_Paulo_logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 1. A BARRA SUPERIOR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 140,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  linkLogoSenai,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton(
              onPressed: () {
                // 2. A NAVEGAÇÃO DIRETA PARA O MAIN2.DART
                // Aqui chamamos exatamente a classe PredialFixApp que está no main2.dart
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => const PredialFixApp()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Entrar"),
            ),
          ),
        ],
      ),

      // 2. O MENU LATERAL (DRAWER)
      drawer: Drawer(
        backgroundColor: const Color(0xFFFF2424), // Fundo vermelho
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 60.0, left: 20.0, bottom: 25.0), 
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  color: Colors.white,
                  child: Image.network(
                    linkLogoSenai,
                    width: 130, 
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const Divider(
              color: Colors.white,
              thickness: 1, 
              height: 1,
            ),

            const SizedBox(height: 10), 

            _criarItemMenu(context, 'Chamado'),
            _criarItemMenu(context, 'Colaborador'),
            _criarItemMenu(context, 'Setores'),
            _criarItemMenu(context, 'Empresa'),
            _criarItemMenu(context, 'Patrimônio'),
            _criarItemMenu(context, 'Responsável'),
          ],
        ),
      ),

      // 3. O CORPO DA TELA
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          "DashBoard",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _criarItemMenu(BuildContext context, String titulo) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}