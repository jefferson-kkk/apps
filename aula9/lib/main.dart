import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppBanco(),
  ));
}

class AppBanco extends StatefulWidget {
  const AppBanco({super.key});

  @override
  State<AppBanco> createState() => _AppBancoState();
}

class _AppBancoState extends State<AppBanco> {
  TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> tarefa = [];
  
  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, "banco.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT)"
        );
      },
    );
  }

  Future<void> inserirTarefa(String nome) async {
    final db = await criarBanco();
    await db.insert("tarefas", {"nome": nome}); 
    carregarTarefas(); 
  }

  Future<void> carregarTarefas() async {
    final db = await criarBanco();
    final lista = await db.query("tarefas");

    setState(() {
      tarefa = lista;
    });
  }

  Future<void> deletarTarefa(int id) async{
    final db = await criarBanco();
    await db.delete("tarefas", where: "id = ?", whereArgs: [id]);
    carregarTarefas();
  }

  @override
  void initState(){
    super.initState();
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        // 1. Corrigido: Removido os parênteses duplos
        title: const Text("App Banco", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            // 2. Corrigido: Adicionado o nome do parâmetro 'padding:'
            padding: const EdgeInsets.all(10), 
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            if (controller.text.isNotEmpty){
              inserirTarefa(controller.text);
              controller.clear();
            }
          },
          child: Text("adicionar"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tarefa.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(tarefa[index]["nome"]),
                  trailing:  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      deletarTarefa(tarefa[index]["id"]);
                    },
                  ),
                );
              },
            ))
        ],
      ),
    ); // 3. Corrigido: Adicionado o ponto e vírgula final
  }
}