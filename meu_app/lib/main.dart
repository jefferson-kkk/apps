import 'package:flutter/material.dart';

void main() {
  runApp(meuapp());
}

class meuapp extends StatelessWidget {
  const meuapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            // ação do botão (depois você pode adicionar uma tarefa aqui)
          },
        ),
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(
            'lista de tarefa',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('estudar flutter'),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('praticar o dart'),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('criar app'),
              trailing: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
