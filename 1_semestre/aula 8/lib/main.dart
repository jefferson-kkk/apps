import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: SalvarTextoApp()),
  );
}

class SalvarTextoApp extends StatefulWidget {
  const SalvarTextoApp({super.key});

  @override
  State<SalvarTextoApp> createState() => _SalvarTextoAppState();
}

class _SalvarTextoAppState extends State<SalvarTextoApp> {
  TextEditingController controller = TextEditingController();
  String textosalvo = "";

  void salvarTexto() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("texto", controller.text);

    setState(() {
      textosalvo = controller.text;
    });
  }

  void carregarTexto() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      textosalvo = prefs.getString("texto") ?? "";
    });
  }

  @override
  void initState(){
  super.initState();
  carregarTexto();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("salvar Dados")),
      body: Padding(
        padding:EdgeInsets.all(20),
        child:Column(
          children: [
            TextField(
              controller:controller,
              decoration: InputDecoration( labelText: "digite algo"), 
            ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvarTexto,
                child: Text("salvar"),
              ),
              Text(textosalvo),
                  ],
                ),
            ),
        );
  }
}