import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: InterruptorApp()),
  );
}

class InterruptorApp extends StatefulWidget {
  const InterruptorApp({super.key});

  @override
  _InterruptorAppState createState() => _InterruptorAppState();
}

class _InterruptorAppState extends State<InterruptorApp> {
  bool estadoaceso = false;

  void altenarluz() {
    setState(() {
      estadoaceso = !estadoaceso;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: estadoaceso ? Colors.black : Colors.yellow,

      appBar: AppBar(
        title: Text(
          'interruptor',
          style: TextStyle(color: estadoaceso ? Colors.black : Colors.yellow),
        ),


      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              estadoaceso ? Icons.lightbulb : Icons.lightbulb_outline,
              color: estadoaceso ? Colors.yellow : Colors.black,
              size: 100,
            ),

            // cria o
            ElevatedButton(
              onPressed: altenarluz,
              style: ElevatedButton.styleFrom(
                backgroundColor: estadoaceso ? Colors.yellow : Colors.black,
              ),
              child: estadoaceso
                  ? Text('Acender', style: TextStyle(color: Colors.black))
                  : Text('Apagar', style: TextStyle(color: Colors.yellow)),
            ),

        
          ],

          
        ),
      ),
    );
  }
}
