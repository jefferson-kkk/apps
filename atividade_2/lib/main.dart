import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Jefferson"),
            subtitle: Text("(19) 9789-1623"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SegundaTela(
                    nome: "Jefferson",
                    telefone: "(19) 9789-1623",
                  ),
                ),
              );
            },
          ),

          ListTile(
            title: Text("Karina"),
            subtitle: Text("(12) 5643-675"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SegundaTela(
                    nome: "Karina",
                    telefone: "(12) 5643-675",
                  ),
                ),
              );
            },
          ),

          ListTile(
            title: Text("Carlos"),
            subtitle: Text("(11) 9999-8888"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SegundaTela(
                    nome: "Carlos",
                    telefone: "(11) 9999-8888",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SegundaTela extends StatelessWidget {
  final String nome;
  final String telefone;

  const SegundaTela({
    super.key,
    required this.nome,
    required this.telefone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nome,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              telefone,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}