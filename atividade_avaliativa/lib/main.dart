import 'package:flutter/material.dart';
import 'package:path/path.dart' as p; // Corrigido para evitar conflito com 'context'
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: Appatividade(),
    debugShowCheckedModeBanner: false,
  ));
}

class Appatividade extends StatefulWidget {
  const Appatividade({super.key});

  @override
  State<Appatividade> createState() => _AppatividadeState();
}

class _AppatividadeState extends State<Appatividade> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  List<Map<String, dynamic>> tarefa = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  // Configuração do Banco de Dados
  Future<Database> criaBanco() async {
    final caminho = await getDatabasesPath();
    final path = p.join(caminho, "banco_prova.db"); // Uso do p.join

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, data TEXT)"
        );
      },
    );
  }

  // 1. CADASTRAR (Create)
  Future<void> inserirTarefa() async {
    if (tituloController.text.isEmpty) return;

    final db = await criaBanco();
    await db.insert("tarefas", {
      "titulo": tituloController.text,
      "descricao": descController.text,
      "data": DateTime.now().toString().substring(0, 16)
    });

    tituloController.clear();
    descController.clear();
    carregarTarefas();
  }

  // 2. LISTAR (Read)
  Future<void> carregarTarefas() async {
    final db = await criaBanco();
    // Bônus: Ordenar por título
    final lista = await db.query("tarefas", orderBy: "titulo ASC");
    
    setState(() {
      tarefa = lista;
    });
  }

  // 3. REMOVER (Delete)
  Future<void> deletarTarefa(int id) async {
    final db = await criaBanco();
    await db.delete("tarefas", where: "id = ?", whereArgs: [id]);
    carregarTarefas();
  }

  // 4. EDITAR (Update)
  Future<void> atualizarTarefa(int id, String novoT, String novoD) async {
    final db = await criaBanco();
    await db.update(
      "tarefas", 
      {"titulo": novoT, "descricao": novoD}, 
      where: "id = ?", 
      whereArgs: [id]
    );
    carregarTarefas();
  }

  // Modal de Edição (Acessado ao clicar no item)
  void mostrarDialogoEdicao(Map item) {
    TextEditingController editTitulo = TextEditingController(text: item['titulo']);
    TextEditingController editDesc = TextEditingController(text: item['descricao']);

    showDialog(
      context: context,
      builder: (BuildContext context) { // BuildContext explícito
        return AlertDialog(
          title: const Text("Editar Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: editTitulo, decoration: const InputDecoration(labelText: "Título")),
              TextField(controller: editDesc, decoration: const InputDecoration(labelText: "Descrição")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cancelar")
            ),
            ElevatedButton(
              onPressed: () {
                atualizarTarefa(item['id'], editTitulo.text, editDesc.text);
                Navigator.pop(context);
              }, 
              child: const Text("Salvar Alterações")
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro Inteligente"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(labelText: "Título"),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Descrição"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: inserirTarefa,
                  child: const Text("Salvar Item"),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: tarefa.isEmpty
                ? const Center(child: Text("Nenhum item cadastrado", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: tarefa.length,
                    itemBuilder: (context, index) {
                      final item = tarefa[index];
                      return ListTile(
                        title: Text(item["titulo"]),
                        subtitle: Text("${item["descricao"]}\n${item["data"]}"),
                        onTap: () => mostrarDialogoEdicao(item), // Área de edição ao clicar
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deletarTarefa(item["id"]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
